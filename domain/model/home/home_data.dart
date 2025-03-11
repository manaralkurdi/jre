
import 'proparty_model.dart';

class HomeData {
  final List<CategoryModel>? catlist;
  final List<PropertyModel>? featuredProperty;
  final String? currency;

  HomeData({
    this.catlist,
    this.featuredProperty,
    this.currency,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      catlist: json['catlist'] != null
          ? List<CategoryModel>.from(json['catlist'].map((x) => CategoryModel.fromJson(x)))
          : null,
      featuredProperty: json['featured_property'] != null
          ? List<PropertyModel>.from(json['featured_property'].map((x) => PropertyModel.fromJson(x)))
          : null,
      currency: json['currency'],
    );
  }
}

class HomeDatatInfo {
final HomeData? homeData;
final bool? status;
final String? message;

HomeDatatInfo({
  this.homeData,
  this.status,
  this.message,
});

factory HomeDatatInfo.fromJson(Map<String, dynamic> json) {
return HomeDatatInfo(
homeData: json['home_data'] != null ? HomeData.fromJson(json['home_data']) : null,
status: json['status'],
message: json['message'],
);
}
}