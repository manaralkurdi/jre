import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

/// A generic property card that can work with any property model
/// by using a flexible approach with callbacks to extract data
class DynamicPropertyCard<T> extends StatefulWidget {
  /// The property data object
  final T property;

  /// Callback to extract the title from the property
  final String Function(T property) titleExtractor;

  /// Callback to extract the price from the property
  final String Function(T property) priceExtractor;

  /// Callback to extract the location code from the property
  final String Function(T property) locationCodeExtractor;

  /// Callback to extract the location from the property
  final String Function(T property) locationExtractor;

  /// Callback to extract the number of beds from the property
  final dynamic Function(T property) bedsExtractor;

  /// Callback to extract the number of baths from the property
  final dynamic Function(T property) bathsExtractor;

  /// Callback to extract the number of kitchens from the property
  final dynamic Function(T property) kitchensExtractor;

  /// Callback to extract list of image URLs from the property
  final Future<List<String>> Function(T property) imageUrlExtractor;

  /// Optional callback for handling favorite toggle
  final Function(T property, bool isFavorite)? onFavoriteToggle;

  /// Optional callback for handling card tap
  final Function(T property)? onTap;

  /// Flag to determine if the property is a favorite
  final bool Function(T property)? isFavoriteExtractor;

  /// Optional callback to extract any additional property type label
  final String? Function(T property)? propertyTypeExtractor;

  const DynamicPropertyCard({
    Key? key,
    required this.property,
    required this.titleExtractor,
    required this.priceExtractor,
    required this.locationCodeExtractor,
    required this.locationExtractor,
    required this.bedsExtractor,
    required this.bathsExtractor,
    required this.kitchensExtractor,
    required this.imageUrlExtractor,
    this.onFavoriteToggle,
    this.onTap,
    this.isFavoriteExtractor,
    this.propertyTypeExtractor,
  }) : super(key: key);

  @override
  State<DynamicPropertyCard<T>> createState() => _DynamicPropertyCardState<T>();
}

class _DynamicPropertyCardState<T> extends State<DynamicPropertyCard<T>> {
  int _currentImageIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    // Reset the current index when the widget initializes
    _currentImageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageHeight = 400.h;

    return GestureDetector(
      onTap: widget.onTap != null ? () => widget.onTap!(widget.property) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image Carousel with Stack for favorite button and property type label
              Stack(
                children: [
                  // Image Carousel
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FutureBuilder<List<String>>(
                      future: widget.imageUrlExtractor(widget.property),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          final images = snapshot.data!;
                          return SizedBox(
                            height: imageHeight,
                            child: Stack(
                              children: [
                                // CarouselSlider for image carousel
                                CarouselSlider.builder(
                                  itemCount: images.length,
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    height: imageHeight,
                                    viewportFraction: 1.0,
                                    initialPage: _currentImageIndex,
                                    autoPlay: images.length > 1,
                                    autoPlayInterval: const Duration(seconds: 4),
                                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: images.length > 1,
                                    scrollPhysics: const BouncingScrollPhysics(),
                                    onPageChanged: (index, reason) {
                                      if (mounted) {
                                        setState(() {
                                          _currentImageIndex = index;
                                        });
                                        print("Current index changed to: $index, reason: $reason");
                                      }
                                    },
                                  ),
                                  itemBuilder: (context, index, realIndex) {
                                    return Image.network(
                                      images[index],
                                      width: double.infinity,
                                      height: imageHeight,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: Icon(Icons.error, color: Colors.grey),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                // Custom indicator dots
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      images.length,
                                          (index) => GestureDetector(
                                        onTap: () {
                                          _carouselController.animateToPage(
                                            index,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.symmetric(horizontal: 3),
                                          height: 8,
                                          width: _currentImageIndex == index ? 24 : 8,
                                          decoration: BoxDecoration(
                                            color: _currentImageIndex == index
                                                ? const Color(0xff3D5BF6)
                                                : Colors.white.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          // Loading state
                          return Container(
                            height: imageHeight,
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          // Error or no images
                          return Container(
                            height: imageHeight,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  // Favorite button
                  if (widget.onFavoriteToggle != null && widget.isFavoriteExtractor != null)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          final isFavorite = widget.isFavoriteExtractor!(widget.property);
                          widget.onFavoriteToggle!(widget.property, !isFavorite);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.isFavoriteExtractor!(widget.property)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.isFavoriteExtractor!(widget.property)
                                ? Colors.red
                                : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                  // Property type label

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.titleExtractor(widget.property),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.priceExtractor(widget.property),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D5BF6),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Location
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${widget.locationCodeExtractor(widget.property)}  ${widget.locationExtractor(widget.property)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Property Details Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Bed
                        _buildFeatureItem(
                          icon: Icons.bed,
                          value: '${widget.bedsExtractor(widget.property)} Bed',
                          iconColor: Colors.redAccent,
                        ),

                        const SizedBox(width: 20),

                        // Bath
                        _buildFeatureItem(
                          icon: Icons.person,
                          value: '${widget.bathsExtractor(widget.property)} Person',
                          iconColor: Colors.redAccent,
                        ),

                        const SizedBox(width: 20),

                        // Kitchen
                        _buildFeatureItem(
                          icon: Icons.workspaces,
                          value: '${widget.kitchensExtractor(widget.property)} sqft',
                          iconColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}