class RealEstateFilterRequest {
  final String type;
   int ?country;
   int ? region;
   int? peopleCount;
   int ?roomsCount;

  RealEstateFilterRequest({
    this.type = 'real_estates',
     this.country,
     this.region,
     this.peopleCount,
     this.roomsCount,
  });
  void setCountry(int value) {
    country = value;
  }

  void setRegion(int value) {
    region = value;
  }

  void setPeopleCount(int value) {
    peopleCount = value;
  }

  void setRoomsCount(int value) {
    roomsCount = value;
  }

  Map<String, String> toJson() {
    return {
      'type': type,
      'country': country.toString(),
      'region': region.toString(),
      'people_count': peopleCount.toString(),
      'rooms_count': roomsCount.toString(),
    };
  }

  // Convert to form data for API request
  Map<String, String> toFormData() {
    return {
      'type': type,
      'country': country.toString(),
      'region': region.toString(),
      'people_count': peopleCount.toString(),
      'rooms_count': roomsCount.toString(),
    };
  }


}