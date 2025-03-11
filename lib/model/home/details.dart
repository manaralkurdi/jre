// import 'image_model.dart';
// import 'proparty_model.dart';
//
// class PropertyDetails {
//   final PropertyModel? propertyData;
//   final List<PropertyImageModel>? propertyImages;
//   final bool? status;
//   final String? message;
//
//   PropertyDetails({
//     this.propertyData,
//     this.propertyImages,
//     this.status,
//     this.message,
//   });
//
//   factory PropertyDetails.fromJson(Map<String, dynamic> json) {
//     return PropertyDetails(
//       propertyData: json['property_data'] != null
//           ? PropertyModel.fromJson(json['property_data'])
//           : null,
//       propertyImages: json['property_images'] != null
//           ? List<PropertyImageModel>.from(
//           json['property_images'].map((x) => PropertyImageModel.fromJson(x)))
//           : null,
//       status: json['status'],
//       message: json['message'],
//     );
//   }
// }