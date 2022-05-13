import 'package:json_annotation/json_annotation.dart';
part 'products.g.dart';

@JsonSerializable()
class Products {
  String? name;
  String? image;
  String? category;
  double? price;
  String? desc;

  Products(
      {required this.name,
      required this.image,
      required this.category,
      required this.price,
      required this.desc});
  //flutter packages pub run build_runner build
  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
  @override
  String toString() {
    // TODO: implement toString
    return 'Products{name: $name, image: $image, category: $category,price :$price ,desc:$desc}';
  }
}
