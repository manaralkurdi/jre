class PropertyImageModel {
  final String? id;
  final String? propertyId;
  final String? image;

  PropertyImageModel({
    this.id,
    this.propertyId,
    this.image,
  });

  factory PropertyImageModel.fromJson(Map<String, dynamic> json) {
    return PropertyImageModel(
      id: json['id'],
      propertyId: json['property_id'],
      image: json['image'],
    );
  }
}