class DetailsProperty {
  final String? id;
  final String? name;
  final String? nameEn;
  final String? propertyType;
  final String? size;
  final String? location;
  final String? countryId;
  final String? regionId;
  final String? propertyMap;
  final String? description;
  final String? descriptionEn;
  final String? peopleCount;
  final String? roomsCount;
  final String? dailyPrice;
  final String? checkIn;
  final String? checkOut;
  final String? bookingSetting;
  final String? mainImage;
  final bool isFeatured;
  final String? createdAt;
  final String? updatedAt;
  final String? countryName;
  final String? regionName;
  final int? isFavourite;
  final List<String> additions;
  final List<String> paymentMethods;
  final List<List<String>> bookings;
  final List<String> additionalImages;

  DetailsProperty({
    this.id,
    this.name,
    this.nameEn,
    this.propertyType,
    this.size,
    this.location,
    this.countryId,
    this.regionId,
    this.propertyMap,
    this.description,
    this.descriptionEn,
    this.peopleCount,
    this.roomsCount,
    this.dailyPrice,
    this.checkIn,
    this.checkOut,
    this.bookingSetting,
    this.mainImage,
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
    this.countryName,
    this.isFavourite=0,
    this.regionName,
    this.additions = const [],
    this.paymentMethods = const [],
    this.bookings = const [],
    this.additionalImages = const [],
  });

  // Helper methods
  String getFormattedPrice() {
    if (dailyPrice == null || dailyPrice!.isEmpty) {
      return '0.00';
    }
    try {
      return double.parse(dailyPrice!).toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }

  String getFullAddress() {
    final region = regionName ?? '';
    final loc = location ?? '';
    final country = countryName ?? '';

    return [region, loc, country]
        .where((element) => element.isNotEmpty)
        .join(', ');
  }

  String getMainImageUrl({String? baseUrl}) {
    if (mainImage == null || mainImage!.isEmpty) {
      return '';
    }
    final base = baseUrl ?? '';
    return '$base/$mainImage';
  }

  bool isFeaturedProperty() {
    return isFeatured;
  }

  int getCapacity() {
    if (peopleCount == null || peopleCount!.isEmpty) {
      return 0;
    }
    try {
      return int.parse(peopleCount!);
    } catch (e) {
      return 0;
    }
  }

  // Factory constructor to create a DetailsProperty from a JSON map
  factory DetailsProperty.fromJson(Map<String, dynamic> json) {
    return DetailsProperty(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'],
      propertyType: json['property_type'],
      size: json['size'],
      location: json['location'],
      countryId: json['country_id'],
      regionId: json['region_id'],
      propertyMap: json['property_map'],
      description: json['description'],
      descriptionEn: json['description_en'],
      peopleCount: json['people_count'],
      roomsCount: json['rooms_count'],
      dailyPrice: json['daily_price'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      bookingSetting: json['booking_setting'],
      mainImage: json['main_image'],
      isFeatured: json['is_featured'] == '1',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      countryName: json['country_name'],
      regionName: json['region_name'],
      isFavourite: json['isFavourite'],
      additions: _parseStringList(json['additions']),
      paymentMethods: _parseStringList(json['payment_methods']),
      bookings: _parseNestedStringList(json['bookings']),
      additionalImages: _parseStringList(json['additional_images']),
    );
  }

  // Helper method to convert the DetailsProperty to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'property_type': propertyType,
      'size': size,
      'location': location,
      'country_id': countryId,
      'region_id': regionId,
      'property_map': propertyMap,
      'description': description,
      'description_en': descriptionEn,
      'people_count': peopleCount,
      'rooms_count': roomsCount,
      'daily_price': dailyPrice,
      'check_in': checkIn,
      'check_out': checkOut,
      'booking_setting': bookingSetting,
      'main_image': mainImage,
      'is_featured': isFeatured ? '1' : '0',
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country_name': countryName,
      'region_name': regionName,
      'additions': additions,
      'payment_methods': paymentMethods,
      'bookings': bookings,
      'additional_images': additionalImages,
      'isFavourite': isFavourite,
    };
  }

  // Private helper methods for parsing lists
  static List<String> _parseStringList(dynamic list) {
    if (list == null) return [];
    if (list is List) {
      return list.map((item) => item.toString()).toList();
    }
    return [];
  }

  static List<List<String>> _parseNestedStringList(dynamic list) {
    if (list == null) return [];
    if (list is List) {
      return list.map((item) {
        if (item is List) {
          return item.map((subItem) => subItem.toString()).toList();
        }
        return <String>[];
      }).toList();
    }
    return [];
  }
}