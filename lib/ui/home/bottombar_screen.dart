import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jre_app/base/component/app_custom_text.dart';
import 'package:jre_app/ui/home/ui/home_page.dart';

import '../../utils/Colors.dart';
import '../../utils/fontfamily_model.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart' show LoadHomeDataEvent;

class BottoBarScreen extends StatefulWidget {
  const BottoBarScreen({super.key});

  @override
  State<BottoBarScreen> createState() => _BottoBarScreenState();
}

late TabController tabController;

class _BottoBarScreenState extends State<BottoBarScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  var isLogin;

  // BLoC instances for each tab if needed
  late HomeBloc homeBloc;

  // List of screens for each tab
  late List<Widget> myChilders;

  @override
  void initState() {
    super.initState();

    // Initialize the HomeBloc
    homeBloc = HomeBloc();

    // Initialize screens with appropriate BLoC providers
    myChilders = [
      BlocProvider.value(value: homeBloc, child: const HomeScreen()),
      BlocProvider.value(
        value: homeBloc,
        child: const HomeScreen(), // This would be NearbyScreen in real app
      ),
      BlocProvider.value(
        value: homeBloc,
        child: const HomeScreen(), // This would be FavoriteScreen in real app
      ),
      BlocProvider.value(
        value: homeBloc,
        child: const HomeScreen(), // This would be AccountScreen in real app
      ),
    ];

    isLogin = "";
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        _currentIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // Dispose resources
    tabController.dispose();
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myChilders,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Floating action button can be added here if needed
      bottomNavigationBar: SizedBox(
        // Fixed height for the bottom navigation bar to avoid overflow
        height: 65,
        child: BottomAppBar(
          color: bgcolor,
          child: TabBar(
            onTap: (index) async {
              setState(() {
                _currentIndex = index;
              });

              // Handle tab-specific logic
              if (index == 0) {
                // Home tab selected - refresh home data
                if (myChilders[0] is BlocProvider) {
                  final homeBloc = BlocProvider.of<HomeBloc>(
                    context,
                    listen: false,
                  );
                  homeBloc.add(LoadHomeDataEvent());
                }
              } else if (index == 1) {
                // Nearby tab selected
                // Location permission handling would go here
              } else if (index == 2) {
                // Favorites tab selected
                // Load favorites data
              } else if (index == 3) {
                // Account tab selected
                // Load user data
              }
            },
            indicator: UnderlineTabIndicator(
              insets: const EdgeInsets.only(bottom: 52),
              borderSide: BorderSide(color: bgcolor, width: 2),
            ),
            labelColor: Colors.blueAccent,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            padding: const EdgeInsets.symmetric(vertical: 2),
            // Reduced padding
            tabs: [
              // Home Tab
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Add this to minimize height
                  children: [
                    Image.asset(
                      "assets/images/images/${_currentIndex == 0 ? "HomeBold.png" : "Home.png"}",
                      scale: 24,
                      color:
                          _currentIndex == 0
                              ? const Color(0xff3D5BF6)
                              : BlackColor,
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    AppCustomText(
                      titleText: "Home",
                      style: TextStyle(
                        fontSize: 12, // Reduced font size
                        fontFamily: FontFamily.gilroyMedium,
                        color:
                            _currentIndex == 0
                                ? const Color(0xff3D5BF6)
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Nearby Tab
              Tab(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Add this to minimize height
                  children: [
                    Image.asset(
                      "assets/images/images/${_currentIndex == 1 ? "mapbold.png" : "map.png"}",
                      scale: 3.7,
                      color:
                          _currentIndex == 1
                              ? const Color(0xff3D5BF6)
                              : BlackColor,
                      height: 20, // Specify height to control size
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    AppCustomText(
                      titleText: "Nearby",
                      style: TextStyle(
                        fontSize: 12, // Reduced font size
                        fontFamily: FontFamily.gilroyMedium,
                        color:
                            _currentIndex == 1
                                ? const Color(0xff3D5BF6)
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Favorites Tab
              Tab(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Add this to minimize height
                  children: [
                    Image.asset(
                      "assets/images/images/${_currentIndex == 2 ? "heartBold.png" : "heartline.png"}",
                      scale: 24,
                      color:
                          _currentIndex == 2
                              ? const Color(0xff3D5BF6)
                              : BlackColor,
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    AppCustomText(
                      titleText: "Favorite",
                      style: TextStyle(
                        fontSize: 12, // Reduced font size
                        fontFamily: FontFamily.gilroyMedium,
                        color:
                            _currentIndex == 2
                                ? const Color(0xff3D5BF6)
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Account Tab
              Tab(
                child: Column(// Add this to minimize height
                  children: [
                    Image.asset(
                      "assets/images/images/${_currentIndex == 3 ?
                      "userBold.png" : "userline.png"}",
                      scale: 24,
                      color:
                          _currentIndex == 3
                              ? const Color(0xff3D5BF6)
                              : BlackColor,
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    AppCustomText(
                      titleText: "Account",
                      style: TextStyle(
                        fontSize: 12, // Reduced font size
                        fontFamily: FontFamily.gilroyMedium,
                        color:
                            _currentIndex == 3
                                ? const Color(0xff3D5BF6)
                                : Colors.grey,
                      ),
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
}
