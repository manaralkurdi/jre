// import 'dart:async';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../base/bloc/base_bloc.dart';
// import '../../../model/home/details_model.dart';
//
// part 'property_event.dart';
//
// part 'property_state.dart';
//
// class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
//   // Repository would typically be injected here
//   // final PropertyRepository _propertyRepository;
//
//   PropertyBloc(
//     // this._propertyRepository,
//   ) : super(PropertyState.initial()) {
//     // Load properties
//     on<LoadAllProperties>(_onLoadAllProperties);
//     on<LoadFeaturedProperties>(_onLoadFeaturedProperties);
//     on<LoadRecommendedProperties>(_onLoadRecommendedProperties);
//
//     // Property details
//     on<LoadPropertyDetails>(_onLoadPropertyDetails);
//
//     // Property actions
//     on<ToggleFavoriteProperty>(_onToggleFavoriteProperty);
//     on<SendPropertyEnquiry>(_onSendPropertyEnquiry);
//
//     // Filters
//     on<FilterPropertiesByType>(_onFilterPropertiesByType);
//     on<SearchProperties>(_onSearchProperties);
//
//     // UI state
//     on<ClearMessages>(_onClearMessages);
//   }
//
//   // Mock data for demonstration
//   static final List<PropertyDetailsResponse> _mockProperties = _getMockData();
//
//   // Event handlers
//   Future<void> _onLoadAllProperties(
//     LoadAllProperties event,
//     Emitter<PropertyState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: PropertyStatus.loading, isLoading: true));
//
//       // In a real app, this would be a repository call
//       // final properties = await _propertyRepository.getAllProperties();
//       final properties = _mockProperties;
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.loaded,
//           isLoading: false,
//           allProperties: properties,
//           filteredProperties: properties,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           isLoading: false,
//           errorMessage: 'Failed to load properties: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   Future<void> _onLoadFeaturedProperties(
//     LoadFeaturedProperties event,
//     Emitter<PropertyState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: PropertyStatus.loading, isLoading: true));
//
//       // In a real app, this would be a repository call
//       // final properties = await _propertyRepository.getFeaturedProperties();
//       final properties = _mockProperties;
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.loaded,
//           isLoading: false,
//           featuredProperties: properties,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           isLoading: false,
//           errorMessage: 'Failed to load featured properties: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   Future<void> _onLoadRecommendedProperties(
//     LoadRecommendedProperties event,
//     Emitter<PropertyState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: PropertyStatus.loading, isLoading: true));
//
//       // In a real app, this would be a repository call
//       // final properties = await _propertyRepository.getRecommendedProperties();
//       final properties = _mockProperties;
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.loaded,
//           isLoading: false,
//           recommendedProperties: properties,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           isLoading: false,
//           errorMessage:
//               'Failed to load recommended properties: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   Future<void> _onLoadPropertyDetails(
//     LoadPropertyDetails event,
//     Emitter<PropertyState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: PropertyStatus.loading, isLoading: true));
//
//       // In a real app, this would be a repository call
//       // final property = await _propertyRepository.getPropertyDetails(event.propertyId);
//       final property = _mockProperties.firstWhere(
//         (prop) => prop.propetydetails.id == event.propertyId,
//         orElse: () => throw Exception('Property not found'),
//       );
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.detailsLoaded,
//           isLoading: false,
//           selectedProperty: property,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           isLoading: false,
//           errorMessage: 'Failed to load property details: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   Future<void> _onToggleFavoriteProperty(
//     ToggleFavoriteProperty event,
//     Emitter<PropertyState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: PropertyStatus.loading, isLoading: true));
//
//       // In a real app, this would be a repository call
//       // await _propertyRepository.toggleFavorite(event.propertyId, event.propertyType);
//
//       // Update all property lists
//       final updatedAll = _updateFavoriteInList(
//         state.allProperties,
//         event.propertyId,
//       );
//
//       final updatedFeatured = _updateFavoriteInList(
//         state.featuredProperties,
//         event.propertyId,
//       );
//
//       final updatedRecommended = _updateFavoriteInList(
//         state.recommendedProperties,
//         event.propertyId,
//       );
//
//       final updatedFiltered = _updateFavoriteInList(
//         state.filteredProperties,
//         event.propertyId,
//       );
//
//       // Also update selected property if it matches
//       PropertyDetailsResponse? updatedSelected;
//       if (state.selectedProperty != null &&
//           state.selectedProperty!.propetydetails.id == event.propertyId) {
//         updatedSelected = _toggleFavoriteOnProperty(state.selectedProperty!);
//       }
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.operationSuccess,
//           isLoading: false,
//           allProperties: updatedAll,
//           featuredProperties: updatedFeatured,
//           recommendedProperties: updatedRecommended,
//           filteredProperties: updatedFiltered,
//           selectedProperty: updatedSelected,
//           successMessage: 'Property favorites updated successfully',
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           isLoading: false,
//           errorMessage: 'Failed to update favorite: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   Future<void> _onSendPropertyEnquiry(
//     SendPropertyEnquiry event,
//     Emitter<PropertyState> emit,
//   ) async {
//     try {
//       emit(state.copyWith(status: PropertyStatus.loading, isLoading: true));
//
//       // In a real app, this would be a repository call
//       // await _propertyRepository.sendEnquiry(event.propertyId);
//
//       // Update the property in all lists to show enquiry was sent
//       final updatedAll = _updateEnquiryInList(
//         state.allProperties,
//         event.propertyId,
//       );
//
//       final updatedFeatured = _updateEnquiryInList(
//         state.featuredProperties,
//         event.propertyId,
//       );
//
//       final updatedRecommended = _updateEnquiryInList(
//         state.recommendedProperties,
//         event.propertyId,
//       );
//
//       final updatedFiltered = _updateEnquiryInList(
//         state.filteredProperties,
//         event.propertyId,
//       );
//
//       // Also update selected property if it matches
//       PropertyDetailsResponse? updatedSelected;
//       if (state.selectedProperty != null &&
//           state.selectedProperty!.propetydetails.id == event.propertyId) {
//         updatedSelected = _setEnquiryOnProperty(state.selectedProperty!);
//       }
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.operationSuccess,
//           isLoading: false,
//           allProperties: updatedAll,
//           featuredProperties: updatedFeatured,
//           recommendedProperties: updatedRecommended,
//           filteredProperties: updatedFiltered,
//           selectedProperty: updatedSelected,
//           successMessage: 'Enquiry sent successfully',
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           isLoading: false,
//           errorMessage: 'Failed to send enquiry: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   void _onFilterPropertiesByType(
//     FilterPropertiesByType event,
//     Emitter<PropertyState> emit,
//   ) {
//     try {
//       // If "All" is selected, show all properties
//       if (event.propertyType == 'All') {
//         emit(
//           state.copyWith(
//             status: PropertyStatus.loaded,
//             selectedPropertyType: event.propertyType,
//             filteredProperties: state.allProperties,
//           ),
//         );
//         return;
//       }
//
//       // Otherwise filter by property type
//       final filtered =
//           state.allProperties.where((property) {
//             return property.propetydetails.propertyTitle == event.propertyType;
//           }).toList();
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.loaded,
//           selectedPropertyType: event.propertyType,
//           filteredProperties: filtered,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           errorMessage: 'Error filtering properties: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   void _onSearchProperties(
//     SearchProperties event,
//     Emitter<PropertyState> emit,
//   ) {
//     try {
//       final query = event.query.toLowerCase();
//
//       // If query is empty, show all properties (or filtered by type if set)
//       if (query.isEmpty) {
//         if (state.selectedPropertyType == 'All') {
//           emit(
//             state.copyWith(
//               status: PropertyStatus.loaded,
//               filteredProperties: state.allProperties,
//             ),
//           );
//         } else {
//           _onFilterPropertiesByType(
//             FilterPropertiesByType(state.selectedPropertyType),
//             emit,
//           );
//         }
//         return;
//       }
//
//       // Filter properties by search query
//       List<PropertyDetailsResponse> filtered;
//
//       // First, filter by property type if needed
//       if (state.selectedPropertyType != 'All') {
//         filtered =
//             state.allProperties.where((property) {
//               return property.propetydetails.propertyTitle ==
//                   state.selectedPropertyType;
//             }).toList();
//       } else {
//         filtered = List.of(state.allProperties);
//       }
//
//       // Then, filter by search query
//       filtered =
//           filtered.where((property) {
//             final details = property.propetydetails;
//             return details.title.toLowerCase().contains(query) ||
//                 details.description.toLowerCase().contains(query) ||
//                 details.city.toLowerCase().contains(query) ||
//                 details.propertyTitle.toLowerCase().contains(query);
//           }).toList();
//
//       emit(
//         state.copyWith(
//           status: PropertyStatus.loaded,
//           filteredProperties: filtered,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: PropertyStatus.error,
//           errorMessage: 'Error searching properties: ${e.toString()}',
//         ),
//       );
//     }
//   }
//
//   void _onClearMessages(ClearMessages event, Emitter<PropertyState> emit) {
//     emit(state.copyWith(clearMessages: true));
//   }
//
//   // Helper functions
//   List<PropertyDetailsResponse> _updateFavoriteInList(
//     List<PropertyDetailsResponse> properties,
//     String propertyId,
//   ) {
//     return properties.map((property) {
//       if (property.propetydetails.id == propertyId) {
//         return _toggleFavoriteOnProperty(property);
//       }
//       return property;
//     }).toList();
//   }
//
//   PropertyDetailsResponse _toggleFavoriteOnProperty(
//     PropertyDetailsResponse property,
//   ) {
//     // Toggle the favorite status
//     final currentStatus = property.propetydetails.isFavourite;
//     final newStatus = currentStatus == 1 ? 0 : 1;
//
//     // Create new property details with toggled favorite status
//     final updatedDetails = PropertyDetailsModel(
//       id: property.propetydetails.id,
//       title: property.propetydetails.title,
//       description: property.propetydetails.description,
//       price: property.propetydetails.price,
//       city: property.propetydetails.city,
//       propertyTitle: property.propetydetails.propertyTitle,
//       beds: property.propetydetails.beds,
//       bathroom: property.propetydetails.bathroom,
//       sqrft: property.propetydetails.sqrft,
//       latitude: property.propetydetails.latitude,
//       longtitude: property.propetydetails.longtitude,
//       ownerName: property.propetydetails.ownerName,
//       ownerImage: property.propetydetails.ownerImage,
//       mobile: property.propetydetails.mobile,
//       userId: property.propetydetails.userId,
//       image: property.propetydetails.image,
//       isFavourite: newStatus,
//       buyorrent: property.propetydetails.buyorrent,
//       rate: property.propetydetails.rate,
//       isEnquiry: property.propetydetails.isEnquiry,
//       plimit: property.propetydetails.plimit,
//     );
//
//     // Return new property response with updated details
//     return PropertyDetailsResponse(
//       propetydetails: updatedDetails,
//       facility: property.facility,
//       gallery: property.gallery,
//       reviewlist: property.reviewlist,
//       totalReview: property.totalReview,
//     );
//   }
//
//   List<PropertyDetailsResponse> _updateEnquiryInList(
//     List<PropertyDetailsResponse> properties,
//     String propertyId,
//   ) {
//     return properties.map((property) {
//       if (property.propetydetails.id == propertyId) {
//         return _setEnquiryOnProperty(property);
//       }
//       return property;
//     }).toList();
//   }
//
//   PropertyDetailsResponse _setEnquiryOnProperty(
//     PropertyDetailsResponse property,
//   ) {
//     // Create new property details with enquiry status set to 1
//     final updatedDetails = PropertyDetailsModel(
//       id: property.propetydetails.id,
//       title: property.propetydetails.title,
//       description: property.propetydetails.description,
//       price: property.propetydetails.price,
//       city: property.propetydetails.city,
//       propertyTitle: property.propetydetails.propertyTitle,
//       beds: property.propetydetails.beds,
//       bathroom: property.propetydetails.bathroom,
//       sqrft: property.propetydetails.sqrft,
//       latitude: property.propetydetails.latitude,
//       longtitude: property.propetydetails.longtitude,
//       ownerName: property.propetydetails.ownerName,
//       ownerImage: property.propetydetails.ownerImage,
//       mobile: property.propetydetails.mobile,
//       userId: property.propetydetails.userId,
//       image: property.propetydetails.image,
//       isFavourite: property.propetydetails.isFavourite,
//       buyorrent: property.propetydetails.buyorrent,
//       rate: property.propetydetails.rate,
//       isEnquiry: 1,
//       // Set enquiry to sent
//       plimit: property.propetydetails.plimit,
//     );
//
//     // Return new property response with updated details
//     return PropertyDetailsResponse(
//       propetydetails: updatedDetails,
//       facility: property.facility,
//       gallery: property.gallery,
//       reviewlist: property.reviewlist,
//       totalReview: property.totalReview,
//     );
//   }
//
//   // Mock data generator
//   static List<PropertyDetailsResponse> _getMockData() {
//     return [
//       PropertyDetailsResponse(
//         propetydetails: PropertyDetailsModel(
//           id: "1",
//           title: "Luxury Ocean View Apartment",
//           description:
//               "Experience the ultimate in waterfront living with this stunning luxury apartment featuring panoramic ocean views. This beautiful apartment offers an open floor plan with high-end finishes throughout, including hardwood floors, granite countertops, and stainless steel appliances. Enjoy the sunrise from your private balcony and take advantage of all the building amenities.",
//           price: "750000",
//           city: "Miami, FL",
//           propertyTitle: "Apartment",
//           beds: "3",
//           bathroom: "2",
//           sqrft: "1850",
//           latitude: 41.8781,
//           longtitude: -87.6298,
//           ownerName: "John Smith",
//           ownerImage: "https://randomuser.me/api/portraits/men/32.jpg",
//           mobile: "+1234567890",
//           userId: "101",
//           image: [
//             PropertyImage(
//               image: "assets/images/images/property1_1.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property1_2.jpg",
//               isPanorama: 1,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property1_3.jpg",
//               isPanorama: 0,
//             ),
//           ],
//           isFavourite: 0,
//           buyorrent: "0",
//           // Buy
//           rate: "4.8",
//           isEnquiry: 0,
//           plimit: "5",
//         ),
//         facility: [
//           FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
//           FacilityModel(title: "Pool", img: "assets/images/images/pool.png"),
//           FacilityModel(title: "Gym", img: "assets/images/images/gym.png"),
//           FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
//           FacilityModel(title: "AC", img: "assets/images/images/ac.png"),
//           FacilityModel(title: "Kitchen", img: "assets/images/images/kitchen.png"),
//         ],
//         gallery: [
//           "assets/images/images/property1_1.jpg",
//           "assets/images/images/property1_2.jpg",
//           "assets/images/images/property1_3.jpg",
//           "assets/images/images/property1_4.jpg",
//         ],
//         reviewlist: [
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/women/44.jpg",
//             userTitle: "Sarah Johnson",
//             userDesc:
//                 "Incredible property with breathtaking views. The amenities are top-notch and the location is perfect for beach access.",
//             userRate: "4.9",
//           ),
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/men/22.jpg",
//             userTitle: "Michael Thomas",
//             userDesc:
//                 "Great investment opportunity in a prime location. The property is well-maintained and the building staff is very professional.",
//             userRate: "4.7",
//           ),
//         ],
//         totalReview: "12",
//       ),
//
//       PropertyDetailsResponse(
//         propetydetails: PropertyDetailsModel(
//           id: "2",
//           title: "Modern Beachfront Villa",
//           description:
//               "Escape to paradise in this stunning beachfront villa with direct access to pristine white sand beaches. This modern architectural masterpiece features floor-to-ceiling windows that bring the ocean views inside. The villa includes a private infinity pool, gourmet kitchen, and smart home technology throughout. Perfect for those seeking luxury and privacy.",
//           price: "4500",
//           city: "Bali, Indonesia",
//           propertyTitle: "Villa",
//           beds: "4",
//           bathroom: "3",
//           sqrft: "3500",
//           latitude: 41.8781,
//           longtitude: -87.6298,
//           ownerName: "Maya Wijaya",
//           ownerImage: "https://randomuser.me/api/portraits/women/65.jpg",
//           mobile: "+6281234567",
//           userId: "102",
//           image: [
//             PropertyImage(
//               image: "assets/images/images/property2_1.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property2_2.jpg",
//               isPanorama: 1,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property2_3.jpg",
//               isPanorama: 0,
//             ),
//           ],
//           isFavourite: 1,
//           buyorrent: "1",
//           // Rent
//           rate: "4.9",
//           isEnquiry: 0,
//           plimit: "8",
//         ),
//         facility: [
//           FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
//           FacilityModel(title: "Pool", img: "assets/images/images/pool.png"),
//           FacilityModel(title: "Garden", img: "assets/images/images/garden.png"),
//           FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
//           FacilityModel(title: "AC", img: "assets/images/images/ac.png"),
//           FacilityModel(title: "Kitchen", img: "assets/images/images/kitchen.png"),
//         ],
//         gallery: [
//           "assets/images/images/property2_1.jpg",
//           "assets/images/images/property2_2.jpg",
//           "assets/images/images/property2_3.jpg",
//           "assets/images/images/property2_4.jpg",
//         ],
//         reviewlist: [
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/women/23.jpg",
//             userTitle: "Emma Lawrence",
//             userDesc:
//                 "This villa exceeded our expectations. The view is incredible and the staff was attentive to our every need.",
//             userRate: "5.0",
//           ),
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/men/45.jpg",
//             userTitle: "David Chen",
//             userDesc:
//                 "Perfect honeymoon getaway. The private pool and beach access made our stay magical. Will definitely return!",
//             userRate: "4.8",
//           ),
//         ],
//         totalReview: "18",
//       ),
//
//       PropertyDetailsResponse(
//         propetydetails: PropertyDetailsModel(
//           id: "3",
//           title: "Urban Loft in Historic District",
//           description:
//               "Experience the perfect blend of historic charm and modern design in this converted industrial loft. Located in the heart of the city's arts district, this property features exposed brick walls, soaring ceilings, and original hardwood floors. The open concept living space is flooded with natural light from oversized windows. Walking distance to trendy restaurants, galleries, and shops.",
//           price: "495000",
//           city: "Portland, OR",
//           propertyTitle: "Loft",
//           beds: "1",
//           bathroom: "2",
//           sqrft: "1200",
//           latitude: 41.8781,
//           longtitude: -87.6298,
//           ownerName: "Alex Rivera",
//           ownerImage: "https://randomuser.me/api/portraits/men/67.jpg",
//           mobile: "+15035557890",
//           userId: "103",
//           image: [
//             PropertyImage(
//               image: "assets/images/images/property3_1.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property3_2.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property3_3.jpg",
//               isPanorama: 0,
//             ),
//           ],
//           isFavourite: 0,
//           buyorrent: "0",
//           // Buy
//           rate: "4.6",
//           isEnquiry: 0,
//           plimit: "2",
//         ),
//         facility: [
//           FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
//           FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
//           FacilityModel(title: "Elevator", img: "assets/images/images/elevator.png"),
//           FacilityModel(title: "Security", img: "assets/images/images/security.png"),
//         ],
//         gallery: [
//           "assets/images/images/property3_1.jpg",
//           "assets/images/images/property3_2.jpg",
//           "assets/images/images/property3_3.jpg",
//         ],
//         reviewlist: [
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/women/33.jpg",
//             userTitle: "Jessica Kim",
//             userDesc:
//                 "This loft is exactly what I was looking for - authentic character with all the modern amenities. The location can't be beat!",
//             userRate: "4.7",
//           ),
//         ],
//         totalReview: "6",
//       ),
//
//       PropertyDetailsResponse(
//         propetydetails: PropertyDetailsModel(
//           id: "4",
//           title: "Mountain Retreat with Panoramic Views",
//           description:
//               "Escape to this peaceful mountain sanctuary offering breathtaking panoramic views of the surrounding peaks and valleys. This custom-built home features vaulted ceilings, a stone fireplace, and large windows that frame the spectacular scenery. The property includes 5 acres of private land with hiking trails, a meditation garden, and outdoor entertaining areas.",
//           price: "3200",
//           city: "Aspen, CO",
//           propertyTitle: "Cabin",
//           beds: "3",
//           bathroom: "2",
//           sqrft: "2400",
//           latitude: 41.8781,
//           longtitude: -87.6298,
//           ownerName: "Robert Thornton",
//           ownerImage: "https://randomuser.me/api/portraits/men/52.jpg",
//           mobile: "+19705551234",
//           userId: "104",
//           image: [
//             PropertyImage(
//               image: "assets/images/images/property4_1.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property4_2.jpg",
//               isPanorama: 1,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property4_3.jpg",
//               isPanorama: 0,
//             ),
//           ],
//           isFavourite: 0,
//           buyorrent: "1",
//           // Rent
//           rate: "4.9",
//           isEnquiry: 0,
//           plimit: "6",
//         ),
//         facility: [
//           FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
//           FacilityModel(title: "Fireplace", img: "assets/images/fireplace.png"),
//           FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
//           FacilityModel(title: "Kitchen", img: "assets/images/images/kitchen.png"),
//           FacilityModel(title: "Hiking", img: "assets/images/images/hiking.png"),
//         ],
//         gallery: [
//           "assets/images/images/property4_1.jpg",
//           "assets/images/images/property4_2.jpg",
//           "assets/images/images/property4_3.jpg",
//           "assets/images/images/property4_4.jpg",
//           "assets/images/images/property4_5.jpg",
//         ],
//         reviewlist: [
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/women/55.jpg",
//             userTitle: "Laura Martinez",
//             userDesc:
//                 "This mountain retreat is magical! The views are even better than the photos, and the home is so comfortable and well-appointed.",
//             userRate: "5.0",
//           ),
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/men/33.jpg",
//             userTitle: "Christopher Wilson",
//             userDesc:
//                 "Perfect getaway for our family. We loved the hiking trails and sitting by the fireplace in the evenings.",
//             userRate: "4.8",
//           ),
//         ],
//         totalReview: "14",
//       ),
//
//       PropertyDetailsResponse(
//         propetydetails: PropertyDetailsModel(
//           id: "5",
//           title: "Stylish Downtown Penthouse",
//           description:
//               "Luxurious penthouse apartment in the heart of downtown offering the ultimate urban lifestyle. This stunning property features floor-to-ceiling windows with breathtaking city skyline views, high-end finishes, and smart home technology throughout. The gourmet kitchen includes top-of-the-line appliances and custom cabinetry. Building amenities include 24-hour concierge, rooftop pool, and fitness center.",
//           price: "1250000",
//           city: "Chicago, IL",
//           propertyTitle: "Penthouse",
//           beds: "3",
//           bathroom: "3",
//           sqrft: "3200",
//           latitude: 41.8781,
//           longtitude: -87.6298,
//           ownerName: "Victoria Chang",
//           ownerImage: "https://randomuser.me/api/portraits/women/28.jpg",
//           mobile: "+13125559876",
//           userId: "105",
//           image: [
//             PropertyImage(
//               image: "assets/images/images/property5_1.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property5_2.jpg",
//               isPanorama: 0,
//             ),
//             PropertyImage(
//               image: "assets/images/images/property5_3.jpg",
//               isPanorama: 1,
//             ),
//           ],
//           isFavourite: 1,
//           buyorrent: "0",
//           // Buy
//           rate: "4.7",
//           isEnquiry: 0,
//           plimit: "4",
//         ),
//         facility: [
//           FacilityModel(title: "WiFi", img: "assets/images/images/wifi.png"),
//           FacilityModel(title: "Pool", img: "assets/images/images/pool.png"),
//           FacilityModel(title: "Gym", img: "assets/images/images/gym.png"),
//           FacilityModel(title: "Parking", img: "assets/images/images/parking.png"),
//           FacilityModel(title: "Security", img: "assets/images/images/security.png"),
//           FacilityModel(title: "Elevator", img: "assets/images/images/elevator.png"),
//         ],
//         gallery: [
//           "assets/images/images/property5_1.jpg",
//           "assets/images/images/property5_2.jpg",
//           "assets/images/images/property5_3.jpg",
//           "assets/images/images/property5_4.jpg",
//         ],
//         reviewlist: [
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/men/41.jpg",
//             userTitle: "James Peterson",
//             userDesc:
//                 "Exceptional property with stunning views. The attention to detail in the design and finishes is impressive.",
//             userRate: "4.9",
//           ),
//           ReviewModel(
//             userImg: "https://randomuser.me/api/portraits/women/37.jpg",
//             userTitle: "Olivia Garcia",
//             userDesc:
//                 "The location and building amenities make this property stand out. Perfect for professionals who want luxury city living.",
//             userRate: "4.6",
//           ),
//         ],
//         totalReview: "9",
//       ),
//     ];
//   }
// }
