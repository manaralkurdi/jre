import 'package:badges/badges.dart' as bg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jre_app/base/component/app_custom_text.dart';
import 'package:jre_app/data/lib/base/app_config.dart';
import 'package:jre_app/ui/home/widget/category_seeall.dart';

import '../../../domain/model/home/Real_estate_ourReco_model.dart';
import '../../../domain/model/home/proparty_model.dart';
import '../../../domain/repositry/home/repositry_random.dart';
import '../../../theme/bloc/theme_bloc/theme_bloc.dart';
import '../../../utils/Colors.dart';
import '../../../utils/fontfamily_model.dart';
import '../../Details/bloc/details_bloc.dart';
import '../../Details/ui/property_deatils.dart';
import '../../search/component/search_component.dart';
import '../../search/search_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../component/dynamic_property.dart' show DynamicPropertyCard;
import '../widget/department.dart';
import '../widget/filter_page.dart';
import '../widget/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeDataEvent());
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showSearchBottomSheet();
    // });
  }

  void _showSearchBottomSheet() {
    final appConfig = AppConfig();
    final repository = RealEstateRepository(appConfig: appConfig);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) =>
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(repository),
            child:  SearchBottomSheet(),
          ),
    );
  }

  var currency = "\$";

  final String userName = 'Manar';
  List facilities = [
    "assets/images/images/beds.svg",
    "assets/images/images/bath.svg",
    "assets/images/images/sqft.svg",
  ];
  String selectedFilter = 'Apartment';
  PropertyDataCategory? selectedFilterData;

  //
  // List<Property> property =
  // // Mock data - in a real app, this would come from local storage
  // [
  //   Property(
  //     rating: 5,
  //     id: '1',
  //     title: 'Modern
  //     ',
  //     price: 267000,
  //     location: 'New York, NY',
  //     locationCode: '2BW',
  //     beds: 4,
  //     baths: 3,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/OIP.jpeg',
  //     type: 'Apartment',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //   ),
  //   Property(
  //     id: '2',
  //     title: 'Luxury Villa',
  //     price: 550000,
  //     location: 'Miami, FL',
  //     locationCode: '3CV',
  //     beds: 5,
  //     baths: 4,
  //     kitchens: 2,
  //     imageUrl: 'assets/images/OIP.jpeg',
  //     type: 'Villa',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //
  //   ),
  //   Property(
  //     id: '3',
  //     title: 'Family House',
  //     price: 320000,
  //     location: 'Austin, TX',
  //     locationCode: '4FH',
  //     beds: 4,
  //     baths: 2,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/OIP.jpeg',
  //     type: 'House',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  //   Property(
  //     id: '4',
  //     title: 'Modern Villa',
  //     price: 620000,
  //     location: 'Los Angeles, CA',
  //     locationCode: '5MV',
  //     beds: 6,
  //     baths: 5,
  //     kitchens: 2,
  //     imageUrl: 'assets/images/OIP.jpeg',
  //     type: 'Villa',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  //   Property(
  //     id: '5',
  //     title: 'Studio Apartment',
  //     price: 175000,
  //     location: 'Chicago, IL',
  //     locationCode: '1SA',
  //     beds: 1,
  //     baths: 1,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/OIP.jpeg',
  //     type: 'Apartment',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  //   Property(
  //     id: '6',
  //     title: 'Countryside House',
  //     price: 290000,
  //     location: 'Boulder, CO',
  //     locationCode: '6CH',
  //     beds: 3,
  //     baths: 2,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/OIP.jpeg',
  //     type: 'House',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  // ];
  // List<PropertyModel> propertyCard =
  // // Mock data - in a real app, this would come from local storage
  // [
  //   PropertyModel(
  //     id: '1',
  //     title: 'Delux Apartment',
  //     price: 267000,
  //     location: 'NY, New York',
  //     locationCode: '2BW',
  //     beds: 4,
  //     baths: 3,
  //     kitchens: 1,
  //     imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
  //     isFavorite: false,
  //     propertyType: 'For Sale',
  //   ),
  //   PropertyModel(
  //     id: '2',
  //     title: 'Modern Penthouse',
  //     price: 450000,
  //     location: 'LA, California',
  //     locationCode: '3AC',
  //     beds: 5,
  //     baths: 4,
  //     kitchens: 1,
  //     imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
  //     isFavorite: true,
  //     propertyType: 'Premium',
  //   ),
  //   PropertyModel(
  //     id: '3',
  //     title: 'Cozy Studio',
  //     price: 120000,
  //     location: 'Chicago, Illinois',
  //     locationCode: '1CS',
  //     beds: 1,
  //     baths: 1,
  //     kitchens: 1,
  //     imageUrl: 'https://images.unsplash.com/photo-1554995207-c18c203602cb',
  //     isFavorite: false,
  //     propertyType: 'For Rent',
  //   ),
  //   PropertyModel(
  //     id: '4',
  //     title: 'Seaside Villa',
  //     price: 870000,
  //     location: 'Miami, Florida',
  //     locationCode: '5SV',
  //     beds: 6,
  //     baths: 5,
  //     kitchens: 2,
  //     imageUrl: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
  //     isFavorite: false,
  //     propertyType: 'Luxury',
  //   ),
  //   PropertyModel(
  //     id: '5',
  //     title: 'Family Home',
  //     price: 320000,
  //     location: 'Boston, Massachusetts',
  //     locationCode: '4FH',
  //     beds: 4,
  //     baths: 3,
  //     kitchens: 1,
  //     imageUrl: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
  //     isFavorite: true,
  //     propertyType: 'For Sale',
  //   ),
  // ];
  //
  // // Sample property data
  // final List<Property> allProperties = [
  //   Property(
  //     rating: 5,
  //     id: '1',
  //     title: 'Modern Apartment',
  //     price: 267000,
  //     location: 'New York, NY',
  //     locationCode: '2BW',
  //     beds: 4,
  //     baths: 3,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/apartment1.jpg',
  //     type: 'Apartment',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //   ),
  //   Property(
  //     id: '2',
  //     title: 'Luxury Villa',
  //     price: 550000,
  //     location: 'Miami, FL',
  //     locationCode: '3CV',
  //     beds: 5,
  //     baths: 4,
  //     kitchens: 2,
  //     imageUrl: 'assets/images/villa1.jpg',
  //     type: 'Villa',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //
  //   ),
  //   Property(
  //     id: '3',
  //     title: 'Family House',
  //     price: 320000,
  //     location: 'Austin, TX',
  //     locationCode: '4FH',
  //     beds: 4,
  //     baths: 2,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/house1.jpg',
  //     type: 'House',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  //   Property(
  //     id: '4',
  //     title: 'Modern Villa',
  //     price: 620000,
  //     location: 'Los Angeles, CA',
  //     locationCode: '5MV',
  //     beds: 6,
  //     baths: 5,
  //     kitchens: 2,
  //     imageUrl: 'assets/images/villa2.jpg',
  //     type: 'Villa',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  //   Property(
  //     id: '5',
  //     title: 'Studio Apartment',
  //     price: 175000,
  //     location: 'Chicago, IL',
  //     locationCode: '1SA',
  //     beds: 1,
  //     baths: 1,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/apartment2.jpg',
  //     type: 'Apartment',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  //   Property(
  //     id: '6',
  //     title: 'Countryside House',
  //     price: 290000,
  //     location: 'Boulder, CO',
  //     locationCode: '6CH',
  //     beds: 3,
  //     baths: 2,
  //     kitchens: 1,
  //     imageUrl: 'assets/images/house2.jpg',
  //     type: 'House',
  //     name: 'Khaothong Terrace 1',
  //     country: 'Krabi Thailand',
  //     sqft: 6575,
  //     rating: 5,
  //   ),
  // ];
  //
  // List<Property> get filteredProperties {
  //   if (selectedFilter == 'All') {
  //     return allProperties;
  //   } else {
  //     return allProperties.where((property) => property.type == selectedFilter).toList();
  //   }
  // }

  void _onFilterSelected(String filterName, Map<String, dynamic> filterData,state) {
    setState(() {
      selectedFilter = filterName;
      context.read<HomeBloc>().add(CategoryDetailsLoaded(id: filterData['id']),
      );
      // Use the filter data directly from the callback
      _navigateToFilteredPage(filterData,state);
    });
  }

  void _navigateToFilteredPage(Map<String, dynamic> filterData,state) {
    final appConfig = AppConfig();
    final repository = RealEstateRepository(appConfig: appConfig);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(repository),
          child: CategoryList(
            filterName: filterData['name']??'Chaleh',
            filterType: filterData['id']??1,
            properties: state.categoryProperties,
          ),
        ),
      ),
    );
  }
  void _navigateToDetails(Map<String, dynamic> filterData) {
    final state = context.read<HomeBloc>().state;
    final appConfig = AppConfig();
    final repository = RealEstateRepository(appConfig: appConfig);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(repository),
          child: CategoryList(
            filterName: filterData['name'],
            filterType: filterData['id'],
            properties: state.categoryProperties,
          ),
        ),
      ),
    );
  }
  void navigateToPropertyDetails(BuildContext context, String id) {
    final appConfig = AppConfig();
    final repository = RealEstateRepository(appConfig: appConfig);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<DetailsBloc>(
            create: (context) => DetailsBloc(repository),
            child: PropertyViewScreen(propertyId: int.parse(id),
            ),
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              // getData.read("UserLogin") != null && networkimage != ""
              //     ? InkWell(
              //       onTap: () {},
              //       child: Container(
              //         height: 50,
              //         width: 50,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           image: DecorationImage(
              //             image: NetworkImage(
              //               "${Config.imageUrl}${networkimage ?? ""}",
              //             ),
              //             fit: BoxFit.fill,
              //           ),
              //         ),
              //       ),
              //     )
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/images/profile-default.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppCustomText(
                        titleText: "Hello Welcome",
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontFamily: FontFamily.gilroyMedium,
                          fontSize: 14,
                        ),
                      ),
                      AppCustomText(
                        titleText: "👋",
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontFamily: FontFamily.gilroyMedium,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  userName != ""
                      ? const Text(
                    "Manar",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 18,
                    ),
                  )
                      : AppCustomText(
                    titleText: "User",
                    style: const TextStyle(
                      color: Colors.black12,
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                // if (getData.read("UserLogin") != null) {
                //   Get.toNamed(Routes.notificationScreen);
                // } else {
                //   Get.toNamed(Routes.login);
                // }
              },
              child: Center(
                child: bg.Badge(
                  badgeStyle: const bg.BadgeStyle(
                    badgeColor: Colors.red,
                    shape: bg.BadgeShape.circle,
                  ),
                  badgeContent: const Text(''),
                  badgeAnimation: const bg.BadgeAnimation.slide(),
                  position: bg.BadgePosition.topEnd(end: 14, top: 3),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.black12,
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        "assets/images/images/Notification.png",
                        height: 25,
                        width: 25,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body:BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if(state.status==HomeStatus.loadingCategory){
              const Center(child: CircularProgressIndicator());
            }
          },
          builder: (context, state) {
            return  _buildHomeContent(state);
          }
      ),
    );
  }

  Widget _buildHomeContent(HomeState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          _buildSearchBar(),
          // Property type filter
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child:
            // PropertyFilter(
            //   selectedFilter: state.selectedPropertyType,
            //   onFilterSelected: (filter) {
            //     context.read<HomeBloc>().add(FilterPropertiesEvent(filter));
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PropertyFilter(
                response: state.categoryProperties,
                selectedFilter: selectedFilter,
                onFilterSelected: _onFilterSelected,
              ),
            ),
          ),
          CategoryAndSeeAllWidget(name: "Featured".tr, buttonName: ""),
          _buildPropertyList(
              context,
              state.featuredProperties,
              state.status == HomeStatus.loading
          ),

          CategoryAndSeeAllWidget(
            name: "Our Recommendation".tr,
            buttonName: "",
          ),
          // Our recommendation section
          _buildRecommendationList(
              context,
              state.recommendedProperties,
              state.status == HomeStatus.loading
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        setState(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showSearchBottomSheet();
          });
        });
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                "assets/images/images/sort.png",
                height: 22,
                width: 22,
                fit: BoxFit.cover,
                color: fevAndSearchColor,
              ),
            ),
            AppCustomText(
              titleText: "Search",
              style: TextStyle(
                  fontFamily: FontFamily.gilroyMedium,
                  color: fevAndSearchColor,
                  fontWeight: FontWeight.bold,fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPropertyList(BuildContext context, List<Property> properties, bool isLoading) {
    if (isLoading) {
      return const PropertyCardShimmer(isHorizontal: true);
    }
    return
      properties.isNotEmpty?
      SizedBox(
        height: 320.h,
        width: 620.w,
        child: properties.isNotEmpty
            ? ListView.builder(
          itemCount: properties.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildPropertyCard(context, properties[index]);
          },
        )
            : _buildEmptyState(),
      )
          : _buildEmptyState();
  }
  Widget _buildPropertyCard(BuildContext context, Property property) {
    final currency = "\$";
    final facilities = [
      "assets/images/images/beds.svg",
      "assets/images/images/bath.svg",
      "assets/images/images/sqft.svg",
    ];

    return InkWell(
      onTap: () => navigateToPropertyDetails(context,property.id),
      child: Container(
        height: 320.h,
        width: 244.w,

        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              // Property Image
              SizedBox(
                height: 320.h,
                width: 240,
                child: FutureBuilder<String>(
                  future: AppConfig().imageUrl,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Image.network(
                        "${snapshot.data}${property.mainImage}",
                        fit: BoxFit.fill,
                        height: 320.h,
                        width: 240.w,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 320.h,
                            width: 240.w,
                            color: Colors.grey[200],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 320,
                            width: 240,
                            color: Colors.grey[200],
                            child: Icon(Icons.broken_image,
                                size: 50, color: Colors.grey[400]),
                          );
                        },
                      );
                    } else {
                      return Container(
                        height: 320,
                        width: 240,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.45, 0, 0],
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Rating badge
              Positioned(
                top: 15,
                right: 20,
                child: Container(
                  height: 30,
                  width: 65,
                  decoration: BoxDecoration(
                    color: const Color(0xFFedeeef),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                        child: Image.asset(
                          "assets/images/images/Rating.png",
                          height: 15,
                          width: 15,
                        ),
                      ),
                      const Text(
                        "5",
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyMedium,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Property details
              Positioned(
                bottom: 10,
                child: SizedBox(
                  height: 141.h,
                  width: 240.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Property name
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 10),
                        child: Text(
                          property.nameEn ?? "",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 17,
                            fontFamily: FontFamily.gilroyBold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                      // Location
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 3,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/images/location.svg",
                              height: 15,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              property.location ?? "",
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Facilities
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 3,
                        ),
                        child: SizedBox(
                          height: 13,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: facilities.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SvgPicture.asset(
                                    facilities[index],
                                    height: 12,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  index == 0
                                      ? const Text(
                                    "3 Beds",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  )
                                      : index == 1
                                      ? const Text(
                                    "2 Bath",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  )
                                      : Text(
                                    "${property.size} Sqft",
                                    style: const TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Text(
                              "$currency${property.dailyPrice}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),
      child: Column(
        children: [
          const Image(
            image: AssetImage(
              "assets/images/images/searchDataEmpty.png",
            ),
            height: 110,
            width: 110,
          ),
          Center(
            child: SizedBox(
              width: 10 * 0.80,
              child: Text(
                "Sorry, there is no any nearby \n category or data not found".tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamily.gilroyBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationList(BuildContext context, List<Property> properties, bool isLoading) {
    if (isLoading) {
      return const PropertyCardShimmer(isHorizontal: false);
    }

    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      itemCount: properties.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final property = properties[index];
        return DynamicPropertyCard<Property>(
          property: property,
          titleExtractor: (p) => p.nameEn,
          priceExtractor: (p) => '\$${p.dailyPrice}',
          locationCodeExtractor: (p) => p.location,
          locationExtractor: (p) => p.location,
          bedsExtractor: (p) => 3,
          bathsExtractor: (p) => 3,
          kitchensExtractor: (p) => 2,
          imageUrlExtractor: (p) async {
            final appConfig = AppConfig();
            final baseUrl = await appConfig.imageUrl;
            return p.mainImage != null
                ? '$baseUrl${p.mainImage}'
                : '$baseUrl/default.jpg';
          },
          propertyTypeExtractor: (p) => p.propertyType,
          onTap: (p) => navigateToPropertyDetails(context, p.id),
        );
      },
    );
  }
}
