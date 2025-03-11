import 'dart:math' as math;

import 'package:jre_app/theme/bloc/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:jre_app/ui/language/ui/language_page.dart';

import '../../../not_fond_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _housesController;
  late AnimationController _pulseFadeController;

  late Animation<double> _skylineAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _pulseAnimation;

  // House properties
  final List<HouseData> _houses = [];
  final int _houseCount = 30;

  // Farm house color variations based on JRE flag colors
  final List<Color> _houseColors = [
    Color(0xFF008000),      // Green - assuming JRE flag has green
    Color(0xFF00A000),      // Lighter green variation
    Color(0xFF006000),      // Darker green variation
    Color(0xFFFFFFFF),      // White - assuming JRE flag has white
    Color(0xFFF0F0F0),      // Off-white variation
  ];

  @override
  void initState() {
    super.initState();

    // Generate random houses
    _generateHouses();

    // Main animation controller for logo
    _mainController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Animation controller for houses
    _housesController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    // Animation controller for JRE text pulsing/fading
    _pulseFadeController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Skyline appears first
    _skylineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    // Text appears second
    _textAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 0.8, curve: Curves.ease),
      ),
    );

    // Subtle pulse animation for the JRE text
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseFadeController,
        curve: Curves.ease,
      ),
    );

    // Start the animation
    _mainController.forward();
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LanguageScreen()),
        );
      }
    });
  }

  void _generateHouses() {
    final random = math.Random();

    // Create small moving houses
    for (int i = 0; i < _houseCount; i++) {
      // Select random house color from JRE flag colors
      final color = _houseColors[random.nextInt(_houseColors.length)]
          .withOpacity(random.nextDouble() * 0.3 + 0.3); // Slightly more opaque

      // Create different shaped houses that resemble elements from the JRE flag
      // Use more of type 0 (standard houses) to match the flag's primary shape
      final houseType = random.nextDouble() < 0.6 ? 0 : random.nextInt(3);

      _houses.add(
        HouseData(
          size: random.nextDouble() * 25 + 15, // House size between 15-40
          position: Offset(
            random.nextDouble() * 500 - 100, // X position from -100 to 400
            random.nextDouble() * 1000 - 100, // Y position from -100 to 900
          ),
          color: color,
          speed: random.nextDouble() * 1.2 + 0.4, // Slightly slower movement for better visibility
          direction: random.nextDouble() * 2 * math.pi, // Random direction in radians
          pulseSpeed: random.nextDouble() * 1.5 + 0.8, // Adjusted pulse speed
          houseType: houseType,
          rotation: random.nextDouble() * 0.15 - 0.075, // Smaller rotation for less tilt
        ),
      );
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _housesController.dispose();
    _pulseFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
          animation: Listenable.merge([_housesController, _mainController, _pulseFadeController]),
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // Background houses
                ..._houses.map((house) {
                  // Calculate updated position based on animation and house's speed/direction
                  final moveProgress = (_housesController.value * house.speed) % 1.0;
                  final pulseProgress = (_housesController.value * house.pulseSpeed) % 1.0;

                  // Fix: Ensure opacity is between 0.0 and 1.0
                  final houseOpacity = (0.4 + 0.3 * math.sin(pulseProgress * 2 * math.pi))
                      .clamp(0.0, 1.0);

                  return Positioned(
                    left: house.position.dx + math.cos(house.direction) * 80 * moveProgress,
                    top: house.position.dy + math.sin(house.direction) * 80 * moveProgress,
                    child: Opacity(
                      opacity: houseOpacity,
                      child: Transform.rotate(
                        angle: house.rotation,
                        child: _buildHouseShape(house, pulseProgress),
                      ),
                    ),
                  );
                }).toList(),

                // Logo centered in the screen
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Skyline image with fade-in
                      FadeTransition(
                        opacity: _skylineAnimation,
                        child: Transform.translate(
                          offset: Offset(5, (1 - _skylineAnimation.value) * -90),
                          child: Image.asset(
                            'assets/images/jre_flag.png', // Your skyline PNG with flags
                            width: 400,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Animated #JRE text with fade and pulse effects
                      AnimatedBuilder(
                        animation: _textAnimation,
                        builder: (context, child) {
                          if (_textAnimation.value == 0) {
                            return const SizedBox(height: 6); // Space placeholder
                          }
                          // Fix: Ensure text opacity doesn't exceed 1.0
                          final textOpacity = _textAnimation.value.clamp(0.0, 1.0);

                          return Opacity(
                            opacity: textOpacity,
                            child: Transform.scale(
                              scale: _textAnimation.value * _pulseAnimation.value,
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  // Fix: Ensure gradient opacity is within valid range
                                  final gradientOpacity = (0.7 + (_pulseFadeController.value * 0.2))
                                      .clamp(0.0, 1.0);
                                  return LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.white.withOpacity(gradientOpacity),
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Image.asset(
                                  'assets/images/jre_text.png', // Your #JRE text PNG
                                  width: 400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  // Helper method to build different house shapes
  Widget _buildHouseShape(HouseData house, double pulseProgress) {
    final baseSize = house.size * (0.9 + 0.1 * math.sin(pulseProgress * 2 * math.pi));

    switch (house.houseType) {
      case 0: // Standard house with triangular roof
        return CustomPaint(
          size: Size(baseSize, baseSize),
          painter: StandardHousePainter(color: house.color),
        );
      case 1: // Barn shape
        return CustomPaint(
          size: Size(baseSize, baseSize),
          painter: BarnPainter(color: house.color),
        );
      case 2: // Cottage shape
        return CustomPaint(
          size: Size(baseSize, baseSize),
          painter: CottagePainter(color: house.color),
        );
      default:
        return Container(); // Fallback
    }
  }
}

// Custom painter for standard house
class StandardHousePainter extends CustomPainter {
  final Color color;

  StandardHousePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw house shadow
    final shadowPath = Path();
    shadowPath.moveTo(size.width * 0.1, size.height * 0.5);
    shadowPath.lineTo(size.width * 0.1, size.height * 0.9);
    shadowPath.lineTo(size.width * 0.9, size.height * 0.9);
    shadowPath.lineTo(size.width * 0.9, size.height * 0.5);
    shadowPath.close();

    // Draw roof shadow
    shadowPath.moveTo(size.width * 0, size.height * 0.5);
    shadowPath.lineTo(size.width * 0.5, size.height * 0.1);
    shadowPath.lineTo(size.width * 1.0, size.height * 0.5);
    shadowPath.close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw house base
    final basePath = Path();
    basePath.moveTo(size.width * 0.1, size.height * 0.5);
    basePath.lineTo(size.width * 0.1, size.height * 0.9);
    basePath.lineTo(size.width * 0.9, size.height * 0.9);
    basePath.lineTo(size.width * 0.9, size.height * 0.5);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Draw roof
    final roofPath = Path();
    roofPath.moveTo(size.width * 0, size.height * 0.5);
    roofPath.lineTo(size.width * 0.5, size.height * 0.1);
    roofPath.lineTo(size.width * 1.0, size.height * 0.5);
    roofPath.close();

    // Use slightly darker color for roof
    final roofPaint = Paint()
      ..color = darkenColor(color, 0.2)
      ..style = PaintingStyle.fill;

    canvas.drawPath(roofPath, roofPaint);

    // Draw door
    final doorPaint = Paint()
      ..color = darkenColor(color, 0.4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.4,
            size.height * 0.65,
            size.width * 0.2,
            size.height * 0.25
        ),
        doorPaint
    );

    // Draw window
    final windowPaint = Paint()
      ..color = Colors.white.withOpacity(color.opacity)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.2,
            size.height * 0.6,
            size.width * 0.15,
            size.height * 0.15
        ),
        windowPaint
    );

    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.65,
            size.height * 0.6,
            size.width * 0.15,
            size.height * 0.15
        ),
        windowPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom painter for barn
class BarnPainter extends CustomPainter {
  final Color color;

  BarnPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw shadow
    final shadowPath = Path();
    // Barn base
    shadowPath.moveTo(size.width * 0.1, size.height * 0.4);
    shadowPath.lineTo(size.width * 0.1, size.height * 0.9);
    shadowPath.lineTo(size.width * 0.9, size.height * 0.9);
    shadowPath.lineTo(size.width * 0.9, size.height * 0.4);
    // Roof
    shadowPath.lineTo(size.width * 0.75, size.height * 0.2);
    shadowPath.lineTo(size.width * 0.5, size.height * 0.1);
    shadowPath.lineTo(size.width * 0.25, size.height * 0.2);
    shadowPath.close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw barn
    final path = Path();
    // Barn base
    path.moveTo(size.width * 0.1, size.height * 0.4);
    path.lineTo(size.width * 0.1, size.height * 0.9);
    path.lineTo(size.width * 0.9, size.height * 0.9);
    path.lineTo(size.width * 0.9, size.height * 0.4);
    // Roof
    path.lineTo(size.width * 0.75, size.height * 0.2);
    path.lineTo(size.width * 0.5, size.height * 0.1);
    path.lineTo(size.width * 0.25, size.height * 0.2);
    path.close();

    canvas.drawPath(path, paint);

    // Draw barn door
    final doorPaint = Paint()
      ..color = darkenColor(color, 0.4)
      ..style = PaintingStyle.fill;

    // Double barn door
    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.35,
            size.height * 0.6,
            size.width * 0.15,
            size.height * 0.3
        ),
        doorPaint
    );

    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.5,
            size.height * 0.6,
            size.width * 0.15,
            size.height * 0.3
        ),
        doorPaint
    );

    // Draw small window in roof peak
    final windowPaint = Paint()
      ..color = Colors.white.withOpacity(color.opacity)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
        Rect.fromLTWH(
            size.width * 0.425,
            size.height * 0.2,
            size.width * 0.15,
            size.height * 0.1
        ),
        windowPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom painter for cottage
class CottagePainter extends CustomPainter {
  final Color color;

  CottagePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw cottage shadow
    final shadowPath = Path();
    shadowPath.moveTo(size.width * 0.2, size.height * 0.4);
    shadowPath.lineTo(size.width * 0.2, size.height * 0.85);
    shadowPath.lineTo(size.width * 0.8, size.height * 0.85);
    shadowPath.lineTo(size.width * 0.8, size.height * 0.4);
    shadowPath.close();

    // Draw roof shadow
    shadowPath.moveTo(size.width * 0.1, size.height * 0.4);
    shadowPath.lineTo(size.width * 0.5, size.height * 0.15);
    shadowPath.lineTo(size.width * 0.9, size.height * 0.4);
    shadowPath.close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw cottage base
    final basePath = Path();
    basePath.moveTo(size.width * 0.2, size.height * 0.4);
    basePath.lineTo(size.width * 0.2, size.height * 0.85);
    basePath.lineTo(size.width * 0.8, size.height * 0.85);
    basePath.lineTo(size.width * 0.8, size.height * 0.4);
    basePath.close();
    canvas.drawPath(basePath, paint);

    // Use color from green JRE palettes for roof if base is white
    final Color roofColor;
    if (color.red > 200 && color.green > 200 && color.green > 200) {
      // If the cottage is white/light colored, use a green roof
      roofColor = Color(0xFF00A000);
    } else {
      // Otherwise use a darker version of the cottage color
      roofColor = darkenColor(color, 0.2);
    }

    // Draw roof
    final roofPath = Path();
    roofPath.moveTo(size.width * 0.1, size.height * 0.4);
    roofPath.lineTo(size.width * 0.5, size.height * 0.15);
    roofPath.lineTo(size.width * 0.9, size.height * 0.4);
    roofPath.close();

    final roofPaint = Paint()
      ..color = roofColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(roofPath, roofPaint);

    // Choose door color based on house base color
    final Color doorColor = darkenColor(
        color.red > 200 && color.green > 200 && color.blue > 200
            ? Color(0xFF008000) // Green door for white houses
            : color,
        0.3
    );

    // Draw door
    final doorPaint = Paint()
      ..color = doorColor
      ..style = PaintingStyle.fill;

    // Arched door
    final doorPath = Path();
    doorPath.moveTo(size.width * 0.4, size.height * 0.85);
    doorPath.lineTo(size.width * 0.4, size.height * 0.65);
    doorPath.quadraticBezierTo(
        size.width * 0.5, size.height * 0.55,
        size.width * 0.6, size.height * 0.65
    );
    doorPath.lineTo(size.width * 0.6, size.height * 0.85);
    doorPath.close();

    canvas.drawPath(doorPath, doorPaint);

    // Draw windows (round cottage windows)
    final windowPaint = Paint()
      ..color = Colors.white.withOpacity(color.opacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width * 0.3, size.height * 0.55),
        size.width * 0.08,
        windowPaint
    );

    canvas.drawCircle(
        Offset(size.width * 0.7, size.height * 0.55),
        size.width * 0.08,
        windowPaint
    );

    // Draw chimney - use navy blue from JRE colors if available
    final Color chimneyColor;
    if (color.red > 200 && color.green > 200 && color.blue > 200) {
      // If cottage is white, use navy blue chimney
      chimneyColor = Color(0xFF000080);
    } else {
      // Otherwise use a darker version of cottage color
      chimneyColor = darkenColor(color, 0.3);
    }

    final chimneyPaint = Paint()
      ..color = chimneyColor
      ..style = PaintingStyle.fill;

    final chimneyPath = Path();
    chimneyPath.moveTo(size.width * 0.7, size.height * 0.3);
    chimneyPath.lineTo(size.width * 0.7, size.height * 0.1);
    chimneyPath.lineTo(size.width * 0.8, size.height * 0.1);
    chimneyPath.lineTo(size.width * 0.8, size.height * 0.35);
    chimneyPath.close();

    canvas.drawPath(chimneyPath, chimneyPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Helper function to darken a color by a factor
Color darkenColor(Color color, double factor) {
  return Color.fromARGB(
    color.alpha,
    (color.red * (1 - factor)).round().clamp(0, 255),
    (color.green * (1 - factor)).round().clamp(0, 255),
    (color.green * (1 - factor)).round().clamp(0, 255),
  );
}

// Class to store house data
class HouseData {
  final double size;
  final Offset position;
  final Color color;
  final double speed;
  final double direction;
  final double pulseSpeed;
  final int houseType;     // 0 = standard, 1 = barn, 2 = cottage
  final double rotation;   // Small rotation for visual variety

  HouseData({
    required this.size,
    required this.position,
    required this.color,
    required this.speed,
    required this.direction,
    required this.pulseSpeed,
    required this.houseType,
    required this.rotation,
  });
}