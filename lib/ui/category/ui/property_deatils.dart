import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jre_app/base/component/app_custom_text.dart';
import 'package:jre_app/domain/model/home/facility.dart';
import 'package:jre_app/ui/home/bloc/home_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

import '../../../domain/model/home/details.dart';
import '../../Details/bloc/details_bloc.dart';
import '../../Details/bloc/details_event.dart';
import '../../Details/bloc/details_state.dart';
import '../../home/bloc/home_event.dart';

class PropertyViewScreen extends StatefulWidget {
  final int propertyId;
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
  static final Map<String, Uint8List> _markerCache = {};
  bool _isSettingUpMarker = false;
  bool _isMapInitialized = false;
  LatLng _defaultLocation = LatLng(31.994717, 35.933664);
  late PropertyData _property = PropertyData();

  final List<FacilityModel> amenities = [
    FacilityModel(name: 'TV', icon: Icons.tv),
    FacilityModel(name: 'WiFi', icon: Icons.wifi),
    FacilityModel(name: 'Food', icon: Icons.restaurant),
    FacilityModel(name: 'Dryer', icon: Icons.dry),
    FacilityModel(name: 'Washing Machine', icon: Icons.local_laundry_service),
    FacilityModel(name: 'Fridge', icon: Icons.kitchen),
    FacilityModel(name: 'Pet Allow', icon: Icons.pets),
    FacilityModel(name: 'Car Parking', icon: Icons.local_parking),
  ];

  @override
  void initState() {
    super.initState();
    context.read<DetailsBloc>().add(LoadPropertyDetailsEvent(propertyId: widget.propertyId));
  }

  @override
  void didUpdateWidget(PropertyViewScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only setup markers again if property ID changes
    if (oldWidget.propertyId != widget.propertyId) {
      _markers.clear();
      _isMapInitialized = false;
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _markerCache.clear();
    super.dispose();
  }

  Future<Uint8List> _getMarkerImage(String path, int width) async {
    // Use cache to avoid reloading the same image
    if (_markerCache.containsKey(path)) {
      return _markerCache[path]!;
    }

    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(
          data.buffer.asUint8List(),
          targetHeight: width
      );
      ui.FrameInfo fi = await codec.getNextFrame();
      final Uint8List markerBytes = (await fi.image.toByteData(
          format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();

      // Cache the result
      _markerCache[path] = markerBytes;
      return markerBytes;
    } catch (e) {
      debugPrint("Error loading marker image: $e");
      throw Exception("Failed to load marker image: $e");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await Permission.location.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permissionGranted = await Permission.location.status;
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await Permission.location.request();
      if (permissionGranted == PermissionStatus.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }

    if (permissionGranted == PermissionStatus.permanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    return true;
  }

  Future<void> _setupMarker(PropertyData property) async {
    // Prevent multiple concurrent setup attempts
    if (_isSettingUpMarker) return;

    _isSettingUpMarker = true;

    try {
      // Load marker image - this can be expensive so we do it on demand
      final Uint8List markerIcon = await _getMarkerImage(
          "assets/images/images/MapPin.png", 100);

      // Only update UI if widget is still mounted
      if (!mounted) {
        _isSettingUpMarker = false;
        return;
      }

      final marker = Marker(
        markerId: MarkerId("1"),
        icon: BitmapDescriptor.fromBytes(markerIcon),
        position: _defaultLocation,
        infoWindow: InfoWindow(
          title: property.name ?? '',
          snippet: property.location ?? '',
        ),
      );

      setState(() {
        _markers.clear(); // Clear existing markers
        _markers.add(marker);
      });

      // Update map camera after a small delay to ensure map is ready
      Future.delayed(Duration(milliseconds: 300), () {
        if (_mapController != null && mounted) {
          _mapController!.moveCamera(
            CameraUpdate.newLatLngZoom(
              _defaultLocation,
              15.0,
            ),
          );
        }
      });

      debugPrint("Total markers: ${_markers.length}");
    } catch (e) {
      debugPrint("Error setting up marker: $e");
    } finally {
      _isSettingUpMarker = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<DetailsBloc, DetailsState>(
        listener: (context, state) {
          if (state.status == DetailsStatus.apiSuccessDetails) {
            _property = state.detailsProperties.data ?? PropertyData();

            if (_markers.isEmpty) {
              _setupMarker(_property);
            }
          }

          // Handle error messages
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return _buildShimmerLoading();
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
                    _buildFavoriteButton(_property),
                    SizedBox(width: 10),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        _buildImagePageView(_property.additionalImages ?? []),
                        _buildImageIndicators((_property.additionalImages ?? [])
                            .length),
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
                      _buildTitleSection(_property),
                      _buildPropertyTypeAndRating(_property),
                      _buildAmenitiesSection(_property),
                      _buildDivider(),
                      _buildAboutSection(_property),
                      _buildFacilitiesSection(amenities),
                      _buildLocationSection(_property),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
                _buildBottomPriceBar(_property),
              ],
            ),
          );
        },
      ),
    );
  }

  // Shimmer loading effect for the property view
  Widget _buildShimmerLoading() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: _buildBackButton(),
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.white,
              ),

