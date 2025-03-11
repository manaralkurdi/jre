import 'package:badges/badges.dart' as bg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jre_app/base/component/app_custom_text.dart';
import 'package:jre_app/ui/Details/bloc/property_bloc.dart';
import 'package:jre_app/ui/home/widget/category_seeall.dart';

import '../../../model/home/proparty_model.dart';
import '../../../theme/bloc/theme_bloc/theme_bloc.dart';
import '../../../utils/Colors.dart';
import '../../../utils/fontfamily_model.dart';
import '../../Details/ui/property_deatils.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../component/dynamic_property.dart' show DynamicPropertyCard;
import '../component/search_component.dart';
import '../widget/department.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => SearchBottomSheet(),
    );
  }

  var currency = "\$";

  final String userName = 'Manar';
  List facilities = [
    "assets/images/images/beds.svg",
    "assets/images/images/bath.svg",
    "assets/images/images/sqft.svg",
  ];

  List<Property> property =
  // Mock data - in a real app, this would come from local storage
  [
    Property(
      rating: 5,
      id: '1',
      title: 'Modern Apartment',
      price: 267000,
      location: 'New York, NY',
      locationCode: '2BW',
      beds: 4,
      baths: 3,
      kitchens: 1,
      imageUrl: 'assets/images/OIP.jpeg',
      type: 'Apartment',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
    ),
    Property(
      id: '2',
      title: 'Luxury Villa',
      price: 550000,
      location: 'Miami, FL',
      locationCode: '3CV',
      beds: 5,
      baths: 4,
      kitchens: 2,
      imageUrl: 'assets/images/OIP.jpeg',
      type: 'Villa',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '3',
      title: 'Family House',
      price: 320000,
      location: 'Austin, TX',
      locationCode: '4FH',
      beds: 4,
      baths: 2,
      kitchens: 1,
      imageUrl: 'assets/images/OIP.jpeg',
      type: 'House',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '4',
      title: 'Modern Villa',
      price: 620000,
      location: 'Los Angeles, CA',
      locationCode: '5MV',
      beds: 6,
      baths: 5,
      kitchens: 2,
      imageUrl: 'assets/images/OIP.jpeg',
      type: 'Villa',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '5',
      title: 'Studio Apartment',
      price: 175000,
      location: 'Chicago, IL',
      locationCode: '1SA',
      beds: 1,
      baths: 1,
      kitchens: 1,
      imageUrl: 'assets/images/OIP.jpeg',
      type: 'Apartment',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '6',
      title: 'Countryside House',
      price: 290000,
      location: 'Boulder, CO',
      locationCode: '6CH',
      beds: 3,
      baths: 2,
      kitchens: 1,
      imageUrl: 'assets/images/OIP.jpeg',
      type: 'House',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
  ];
  List<PropertyModel> propertyCard =
  // Mock data - in a real app, this would come from local storage
  [
    PropertyModel(
      id: '1',
      title: 'Delux Apartment',
      price: 267000,
      location: 'NY, New York',
      locationCode: '2BW',
      beds: 4,
      baths: 3,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
      isFavorite: false,
      propertyType: 'For Sale',
    ),
    PropertyModel(
      id: '2',
      title: 'Modern Penthouse',
      price: 450000,
      location: 'LA, California',
      locationCode: '3AC',
      beds: 5,
      baths: 4,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      isFavorite: true,
      propertyType: 'Premium',
    ),
    PropertyModel(
      id: '3',
      title: 'Cozy Studio',
      price: 120000,
      location: 'Chicago, Illinois',
      locationCode: '1CS',
      beds: 1,
      baths: 1,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1554995207-c18c203602cb',
      isFavorite: false,
      propertyType: 'For Rent',
    ),
    PropertyModel(
      id: '4',
      title: 'Seaside Villa',
      price: 870000,
      location: 'Miami, Florida',
      locationCode: '5SV',
      beds: 6,
      baths: 5,
      kitchens: 2,
      imageUrl: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
      isFavorite: false,
      propertyType: 'Luxury',
    ),
    PropertyModel(
      id: '5',
      title: 'Family Home',
      price: 320000,
      location: 'Boston, Massachusetts',
      locationCode: '4FH',
      beds: 4,
      baths: 3,
      kitchens: 1,
      imageUrl: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6',
      isFavorite: true,
      propertyType: 'For Sale',
    ),
  ];
  String selectedFilter = 'All';

  // Sample property data
  final List<Property> allProperties = [
    Property(
      rating: 5,
      id: '1',
      title: 'Modern Apartment',
      price: 267000,
      location: 'New York, NY',
      locationCode: '2BW',
      beds: 4,
      baths: 3,
      kitchens: 1,
      imageUrl: 'assets/images/apartment1.jpg',
      type: 'Apartment',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
    ),
    Property(
      id: '2',
      title: 'Luxury Villa',
      price: 550000,
      location: 'Miami, FL',
      locationCode: '3CV',
      beds: 5,
      baths: 4,
      kitchens: 2,
      imageUrl: 'assets/images/villa1.jpg',
      type: 'Villa',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '3',
      title: 'Family House',
      price: 320000,
      location: 'Austin, TX',
      locationCode: '4FH',
      beds: 4,
      baths: 2,
      kitchens: 1,
      imageUrl: 'assets/images/house1.jpg',
      type: 'House',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '4',
      title: 'Modern Villa',
      price: 620000,
      location: 'Los Angeles, CA',
      locationCode: '5MV',
      beds: 6,
      baths: 5,
      kitchens: 2,
      imageUrl: 'assets/images/villa2.jpg',
      type: 'Villa',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '5',
      title: 'Studio Apartment',
      price: 175000,
      location: 'Chicago, IL',
      locationCode: '1SA',
      beds: 1,
      baths: 1,
      kitchens: 1,
      imageUrl: 'assets/images/apartment2.jpg',
      type: 'Apartment',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
    Property(
      id: '6',
      title: 'Countryside House',
      price: 290000,
      location: 'Boulder, CO',
      locationCode: '6CH',
      beds: 3,
      baths: 2,
      kitchens: 1,
      imageUrl: 'assets/images/house2.jpg',
      type: 'House',
      name: 'Khaothong Terrace 1',
      country: 'Krabi Thailand',
      sqft: 6575,
      rating: 5,
    ),
  ];

  List<Property> get filteredProperties {
    if (selectedFilter == 'All') {
      return allProperties;
    } else {
      return allProperties
          .where((property) => property.type == selectedFilter)
          .toList();
    }
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  // void _navigateToPropertyDetail(Property property) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => PropertyDetailPage(property: property),
  //     ),
  //   );
  // }
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
                  decoration: const BoxDecoration(
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
              const SizedBox(width: 10),
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
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state.isLoading && state.featuredProperties.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : state.errorMessage != null && state.featuredProperties.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.errorMessage}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          () =>
                              context.read<HomeBloc>().add(LoadHomeDataEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : _buildHomeContent(state);
        },
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
            PropertyFilter(
              selectedFilter: selectedFilter,
              onFilterSelected: _onFilterSelected,
            ),
          ),
          CategoryAndSeeAllWidget(name: "Featured".tr, buttonName: ""),
          _buildPropertyList(property),
          CategoryAndSeeAllWidget(
            name: "Our Recommendation".tr,
            buttonName: "",
          ),
          // Our recommendation section
          _buildRecommendationList(propertyCard),
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

  Widget _buildPropertyList(List<Property> properties) {
    return SizedBox(
      height: 320.h,
      width: 600.w,
      child:
          properties!.isNotEmpty
              ? ListView.builder(
                itemCount: properties.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                primary: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index1) {
                  // currency =
                  //     homePageController.homeDatatInfo?.homeData!.currency ?? "";
                  return InkWell(
                    onTap: () async {
                      // setState(() {
                      //   homePageController.rate = homePageController
                      //       .homeDatatInfo
                      //       ?.homeData
                      //   !.featuredProperty![index1]
                      //       .rate ??
                      //       "";
                      // });
                      // print("IDDD ? >> >>> >>> >>> > ${homePageController.homeDatatInfo?.homeData!.featuredProperty![index1].id}");
                      // homePageController.chnageObjectIndex(index1);
                      // await homePageController.getPropertyDetailsApi(
                      //     id: homePageController.homeDatatInfo?.homeData
                      //     !.featuredProperty![index1].id);
                      // Get.toNamed(
                      //   Routes.viewDataScreen,
                      // );
                    },
                    child: Container(
                      height: 320.h,
                      width: 240.w,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 240,
                              child: Image.asset(
                                properties[index1].imageUrl ?? "",
                                fit: BoxFit.fill,
                                height: 320,
                                width: 240,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.45, 0, 0],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.1),
                                  ],
                                ),
                              ),
                            ),
                            properties?[index1]?.rating != "1"
                                ? Positioned(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                            0,
                                            0,
                                            3,
                                            0,
                                          ),
                                          child: Image.asset(
                                            "assets/images/images/Rating.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                        AppCustomText(
                                          titleText:
                                              "${properties![index1].rating.toInt() ?? ""}",
                                          style: const TextStyle(
                                            fontFamily: FontFamily.gilroyMedium,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : Positioned(
                                  top: 15,
                                  right: 20,
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFedeeef),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "BUY".tr,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            Positioned(
                              bottom: 10,
                              child: SizedBox(
                                width: 240,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      child: AppCustomText(
                                        titleText:
                                            properties![index1].name ?? "",
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: FontFamily.gilroyBold,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            properties![index1].country ?? "",
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                ),
                                                const SizedBox(width: 5),
                                                index == 0
                                                    ? Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          AppCustomText(
                                                            titleText:
                                                                "${properties![index1].beds}",
                                                            style: const TextStyle(
                                                              fontFamily:
                                                                  FontFamily
                                                                      .gilroyMedium,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          Text(
                                                            " Beds",
                                                            style: const TextStyle(
                                                              fontFamily:
                                                                  FontFamily
                                                                      .gilroyMedium,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    : index == 1
                                                    ? AppCustomText(
                                                      titleText:
                                                          "${properties[index1].baths} Bath",
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            FontFamily
                                                                .gilroyMedium,
                                                        color: Colors.white,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                    : AppCustomText(
                                                      titleText:
                                                          "${properties?[index1].sqft} Sqft",
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            FontFamily
                                                                .gilroyMedium,
                                                        color: Colors.white,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
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
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 10,
                                          ),
                                          child: Text(
                                            "${currency}${properties![index1].price}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: FontFamily.gilroyBold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        properties![index1].rating == "1"
                                            ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                                top: 10,
                                              ),
                                              child: Text(
                                                "/night".tr,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontFamily.gilroyMedium,
                                                ),
                                              ),
                                            )
                                            : const Text(""),
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
                },
              )
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.10),
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
                          "Sorry, there is no any nearby \n category or data not found"
                              .tr,
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
              ),
    );
    //   SizedBox(
    //   height: 280,
    //   child:
    //       properties.isEmpty
    //           ? const Center(child: Text('No properties available'))
    //           : ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: properties.length,
    //             itemBuilder: (context, index) {
    //               return PropertyCard(property: properties[index]);
    //             },
    //           ),
    // );
  }

  _navigateToDetails(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BlocProvider<PropertyBloc>(
              create: (context) => PropertyBloc(),
              child: PropertyViewScreen(propertyId: id ?? "1"),
            ),
      ),
    );
  }

  Widget _buildRecommendationList(properties) {
    return ListView.builder(
      primary: true,
      shrinkWrap: true,
      itemCount: properties.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final property = properties[index];
        return DynamicPropertyCard<PropertyModel>(
          property: property,
          titleExtractor: (p) => p.title,
          priceExtractor: (p) => '\$${p.price.toInt()}',
          locationCodeExtractor: (p) => p.locationCode,
          locationExtractor: (p) => p.location,
          bedsExtractor: (p) => p.beds,
          bathsExtractor: (p) => p.baths,
          kitchensExtractor: (p) => p.kitchens,
          imageUrlExtractor: (p) => p.imageUrl,
          isFavoriteExtractor: (p) => p.isFavorite,
          propertyTypeExtractor: (p) => p.propertyType,
          // onFavoriteToggle: _toggleFavorite,
          onTap: (p) => _navigateToDetails(p.id),
        );
      },
    );
    //  // if (properties.isEmpty) {
    //  //   return const SizedBox(
    //  //     height: 200,
    //  //     child: Center(child: Text('No recommendations available')),
    //  //   );
    //  // }
    //  // // We'll just display the first property as a larger card
    //  // final property = properties.first;
    // return ListView.builder(
    //    physics: const NeverScrollableScrollPhysics(),
    //    shrinkWrap: true,
    //    itemCount: property.length,
    //    itemBuilder: (context, index) {
    //      return PropertyListingCard(
    //        property: property[index],
    //      );
    //    },
    //  );
    //  // return SizedBox(
    //  //   height: 55,
    //  //   child: Padding(
    //  //     padding: const EdgeInsets.only(left: 10),
    //  //     child: ListView.builder(
    //  //       itemCount: properties.length,
    //  //       scrollDirection: Axis.horizontal,
    //  //       itemBuilder: (context, index) {
    //  //         return InkWell(
    //  //           onTap: () {
    //  //             // homePageController
    //  //             //     .changeCategoryIndex(index);
    //  //             // homePageController.getCatWiseData(
    //  //             //   cId: homePageController.homeDatatInfo
    //  //             //       ?.homeData!.catlist![index].id,
    //  //             //   countryId: getData.read("countryId"),
    //  //             // );
    //  //           },
    //  //           child: Container(
    //  //             height: 50,
    //  //             padding: EdgeInsets.all(8),
    //  //             margin: EdgeInsets.only(
    //  //                 left: 5, right: 5, top: 7, bottom: 7),
    //  //             child: Row(
    //  //               mainAxisAlignment:
    //  //               MainAxisAlignment.center,
    //  //               children: [Image.asset(properties[index].imageUrl??''),
    //  //                 SizedBox(
    //  //                   width: 5,
    //  //                 ),
    //  //                 Text(
    //  //                   properties[index]?.name ??
    //  //                       "",
    //  //                   style: TextStyle(
    //  //                     fontFamily: FontFamily.gilroyBold,
    //  //                     color: properties[index].beds ==
    //  //                         index
    //  //                         ? Colors.black
    //  //                           : Colors.white,
    //  //                   ),
    //  //                 ),
    //  //               ],
    //  //             ),
    //  //             decoration: BoxDecoration(
    //  //               border: Border.all(
    //  //                   color: Colors.blue, width: 2),
    //  //               borderRadius: BorderRadius.circular(25),
    //  //               // color:
    //  //               // homePageController.catCurrentIndex == index ? blueColor : notifire.getbgcolor,
    //  //             ),
    //  //           ),
    //  //         );
    //  //       },
    //  //     ),
    //  //   ),
    //  // );
    //  // homePageController.isCatWise
    //  // ? homePageController
    //  //     .catWiseInfo!.propertyCat!.isNotEmpty
    //  // ? Padding(
    //  // padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //  // child: GridView.builder(
    //  // itemCount: homePageController
    //  //     .catWiseInfo?.propertyCat!.length,
    //  // shrinkWrap: true,
    //  // physics: NeverScrollableScrollPhysics(),
    //  // gridDelegate:
    //  // SliverGridDelegateWithFixedCrossAxisCount(
    //  // crossAxisCount: 2,
    //  // mainAxisExtent: 250,
    //  // ),
    //  // itemBuilder: (context, index) {
    //  // return InkWell(
    //  // onTap: () async {
    //  // setState(() {
    //  // homePageController.rate =
    //  // homePageController
    //  //     .catWiseInfo
    //  //     ?.propertyCat![index]
    //  //     .rate ??
    //  // "";
    //  // });
    //  // homePageController
    //  //     .chnageObjectIndex(index);
    //  // await homePageController
    //  //     .getPropertyDetailsApi(
    //  // id: homePageController.catWiseInfo
    //  //     ?.propertyCat![index].id,
    //  // );
    //  // Get.toNamed(Routes.viewDataScreen);
    //  // },
    //  // child: Container(
    //  // height: 250,
    //  // margin: EdgeInsets.all(8),
    //  // child: Column(
    //  // children: [
    //  // Stack(
    //  // children: [
    //  // Container(
    //  // height: 140,
    //  // width: Get.size.width,
    //  // margin: EdgeInsets.only(right: 8,left: 8,top: 8,),
    //  // child: ClipRRect(
    //  // borderRadius:
    //  // BorderRadius.circular(
    //  // 15),
    //  // child: FadeInImage
    //  //     .assetNetwork(
    //  // fadeInCurve:
    //  // Curves.easeInCirc,
    //  // placeholder:
    //  // "assets/images/ezgif.com-crop.gif",
    //  // height: 130,
    //  // width: Get.size.width,
    //  // imageErrorBuilder: (context, error, stackTrace) {
    //  // return Center(child: Image.asset("assets/images/emty.gif",fit: BoxFit.cover,height: Get.height,),);
    //  // },
    //  // image:
    //  // "${Config.imageUrl}${homePageController.catWiseInfo?.propertyCat![index].image ?? ""}",
    //  // fit: BoxFit.cover,
    //  // ),
    //  // ),
    //  // ),
    //  // homePageController
    //  //     .catWiseInfo
    //  //     ?.propertyCat![
    //  // index]
    //  //     .buyorrent ==
    //  // "1"
    //  // ? Positioned(
    //  // top: 15,
    //  // right: 20,
    //  // child: Container(
    //  // height: 30,
    //  // width: 45,
    //  // child: Row(
    //  // mainAxisAlignment:
    //  // MainAxisAlignment
    //  //     .center,
    //  // children: [
    //  // Container(
    //  // margin: const EdgeInsets
    //  //     .fromLTRB(
    //  // 0,
    //  // 0,
    //  // 3,
    //  // 0),
    //  // child: Image
    //  //     .asset(
    //  // "assets/images/Rating.png",
    //  // height: 15,
    //  // width: 15,
    //  // ),
    //  // ),
    //  // Text(
    //  // "${homePageController.catWiseInfo?.propertyCat![index].rate ?? ""}",
    //  // style:
    //  // TextStyle(
    //  // fontFamily:
    //  // FontFamily
    //  //     .gilroyMedium,
    //  // color:
    //  // blueColor,
    //  // ),
    //  // )
    //  // ],
    //  // ),
    //  // decoration:
    //  // BoxDecoration(
    //  // color: Color(
    //  // 0xFFedeeef),
    //  // borderRadius:
    //  // BorderRadius
    //  //     .circular(
    //  // 15),
    //  // ),
    //  // ),
    //  // )
    //  //     : Positioned(
    //  // top: 15,
    //  // right: 20,
    //  // child: Container(
    //  // height: 30,
    //  // width: 60,
    //  // alignment: Alignment
    //  //     .center,
    //  // child: Text(
    //  // "BUY".tr,
    //  // style: TextStyle(
    //  // color:
    //  // blueColor,
    //  // fontWeight:
    //  // FontWeight
    //  //     .w600),
    //  // ),
    //  // decoration:
    //  // BoxDecoration(
    //  // color: Color(
    //  // 0xFFedeeef),
    //  // borderRadius:
    //  // BorderRadius
    //  //     .circular(
    //  // 15),
    //  // ),
    //  // ),
    //  // ),
    //  // ],
    //  // ),
    //  // Expanded(
    //  // child: Container(
    //  // height: 128,
    //  // width: Get.size.width,
    //  // margin: EdgeInsets.all(5),
    //  // child: Column(
    //  // crossAxisAlignment:
    //  // CrossAxisAlignment
    //  //     .start,
    //  // children: [
    //  // Padding(
    //  // padding:
    //  // const EdgeInsets
    //  //     .only(left: 10),
    //  // child: Text(
    //  // homePageController
    //  //     .catWiseInfo
    //  //     ?.propertyCat![
    //  // index]
    //  //     .title ??
    //  // "",
    //  // maxLines: 1,
    //  // style: TextStyle(
    //  // fontSize: 17,
    //  // fontFamily:
    //  // FontFamily
    //  //     .gilroyBold,
    //  // color: notifire
    //  //     .getwhiteblackcolor,
    //  // overflow:
    //  // TextOverflow
    //  //     .ellipsis,
    //  // ),
    //  // ),
    //  // ),
    //  // Padding(
    //  // padding:
    //  // const EdgeInsets
    //  //     .only(
    //  // left: 10,
    //  // top: 6),
    //  // child: Row(
    //  // children: [
    //  // SvgPicture.asset("assets/images/location.svg",height: 16, colorFilter: ColorFilter.mode(notifire.getwhiteblackcolor, BlendMode.srcIn),),
    //  // SizedBox(width: 2,),
    //  // Flexible(
    //  // child: Text(
    //  // homePageController
    //  //     .catWiseInfo
    //  //     ?.propertyCat![
    //  // index]
    //  //     .city ??
    //  // "",
    //  // maxLines: 1,
    //  // style: TextStyle(
    //  // color: notifire
    //  //     .getgreycolor,
    //  // fontFamily: FontFamily
    //  //     .gilroyMedium,
    //  // overflow:
    //  // TextOverflow
    //  //     .ellipsis,
    //  // ),
    //  // ),
    //  // ),
    //  // ],
    //  // ),
    //  // ),
    //  // Padding(
    //  // padding:
    //  // const EdgeInsets
    //  //     .only(left: 10),
    //  // child: Row(
    //  // children: [
    //  // Padding(
    //  // padding:
    //  // const EdgeInsets
    //  //     .only(
    //  // top: 7),
    //  // child: Text(
    //  // "${currency}${homePageController.catWiseInfo?.propertyCat![index].price ?? ""}",
    //  // style:
    //  // TextStyle(
    //  // color: blueColor,
    //  // fontFamily:
    //  // FontFamily
    //  //     .gilroyBold,
    //  // fontSize: 17,
    //  // ),
    //  // ),
    //  // ),
    //  // homePageController
    //  //     .catWiseInfo
    //  //     ?.propertyCat![
    //  // index]
    //  //     .buyorrent ==
    //  // "1"
    //  // ? Padding(
    //  // padding: const EdgeInsets
    //  //     .only(
    //  // left: 3,
    //  // top: 7),
    //  // child: Text(
    //  // "/night"
    //  //     .tr,
    //  // style:
    //  // TextStyle(
    //  // color: notifire
    //  //     .getgreycolor,
    //  // fontFamily:
    //  // FontFamily.gilroyMedium,
    //  // ),
    //  // ),
    //  // )
    //  //     : Text(""),
    //  // ],
    //  // ),
    //  // )
    //  // ],
    //  // ),
    //  // ),
    //  // ),
    //  // ],
    //  // ),
    //  // decoration: BoxDecoration(
    //  // border: Border.all(
    //  // color: notifire.getborderColor),
    //  // borderRadius:
    //  // BorderRadius.circular(15),
    //  // color: notifire.getbgcolor,
    //  // ),
    //  // ),
    //  // );
    //  // },
    //  // ),
    //  // )
    //  //     : Padding(
    //  // padding: const EdgeInsets.symmetric(
    //  // horizontal: 14, vertical: 5),
    //  // child: Column(
    //  // children: [
    //  // SizedBox(height: Get.height * 0.10),
    //  // Image(
    //  // image: AssetImage(
    //  // "assets/images/searchDataEmpty.png",
    //  // ),
    //  // height: 110,
    //  // width: 110,
    //  // ),
    //  // Center(
    //  // child: SizedBox(
    //  // width: Get.width * 0.80,
    //  // child: Text(
    //  // "Sorry, there is no any nearby \n category or data not found"
    //  //     .tr,
    //  // textAlign: TextAlign.center,
    //  // style: TextStyle(
    //  // color: notifire.getgreycolor,
    //  // fontFamily:
    //  // FontFamily.gilroyBold,
    //  // ),
    //  // ),
    //  // ),
    //  // ),
    //  // ],
    //  // ),
    //  // )
    //  //     : Center(
    //  // child: CircularProgressIndicator(),
    //  // )
    //  // return properties!.isNotEmpty
    //  //     ? Padding(
    //  //   padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //  //   child: GridView.builder(
    //  //     itemCount: properties.length,
    //  //     shrinkWrap: true,
    //  //     physics: NeverScrollableScrollPhysics(),
    //  //     gridDelegate:
    //  //     SliverGridDelegateWithFixedCrossAxisCount(
    //  //       crossAxisCount: 2,
    //  //       mainAxisExtent: 250,
    //  //     ),
    //  //     itemBuilder: (context, index) {
    //  //       return InkWell(
    //  //         onTap: () async {
    //  //           // setState(() {
    //  //           //   // homePageController.rate =
    //  //           //   //     homePageController
    //  //           //   //         .catWiseInfo
    //  //           //   //         ?.propertyCat![index]
    //  //           //   //         .rate ??
    //  //           //           "";
    //  //           // });
    //  //           // homePageController
    //  //           //     .chnageObjectIndex(index);
    //  //           // await homePageController
    //  //           //     .getPropertyDetailsApi(
    //  //           //   id: homePageController.catWiseInfo
    //  //           //       ?.propertyCat![index].id,
    //  //           // );
    //  //           // Get.toNamed(Routes.viewDataScreen);
    //  //         },
    //  //         child: Container(
    //  //           height: 250,width: 100,
    //  //           margin: EdgeInsets.all(8),
    //  //           decoration: BoxDecoration(
    //  //             border: Border.all(
    //  //                 color: Colors.white,),
    //  //             borderRadius:
    //  //             BorderRadius.circular(15),
    //  //             color: Colors.white,
    //  //           ),
    //  //           child: Column(
    //  //             children: [
    //  //               Stack(
    //  //                 children: [
    //  //                   Container(
    //  //                     height: 140,
    //  //                     width: MediaQuery.of(context).size.width,
    //  //                     margin: EdgeInsets.only(right: 8, left: 8, top: 8,),
    //  //                     child: ClipRRect(
    //  //                         borderRadius:
    //  //                         BorderRadius.circular(
    //  //                             15),
    //  //                         child: Image.asset(properties[index].imageUrl ?? '',fit: BoxFit.cover,height: 140,
    //  //                           width: MediaQuery.of(context).size.width,)
    //  //                     ),
    //  //                   ),
    //  //                   properties[index]
    //  //                       .rating !=
    //  //                       "1"
    //  //                       ? Positioned(
    //  //                     top: 15,
    //  //                     right: 20,
    //  //                     child: Container(
    //  //                       height: 30,
    //  //                       width: 45,
    //  //                       child: Row(
    //  //                         mainAxisAlignment:
    //  //                         MainAxisAlignment
    //  //                             .center,
    //  //                         children: [
    //  //                           Container(
    //  //                             margin: const EdgeInsets
    //  //                                 .fromLTRB(
    //  //                                 0,
    //  //                                 0,
    //  //                                 3,
    //  //                                 0),
    //  //                             child: Image
    //  //                                 .asset(
    //  //                               "assets/images/images/Rating.png",
    //  //                               height: 15,
    //  //                               width: 15,
    //  //                             ),
    //  //                           ),
    //  //                           Text(
    //  //                             "${properties[index]?.rating ?? ""}",
    //  //                             style:
    //  //                             TextStyle(
    //  //                               fontFamily:
    //  //                               FontFamily
    //  //                                   .gilroyMedium,
    //  //                               color:
    //  //                               Colors.blue,
    //  //                             ),
    //  //                           )
    //  //                         ],
    //  //                       ),
    //  //                       decoration:
    //  //                       BoxDecoration(
    //  //                         color: Color(
    //  //                             0xFFedeeef),
    //  //                         borderRadius:
    //  //                         BorderRadius
    //  //                             .circular(
    //  //                             15),
    //  //                       ),
    //  //                     ),
    //  //                   )
    //  //                       : Positioned(
    //  //                     top: 15,
    //  //                     right: 20,
    //  //                     child: Container(
    //  //                       height: 30,
    //  //                       width: 60,
    //  //                       alignment: Alignment
    //  //                           .center,
    //  //                       child: Text(
    //  //                         "BUY".tr,
    //  //                         style: TextStyle(
    //  //                             color:
    //  //                             Colors.blue,
    //  //                             fontWeight:
    //  //                             FontWeight
    //  //                                 .w600),
    //  //                       ),
    //  //                       decoration:
    //  //                       BoxDecoration(
    //  //                         color: Color(
    //  //                             0xFFedeeef),
    //  //                         borderRadius:
    //  //                         BorderRadius
    //  //                             .circular(
    //  //                             15),
    //  //                       ),
    //  //                     ),
    //  //                   ),
    //  //                 ],
    //  //               ),
    //  //               Expanded(
    //  //                 child: Container(
    //  //                   height: 128,
    //  //                   width:MediaQuery.of(context).size.width,
    //  //                   margin: EdgeInsets.all(5),
    //  //                   child: Column(
    //  //                     crossAxisAlignment:
    //  //                     CrossAxisAlignment
    //  //                         .start,
    //  //                     children: [
    //  //                       Padding(
    //  //                         padding:
    //  //                         const EdgeInsets
    //  //                             .only(left: 10),
    //  //                         child: Text(
    //  //                           properties[
    //  //                           index]
    //  //                               .name ??
    //  //                               "",
    //  //                           maxLines: 1,
    //  //                           style: TextStyle(
    //  //                             fontSize: 17,
    //  //                             fontFamily:
    //  //                             FontFamily
    //  //                                 .gilroyBold,
    //  //                             color: Colors.white,
    //  //                             overflow:
    //  //                             TextOverflow
    //  //                                 .ellipsis,
    //  //                           ),
    //  //                         ),
    //  //                       ),
    //  //                       Padding(
    //  //                         padding:
    //  //                         const EdgeInsets
    //  //                             .only(
    //  //                             left: 10,
    //  //                             top: 6),
    //  //                         child: Row(
    //  //                           children: [
    //  //                             SvgPicture.asset(
    //  //                               "assets/images/images/location.svg", height: 16,
    //  //                               colorFilter: ColorFilter.mode(
    //  //                                   Colors.white,
    //  //                                   BlendMode.srcIn),),
    //  //                             SizedBox(width: 2,),
    //  //                             Flexible(
    //  //                               child: Text(
    //  //                                 properties[
    //  //                                 index]
    //  //                                     .country ??
    //  //                                     "",
    //  //                                 maxLines: 1,
    //  //                                 style: TextStyle(
    //  //                                   color: Colors.white,
    //  //                                   fontFamily: FontFamily
    //  //                                       .gilroyMedium,
    //  //                                   overflow:
    //  //                                   TextOverflow
    //  //                                       .ellipsis,
    //  //                                 ),
    //  //                               ),
    //  //                             ),
    //  //                           ],
    //  //                         ),
    //  //                       ),
    //  //                       Padding(
    //  //                         padding:
    //  //                         const EdgeInsets
    //  //                             .only(left: 10),
    //  //                         child: Row(
    //  //                           children: [
    //  //                             Padding(
    //  //                               padding:
    //  //                               const EdgeInsets
    //  //                                   .only(
    //  //                                   top: 7),
    //  //                               child: Text(
    //  //                                 "${currency}${properties![index].price ??
    //  //                                     ""}",
    //  //                                 style:
    //  //                                 TextStyle(
    //  //                                   color: Colors.blue,
    //  //                                   fontFamily:
    //  //                                   FontFamily
    //  //                                       .gilroyBold,
    //  //                                   fontSize: 17,
    //  //                                 ),
    //  //                               ),
    //  //                             ),
    //  //                             properties[
    //  //                             index]
    //  //                                 .rating ==
    //  //                                 "1"
    //  //                                 ? Padding(
    //  //                               padding: const EdgeInsets
    //  //                                   .only(
    //  //                                   left: 3,
    //  //                                   top: 7),
    //  //                               child: Text(
    //  //                                 "/night"
    //  //                                     .tr,
    //  //                                 style:
    //  //                                 TextStyle(
    //  //                                   color: Colors.grey,
    //  //                                   fontFamily:
    //  //                                   FontFamily.gilroyMedium,
    //  //                                 ),
    //  //                               ),
    //  //                             )
    //  //                                 : Text(""),
    //  //                           ],
    //  //                         ),
    //  //                       )
    //  //                     ],
    //  //                   ),
    //  //                 ),
    //  //               ),
    //  //             ],
    //  //           ),
    //  //         ),
    //  //       );
    //  //     },
    //  //   ),
    //  // )
    //  //     :Container();
    //  //     : Padding(
    //  //   padding: const EdgeInsets.symmetric(
    //  //       horizontal: 14, vertical: 5),
    //  //   child: Column(
    //  //     children: [
    //  //       SizedBox(height: Get.height * 0.10),
    //  //       Image(
    //  //         image: AssetImage(
    //  //           "assets/images/searchDataEmpty.png",
    //  //         ),
    //  //         height: 110,
    //  //         width: 110,
    //  //       ),
    //  //       Center(
    //  //         child: SizedBox(
    //  //           width: Get.width * 0.80,
    //  //           child: Text(
    //  //             "Sorry, there is no any nearby \n category or data not found"
    //  //                 .tr,
    //  //             textAlign: TextAlign.center,
    //  //             style: TextStyle(
    //  //               color: notifire.getgreycolor,
    //  //               fontFamily:
    //  //               FontFamily.gilroyBold,
    //  //             ),
    //  //           ),
    //  //         ),
    //  //       ),
    //  //     ],
    //  //   ),
    //  // )
  }
}
