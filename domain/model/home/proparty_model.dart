class PropertyModel {
  final String? id;
  final String? title;
  final String? city;
  final String? price;
  final String? image;
  final String? buyorrent;
  final String? rate;
  final String? beds;
  final String? bathroom;
  final String? sqrft;

  PropertyModel({
    this.id,
    this.title,
    this.city,
    this.price,
    this.image,
    this.buyorrent,
    this.rate,
    this.beds,
    this.bathroom,
    this.sqrft,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      title: json['title'],
      city: json['city'],
      price: json['price'],
      image: json['image'],
      buyorrent: json['buyorrent'],
      rate: json['rate'],
      beds: json['beds'],
      bathroom: json['bathroom'],
      sqrft: json['sqrft'],
    );
  }
}

  class CategoryModel {
  final String? id;
  final String? title;
  final String? img;

  CategoryModel({
  this.id,
  this.title,
  this.img,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
  return CategoryModel(
  id: json['id'],
  title: json['title'],
  img: json['img'],
  );
  }
  }

