// part of 'property_bloc.dart';
//
// enum PropertyStatus {
//   initial,
//   loading,
//   loaded,
//   detailsLoaded,
//   operationSuccess,
//   error
// }
//
// class PropertyState extends BaseState {
//   final PropertyStatus status;
//   final bool isLoading;
//
//   // List properties
//   final List<PropertyDetailsResponse> allProperties;
//   final List<PropertyDetailsResponse> featuredProperties;
//   final List<PropertyDetailsResponse> recommendedProperties;
//   final List<PropertyDetailsResponse> filteredProperties;
//
//   // Selected property
//   final PropertyDetailsResponse? selectedProperty;
//
//   // Filter criteria
//   final String selectedPropertyType;
//
//   // Messages
//   final String? successMessage;
//   final String? errorMessage;
//
//   PropertyState({
//     required this.status,
//     this.isLoading = false,
//     this.allProperties = const [],
//     this.featuredProperties = const [],
//     this.recommendedProperties = const [],
//     this.filteredProperties = const [],
//     this.selectedProperty,
//     this.selectedPropertyType = 'All',
//     this.successMessage,
//     this.errorMessage,
//   });
//
//   factory PropertyState.initial() => PropertyState(
//     status: PropertyStatus.initial,
//     allProperties: [],
//     featuredProperties: [],
//     recommendedProperties: [],
//     filteredProperties: [],
//     selectedProperty: null,
//     selectedPropertyType: 'All',
//     successMessage: null,
//     errorMessage: null,
//   );
//
//   PropertyState copyWith({
//     PropertyStatus? status,
//     bool? isLoading,
//     List<PropertyDetailsResponse>? allProperties,
//     List<PropertyDetailsResponse>? featuredProperties,
//     List<PropertyDetailsResponse>? recommendedProperties,
//     List<PropertyDetailsResponse>? filteredProperties,
//     PropertyDetailsResponse? selectedProperty,
//     bool clearSelectedProperty = false,
//     String? selectedPropertyType,
//     String? successMessage,
//     String? errorMessage,
//     bool clearMessages = false,
//   }) {
//     return PropertyState(
//       status: status ?? this.status,
//       isLoading: isLoading ?? this.isLoading,
//       allProperties: allProperties ?? this.allProperties,
//       featuredProperties: featuredProperties ?? this.featuredProperties,
//       recommendedProperties: recommendedProperties ?? this.recommendedProperties,
//       filteredProperties: filteredProperties ?? this.filteredProperties,
//       selectedProperty: clearSelectedProperty ? null : (selectedProperty ?? this.selectedProperty),
//       selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
//       successMessage: clearMessages ? null : (successMessage ?? this.successMessage),
//       errorMessage: clearMessages ? null : (errorMessage ?? this.errorMessage),
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//     status,
//     isLoading,
//     allProperties,
//     featuredProperties,
//     recommendedProperties,
//     filteredProperties,
//     selectedProperty,
//     selectedPropertyType,
//     successMessage,
//     errorMessage,
//   ];
// }