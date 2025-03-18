class DetailsProperty {
  final String ?status;
  final PropertyData ? data;

  DetailsProperty({
     this.status,
     this.data,
  });

  factory DetailsProperty.fromJson(Map<String, dynamic> json) {
    return DetailsProperty(
      status: json['status'] ?? '',
      data: PropertyData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class PropertyData {
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
  final String? isFeatured;
  final String? createdAt;
  final String? updatedAt;
  final String? countryName;
  final String? regionName;
  final List<String>? additions;
  final List<String>? paymentMethods;
  final List<List<String>>? bookings;
  final List<String>? additionalImages;

  PropertyData({
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
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.countryName,
    this.regionName,
    this.additions,
    this.paymentMethods,
    this.bookings,
    this.additionalImages,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) {
    return PropertyData(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      nameEn: json['name_en']?.toString(),
      propertyType: json['property_type']?.toString(),
      size: json['size']?.toString(),
      location: json['location']?.toString(),
      countryId: json['country_id']?.toString(),
      regionId: json['region_id']?.toString(),
      propertyMap: json['property_map']?.toString(),
      description: json['description']?.toString(),
      descriptionEn: json['description_en']?.toString(),
      peopleCount: json['people_count']?.toString(),
      roomsCount: json['rooms_count']?.toString(),
      dailyPrice: json['daily_price']?.toString(),
      checkIn: json['check_in']?.toString(),
      checkOut: json['check_out']?.toString(),
      bookingSetting: json['booking_setting']?.toString(),
      mainImage: json['main_image']?.toString(),
      isFeatured: json['is_featured']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      countryName: json['country_name']?.toString(),
      regionName: json['region_name']?.toString(),
      additions: json['additions'] != null ? List<String>.from(json['additions']) : null,
      paymentMethods: json['payment_methods'] != null ? List<String>.from(json['payment_methods']) : null,
      bookings: json['bookings'] != null ? (json['bookings'] as List<dynamic>)
          .map((booking) => List<String>.from(booking ?? []))
          .toList() : null,
      additionalImages: json['additional_images'] != null ? List<String>.from(json['additional_images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['id'] = id;
    if (name != null) data['name'] = name;
    if (nameEn != null) data['name_en'] = nameEn;
    if (propertyType != null) data['property_type'] = propertyType;
    if (size != null) data['size'] = size;
    if (location != null) data['location'] = location;
    if (countryId != null) data['country_id'] = countryId;
    if (regionId != null) data['region_id'] = regionId;
    if (propertyMap != null) data['property_map'] = propertyMap;
    if (description != null) data['description'] = description;
    if (descriptionEn != null) data['description_en'] = descriptionEn;
    if (peopleCount != null) data['people_count'] = peopleCount;
    if (roomsCount != null) data['rooms_count'] = roomsCount;
    if (dailyPrice != null) data['daily_price'] = dailyPrice;
    if (checkIn != null) data['check_in'] = checkIn;
    if (checkOut != null) data['check_out'] = checkOut;
    if (bookingSetting != null) data['booking_setting'] = bookingSetting;
    if (mainImage != null) data['main_image'] = mainImage;
    if (isFeatured != null) data['is_featured'] = isFeatured;
    if (createdAt != null) data['created_at'] = createdAt;
    if (updatedAt != null) data['updated_at'] = updatedAt;
    if (countryName != null) data['country_name'] = countryName;
    if (regionName != null) data['region_name'] = regionName;
    if (additions != null) data['additions'] = additions;
    if (paymentMethods != null) data['payment_methods'] = paymentMethods;
    if (bookings != null) data['bookings'] = bookings;
    if (additionalImages != null) data['additional_images'] = additionalImages;

    return data;
  }
}