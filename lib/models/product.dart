
class Product {
  final int id;
  final String name;
  final String description;
  final String width;
  final String length;
  final String height;
  final String category;
  final int price;
  final String image;
  final int stock;
  final String inventoryStatus;

  Product(
    this.id,
    this.name,
    this.description,
    this.width,
    this.length,
    this.height,
    this.category,
    this.stock,
    this.price,
    this.image,
    this.inventoryStatus,
  );

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        width = json['width'],
        length = json['length'],
        height = json['height'],
        category = json['category'],
        price = json['price'],
        image = json['image'],
        stock = json['stock'],
        inventoryStatus = json['inventoryStatus']
        ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'width': width,
        'height': height,
        'length': length,
        'category': category,
        'price': price,
        'image': image,
      };
}