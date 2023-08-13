
class Product {
  final int id;
  final String name;
  final String description;
  final String category;
  final String width;
  final String length;
  final String height;
  final double price;
  final String image;

  Product(
    this.id,
    this.name,
    this.description,
    this.category,
    this.width,
    this.length,
    this.height,
    this.price,
    this.image,
  );

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        category = json['category'],
        width = json['width'],
        length = json['length'],
        height = json['height'],
        price = json['price'],
        image = json['image']
        ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category': category,
        'width': width,
        'height': height,
        'length': length,
        'price': price,
        'image': image,
      };
}