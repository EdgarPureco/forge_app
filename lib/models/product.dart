
class Product {
  final int id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String image;

  Product(
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.image,
  );

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        category = json['category'],
        price = json['price'],
        image = json['image']
        ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'price': price,
        'image': image,
      };
}