              // Title placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20, right: 100),
                child: Container(
                  height: 25,
                  width: 200,
                  color: Colors.white,
                ),
              ),

              // Property type and rating placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 7),
                    Container(
                      height: 15,
                      width: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Amenities placeholder
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(3, (index) => _buildShimmerAmenityItem()),
                ),
              ),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Container(
                  height: 1,
                  color: Colors.white,
                ),
              ),

              // About section title placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Container(
                  height: 20,
                  width: 150,
                  color: Colors.white,
                ),
              ),

              // Description placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Column(
                  children: List.generate(4, (index) =>
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          height: 15,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      )
                  ),
                ),
              ),

              // Facilities section title placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 25),
                child: Container(
                  height: 20,
                  width: 180,
                  color: Colors.white,
                ),
              ),

              // Facilities grid placeholder
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: 60,
                          color: Colors.white,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Location section title placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 25),
                child: Container(
                  height: 20,
                  width: 80,
                  color: Colors.white,
                ),
              ),

              // Location text placeholder
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 15,
                      width: 200,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Map placeholder
              Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              // Bottom bar space
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomSheet: _buildShimmerBottomBar(),
    );
  }

  Widget _buildShimmerAmenityItem() {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 16,
          width: 60,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildShimmerBottomBar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Container(
                      height: 14,
                      width: 60,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 24,
                      width: 80,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
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

  Widget _buildFavoriteButton(PropertyData property) {
    return InkWell(
      onTap: () {
        context.read<HomeBloc>().add(
          ToggleFavoriteProperty(
            propertyId: property.id ?? '',
            propertyType: property.name ?? '',
          ),
        );
      },
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(14),
        child: Image.asset(
          property.isFeatured == "1"
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

  Widget _buildImagePageView(List<String> images) {
    if (images.isEmpty) {
      return Container(
        height: 470,
        width: double.infinity,
        color: Colors.grey[200],
        child: Center(
          child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
        ),
      );
    }

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
          return Image.network(
            images[index],
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

  Widget _buildTitleSection(PropertyData property) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Text(
        property.nameEn ?? '',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildPropertyTypeAndRating(PropertyData property) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Row(
        children: [
          Container(
            height: 25,
            padding: EdgeInsets.all(5),
            child: Text(
              property.nameEn ?? '',
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
            "4.5",
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

  Widget _buildAmenitiesSection(PropertyData property) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildAmenityItem(
            "assets/images/images/Frame1.png",
            "2 Beds",
          ),
          _buildAmenityItem(
            "assets/images/images/bath.png",
            "1 Bath",
          ),
          _buildAmenityItem(
            "assets/images/images/sqft.png",
            "${property.size ?? 0} sqft",
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

  Widget _buildAboutSection(PropertyData property) {
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
            property.description ?? "No description available",
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  child: Icon(
                    facilities[index].icon,
                    color: Colors.blue,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFeef4ff),
                  ),
                ),
                SizedBox(height: 8),
                AppCustomText(titleText:
                facilities[index].name,
                  maxLines: 2,textCenter:true,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  ),
                )
              ]
              ,
            );
          },
        ),
      ],
    );
  }

  Widget _buildLocationSection(PropertyData property) {
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
            Expanded(
              child: Text(
                property.location ?? "Location not available",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        Container(
          height: 200,
          width: MediaQuery
              .of(context)
              .size
              .width,
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _defaultLocation,
                zoom: 15.0,
              ),
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (_markers.isNotEmpty) {
                  _mapController?.showMarkerInfoWindow(_markers.first.markerId);
                }
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

  Widget _buildBottomPriceBar(PropertyData property) {
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      "Price",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          "\$${property.dailyPrice ?? 0}",
                          style: TextStyle(
                            color: Color(0xFF4772ff),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        AppCustomText(titleText:
                        "+ 25 JOD taxes and charges",
                          style: TextStyle(
                            color: Colors.grey.withOpacity(1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _buildActionButton(
                "Book",
                Color(0xFF4772ff),
                    () {
                  // Navigation to booking screen would go here
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