class Property {
  final String id;
  final String name;
  final String location;
  final String country;
  final int beds;
  final int baths;
  final int sqft;
  final double price;
  final String imageUrl;
  final int kitchens;
  final String locationCode;
  final String title;
  final double rating;
  final String type; // Apartment, Villa, House

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.country,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.type, required this.title,
    required this.kitchens,
    required this.locationCode,
  });
}

class PropertyEntity {
  final String id;
  final String title;
  final double price;
  final String location;
  final String locationCode;
  final int beds;
  final int baths;
  final int kitchens;
  final String imageUrl;

  PropertyEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.locationCode,
    required this.beds,
    required this.baths,
    required this.kitchens,
    required this.imageUrl,
  });
}

class PropertyModel {
  final String id;
  final String title;
  final double price;
  final String location;
  final String locationCode;
  final int beds;
  final int baths;
  final int kitchens;
  final String imageUrl;
  bool isFavorite;
  final String? propertyType;

  PropertyModel({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.locationCode,
    required this.beds,
    required this.baths,
    required this.kitchens,
    required this.imageUrl,
    this.isFavorite = false,
    this.propertyType,
  });
}
class Facility {
  String? img;
  String? title;

  Facility({
    this.img,
    this.title,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
    img: json["img"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "img": img,
    "title": title,
  };
}