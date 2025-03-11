import 'proparty_model.dart' show PropertyModel;

class CatWiseInfo {
  final List<PropertyModel>? propertyCat;
  final bool? status;
  final String? message;

  CatWiseInfo({
    this.propertyCat,
    this.status,
    this.message,
  });

  factory CatWiseInfo.fromJson(Map<String, dynamic> json) {
    return CatWiseInfo(
      propertyCat: json['property_cat'] != null
          ? List<PropertyModel>.from(json['property_cat'].map((x) => PropertyModel.fromJson(x)))
          : null,
      status: json['status'],
      message: json['message'],
    );
  }
}