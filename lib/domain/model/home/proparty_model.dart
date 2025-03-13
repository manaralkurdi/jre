
class PropertyCategoryResponse {
  final String status;
  final List<PropertyDataCategory> data;

  PropertyCategoryResponse({
    required this.status,
    required this.data,
  });

  factory PropertyCategoryResponse.fromJson(Map<String, dynamic> json) {
    return PropertyCategoryResponse(
      status: json['status'] ?? '',
      data: (json['data'] as List?)
          ?.map((property) => PropertyDataCategory.fromJson(property))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((property) => property.toJson()).toList(),
    };
  }
}





class PropertyDataCategory {
  final String id;
  final String name;
  final String nameEn;
  final String propertyType;
  final String size;
  final String location;
  final String countryId;
  final String regionId;
  final String propertyMap;
  final String description;
  final String descriptionEn;
  final String peopleCount;
  final String roomsCount;
  final String dailyPrice;
  final String checkIn;
  final String checkOut;
  final String bookingSetting;
  final String mainImage;
  final String isFeatured;
  final String createdAt;
  final String updatedAt;
  final String countryName;
  final String regionName;
  final List<String> additions;
  final List<String> paymentMethods;
  final List<List<String>> bookings;
  final List<String> additionalImages;

  PropertyDataCategory({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.propertyType,
    required this.size,
    required this.location,
    required this.countryId,
    required this.regionId,
    required this.propertyMap,
    required this.description,
    required this.descriptionEn,
    required this.peopleCount,
    required this.roomsCount,
    required this.dailyPrice,
    required this.checkIn,
    required this.checkOut,
    required this.bookingSetting,
    required this.mainImage,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.countryName,
    required this.regionName,
    required this.additions,
    required this.paymentMethods,
    required this.bookings,
    required this.additionalImages,
  });

  factory PropertyDataCategory.fromJson(Map<String, dynamic> json) {
    return PropertyDataCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      propertyType: json['property_type'] ?? '',
      size: json['size'] ?? '',
      location: json['location'] ?? '',
      countryId: json['country_id'] ?? '',
      regionId: json['region_id'] ?? '',
      propertyMap: json['property_map'] ?? '',
      description: json['description'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      peopleCount: json['people_count'] ?? '',
      roomsCount: json['rooms_count'] ?? '',
      dailyPrice: json['daily_price'] ?? '',
      checkIn: json['check_in'] ?? '',
      checkOut: json['check_out'] ?? '',
      bookingSetting: json['booking_setting'] ?? '',
      mainImage: json['main_image'] ?? '',
      isFeatured: json['is_featured'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      countryName: json['country_name'] ?? '',
      regionName: json['region_name'] ?? '',
      additions: List<String>.from(json['additions'] ?? []),
      paymentMethods: List<String>.from(json['payment_methods'] ?? []),
      bookings:
          (json['bookings'] as List?)
              ?.map((booking) => List<String>.from(booking))
              .toList() ??
          [],
      additionalImages: List<String>.from(json['additional_images'] ?? []),
    );
  }

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
      'is_featured': isFeatured,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country_name': countryName,
      'region_name': regionName,
      'additions': additions,
      'payment_methods': paymentMethods,
      'bookings': bookings,
      'additional_images': additionalImages,
    };
  }
}
