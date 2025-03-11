class PropertyImage {
  final String image;
  final int isPanorama;

  PropertyImage({
    required this.image,
    required this.isPanorama,
  });

  factory PropertyImage.fromJson(Map<String, dynamic> json) {
    return PropertyImage(
      image: json['image'] ?? '',
      isPanorama: json['isPanorama'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'isPanorama': isPanorama,
    };
  }
}

class FacilityModel {
  final String title;
  final String img;

  FacilityModel({
    required this.title,
    required this.img,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      title: json['title'] ?? '',
      img: json['img'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'img': img,
    };
  }
}

class ReviewModel {
  final String userImg;
  final String userTitle;
  final String userDesc;
  final String userRate;

  ReviewModel({
    required this.userImg,
    required this.userTitle,
    required this.userDesc,
    required this.userRate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userImg: json['userImg'] ?? '',
      userTitle: json['userTitle'] ?? '',
      userDesc: json['userDesc'] ?? '',
      userRate: json['userRate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userImg': userImg,
      'userTitle': userTitle,
      'userDesc': userDesc,
      'userRate': userRate,
    };
  }
}

class PropertyDetailsModel {
  final String id;
  final String title;
  final String description;
  final String price;
  final String city;
  final String propertyTitle;
  final String beds;
  final String bathroom;
  final String sqrft;
  final double latitude;
  final double longtitude;
  final String ownerName;
  final String ownerImage;
  final String mobile;
  final String userId;
  final List<PropertyImage> image;
  final int isFavourite;
  final String buyorrent;
  final String rate;
  final int isEnquiry;
  final String plimit;

  PropertyDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.city,
    required this.propertyTitle,
    required this.beds,
    required this.bathroom,
    required this.sqrft,
    required this.latitude,
    required this.longtitude,
    required this.ownerName,
    required this.ownerImage,
    required this.mobile,
    required this.userId,
    required this.image,
    required this.isFavourite,
    required this.buyorrent,
    required this.rate,
    required this.isEnquiry,
    required this.plimit,
  });

  factory PropertyDetailsModel.fromJson(Map<String, dynamic> json) {
    List<PropertyImage> imagesList = [];
    if (json['image'] != null) {
      imagesList = List<PropertyImage>.from(
          json['image'].map((x) => PropertyImage.fromJson(x))
      );
    }

    return PropertyDetailsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      city: json['city'] ?? '',
      propertyTitle: json['propertyTitle'] ?? '',
      beds: json['beds'] ?? '',
      bathroom: json['bathroom'] ?? '',
      sqrft: json['sqrft'] ?? '',
      latitude: json['latitude'] ?? '',
      longtitude: json['longtitude'] ?? '',
      ownerName: json['ownerName'] ?? '',
      ownerImage: json['ownerImage'] ?? '',
      mobile: json['mobile'] ?? '',
      userId: json['userId'] ?? '',
      image: imagesList,
      isFavourite: json['isFavourite'] ?? 0,
      buyorrent: json['buyorrent'] ?? '',
      rate: json['rate'] ?? '',
      isEnquiry: json['isEnquiry'] ?? 0,
      plimit: json['plimit'] ?? '1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'city': city,
      'propertyTitle': propertyTitle,
      'beds': beds,
      'bathroom': bathroom,
      'sqrft': sqrft,
      'latitude': latitude,
      'longtitude': longtitude,
      'ownerName': ownerName,
      'ownerImage': ownerImage,
      'mobile': mobile,
      'userId': userId,
      'image': image.map((x) => x.toJson()).toList(),
      'isFavourite': isFavourite,
      'buyorrent': buyorrent,
      'rate': rate,
      'isEnquiry': isEnquiry,
      'plimit': plimit,
    };
  }
}

class PropertyDetailsResponse {
  final PropertyDetailsModel propetydetails;
  final List<FacilityModel> facility;
  final List<String> gallery;
  final List<ReviewModel> reviewlist;
  final String totalReview;

  PropertyDetailsResponse({
    required this.propetydetails,
    required this.facility,
    required this.gallery,
    required this.reviewlist,
    required this.totalReview,
  });

  factory PropertyDetailsResponse.fromJson(Map<String, dynamic> json) {
    List<FacilityModel> facilityList = [];
    if (json['facility'] != null) {
      facilityList = List<FacilityModel>.from(
          json['facility'].map((x) => FacilityModel.fromJson(x))
      );
    }

    List<String> galleryList = [];
    if (json['gallery'] != null) {
      galleryList = List<String>.from(json['gallery']);
    }

    List<ReviewModel> reviewList = [];
    if (json['reviewlist'] != null) {
      reviewList = List<ReviewModel>.from(
          json['reviewlist'].map((x) => ReviewModel.fromJson(x))
      );
    }

    return PropertyDetailsResponse(
      propetydetails: PropertyDetailsModel.fromJson(json['propetydetails'] ?? {}),
      facility: facilityList,
      gallery: galleryList,
      reviewlist: reviewList,
      totalReview: json['totalReview'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propetydetails': propetydetails.toJson(),
      'facility': facility.map((x) => x.toJson()).toList(),
      'gallery': gallery,
      'reviewlist': reviewlist.map((x) => x.toJson()).toList(),
      'totalReview': totalReview,
    };
  }
}