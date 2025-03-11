import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';
import '../../../model/home/details_model.dart';
import '../bloc/property_bloc.dart';

class PropertyViewScreen extends StatefulWidget {
  final String propertyId;

  const PropertyViewScreen({
    Key? key,
    required this.propertyId,
  }) : super(key: key);

  @override
  _PropertyViewScreenState createState() => _PropertyViewScreenState();
}

class _PropertyViewScreenState extends State<PropertyViewScreen> {
  int _selectedImageIndex = 0;
  final List<Marker> _markers = <Marker>[];
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    context.read<PropertyBloc>().add(LoadPropertyDetails(widget.propertyId));
  }

  Future<Uint8List> _getMarkerImage(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetHeight: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _setupMarker(PropertyDetailsModel property) async {
    final Uint8List markerIcon = await _getMarkerImage("assets/images/images/MapPin.png", 100);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(property.id),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(
            property.latitude,
            property.longtitude,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<PropertyBloc, PropertyState>(
        listener: (context, state) {
          // Handle success messages
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.green,
              ),
            );
            // Clear messages after showing them
            context.read<PropertyBloc>().add(ClearMessages());
          }

          // Handle error messages
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
            // Clear messages after showing them
            context.read<PropertyBloc>().add(ClearMessages());
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.selectedProperty == null) {
            return Center(child: Text("Property not found"));
          }

          final property = state.selectedProperty!.propetydetails;
          final facilities = state.selectedProperty!.facility;
          final gallery = state.selectedProperty!.gallery;
          final reviews = state.selectedProperty!.reviewlist;

          // Setup map marker
          if (_markers.isEmpty) {
            _setupMarker(property);
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.white,
                  leading: _buildBackButton(),
                  actions: [
                    _buildFavoriteButton(property),
                    SizedBox(width: 10),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        _buildImagePageView(property.image),
                        _buildImageIndicators(property.image.length),
                        _buildPanoramaButton(property.image),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(property),
                      _buildPropertyTypeAndRating(property),
                      _buildAmenitiesSection(property),
                      _buildDivider(),
                    ///  _buildHostSection(property),
                      _buildAboutSection(property),
                      _buildFacilitiesSection(facilities),
                   //   if (gallery.isNotEmpty) _buildGallerySection(gallery),
                   //   _buildLocationSection(property),
                     // if (reviews.isNotEmpty) _buildReviewsSection(reviews, state.selectedProperty!.totalReview, property.rate),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
                _buildBottomPriceBar(property),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(17),
        child: Image.asset(
          "assets/images/images/Arrow - Left.png",
          color: Colors.blue,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(PropertyDetailsModel property) {
    return InkWell(
      onTap: () {
        context.read<PropertyBloc>().add(
          ToggleFavoriteProperty(
            propertyId: property.id,
            propertyType: property.propertyTitle,
          ),
        );
      },
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(14),
        child: Image.asset(
          property.isFavourite == 1
              ? "assets/images/images/Fev-Bold.png"
              : "assets/images/images/favorite.png",
          color: Colors.blue,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildImagePageView(List<PropertyImage> images) {
    return SizedBox(
      height: 470,
      child: PageView.builder(
        itemCount: images.length,
        physics: BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedImageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Image.asset(
            images[index].image,
            height: 470,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Center(
                child: Image.asset(
                  "assets/images/images/emty.gif",
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildImageIndicators(int imageCount) {
    if (imageCount <= 1) return SizedBox.shrink();

    return Positioned(
      bottom: 0,
      child: SizedBox(
        height: 25,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageCount,
                (index) => _buildIndicator(index == _selectedImageIndex),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        height: isActive ? 6 : 8,
        width: isActive ? 30 : 8,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildPanoramaButton(List<PropertyImage> images) {
    if (_selectedImageIndex >= images.length ||
        images[_selectedImageIndex].isPanorama != 1) {
      return SizedBox.shrink();
    }

    return Positioned(
      bottom: 10,
      right: 10,
      child: InkWell(
        onTap: () {
          // Navigate to panorama viewer
          // Get.toNamed('/panorama', arguments: {'img': images[_selectedImageIndex].image});
        },
        child: Container(
          height: 30,
          width: 70,
          padding: EdgeInsets.all(4),
          child: Image.asset("assets/images/images/360.png"),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(PropertyDetailsModel property) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Text(
        property.title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildPropertyTypeAndRating(PropertyDetailsModel property) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Row(
        children: [
          Container(
            height: 25,
            padding: EdgeInsets.all(5),
            child: Text(
              property.propertyTitle,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.blue,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFeef4ff),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 10),
          Image.asset(
            "assets/images/images/Rating.png",
            height: 20,
            width: 20,
          ),
          SizedBox(width: 7),
          Text(
            property.rate,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesSection(PropertyDetailsModel property) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAmenityItem(
            "assets/images/images/Frame1.png",
            "${property.beds} Beds",
          ),
          _buildAmenityItem(
            "assets/images/images/bath.png",
            "${property.bathroom} Bath",
          ),
          _buildAmenityItem(
            "assets/images/images/sqft.png",
            "${property.sqrft} sqft",
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem(String iconPath, String text) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          child: Image.asset(
            iconPath,
            height: 20,
            width: 20,
            color: Colors.blue,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFeef4ff),
          ),
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Divider(),
    );
  }

  Widget _buildHostSection(PropertyDetailsModel property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            "Hosted by",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(property.ownerImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            property.ownerName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            "Partner",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    // Handle phone call
                  },
                  child: Image.asset(
                    "assets/images/images/phone Icon.png",
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    // Handle chat
                  },
                  child: Image.asset(
                    "assets/images/images/Chat.png",
                    height: 28,
                    width: 28,
                    fit: BoxFit.cover,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(PropertyDetailsModel property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            "About this space",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
          child: ReadMoreText(
            property.description,
            trimLines: 4,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Show less',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitiesSection(List<FacilityModel> facilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            "What this place offers",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          itemCount: facilities.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  child: Image.asset(
                    facilities[index].img,
                    height: 25,
                    width: 25,
                    color: Colors.blue,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFeef4ff),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  facilities[index].title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildGallerySection(List<String> gallery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeaderWithSeeAll(
            "Gallery",
            "See All",
                () {
              // Navigate to gallery screen
              // Get.toNamed(Routes.galleryScreen, arguments: {
              //   "gallery": gallery,
              //   "propertyId": widget.propertyId,
              // });
            }
        ),
        Container(
          height: 110,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 15),
          child: ListView.builder(
            itemCount: gallery.length > 4 ? 4 : gallery.length, // Show max 4 in preview
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: 110,
                width: 110,
                margin: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    gallery[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Image.asset(
                          "assets/images/images/emty.gif",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(PropertyDetailsModel property) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            "Location",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 15),
            Image.asset(
              "assets/images/images/Location.png",
              height: 25,
              width: 25,
              fit: BoxFit.cover,
              color: Color(0xff3D5BF6),
            ),
            SizedBox(width: 5),
            Text(
              property.city,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                property.latitude,
                 property.longtitude,
                ),
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0.5, 0.5),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsSection(List<ReviewModel> reviews, String totalReviews, String rate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeaderWithSeeAll(
          "★ $rate ($totalReviews reviews)",
          "See All",
              () {
            // Navigate to reviews screen
            // Get.toNamed(Routes.reviewScreen, arguments: {"reviews": reviews});
          },
          icon: Icon(Icons.star, color: Colors.yellow),
        ),
        ListView.builder(
          itemCount: reviews.length > 2 ? 2 : reviews.length, // Show max 2 in preview
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(reviews[index].userImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                reviews[index].userTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              subtitle: Text(
                reviews[index].userDesc,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Container(
                height: 40,
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      reviews[index].userRate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeaderWithSeeAll(String title, String buttonText, VoidCallback onPressed, {Icon? icon}) {
    return Row(
      children: [
        SizedBox(width: 15),
        if (icon != null) icon,
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildBottomPriceBar(PropertyDetailsModel property) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      "Price",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Row(
                      children: [
                        Text(
                          "\$${property.price}",
                          style: TextStyle(
                            color: Color(0xFF4772ff),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        property.buyorrent == "1"
                            ? Text(
                          "/night",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                            : Text(""),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: property.buyorrent == "1"
                  ? _buildActionButton(
                "Book",
                Color(0xFF4772ff),
                    () {
                  // Handle booking
                  // if (user is logged in) {
                  //   Get.toNamed(Routes.bookRealEstate);
                  // } else {
                  //   showToastMessage("Please login and Book");
                  // }
                },
              )
                  : property.isEnquiry == 1
                  ? _buildActionButton(
                "Contacted",
                Colors.red,
                    () {
                  // Show toast message
                  // Fluttertoast.showToast(
                  //   msg: "Enquiry Already Send!!",
                  //   backgroundColor: Colors.red,
                  // );
                },
              )
                  : _buildActionButton(
                "Inquiry",
                Color(0xFF4772ff),
                    () {
                  // Handle inquiry
                  // if (user is logged in) {
                  //   context.read<PropertyBloc>().add(
                  //     SendPropertyEnquiry(
                  //       propertyId: property.id,
                  //     ),
                  //   );
                  //   Navigator.pop(context);
                  // } else {
                  //   showToastMessage("Please login and send enquiry");
                  // }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}