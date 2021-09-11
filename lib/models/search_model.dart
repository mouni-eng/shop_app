class SearchModel
{
  bool? status;
  Null message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data =  Data.fromJson(json['data']);
  }
}

class Data {
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) => data.add(Product.fromJson(element)));
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
