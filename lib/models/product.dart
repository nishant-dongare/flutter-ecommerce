class Product {
  late int? id;
  late String title;
  late String price;
  late String category;
  late String description;
  late String image;

  Product(
      {this.id,
        required this.title,
        required this.price,
        required this.category,
        required this.description,
        required this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'].toString();
    category = json['category'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['category'] = category;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
