
class Supply {
  final int id;
  final String name;
  final double cost;
  final String buyUnit;
  final String useUnit;
  final double equivalence;
  final String image;

  Supply(
    this.id,
    this.name,
    this.cost,
    this.buyUnit,
    this.useUnit,
    this.equivalence,
    this.image,
  );

  Supply.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cost = json['cost'],
        buyUnit = json['buyUnit'],
        useUnit = json['useUnit'],
        equivalence = json['equivalence'],
        image = json['image']
        ;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cost': cost,
        'buyUnit': buyUnit,
        'useUnit': useUnit,
        'equivalence': equivalence,
        'image': image,
      };
}