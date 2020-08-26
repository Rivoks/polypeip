class Goodie {
  final String id;
  final String name;
  final String description;
  final String img;
  final double price;
  final DateTime date;

  Goodie({
    this.id,
    this.name,
    this.description,
    this.img,
    this.price,
    this.date,
  });

  factory Goodie.fromJson(Map<String, dynamic> goodie) => Goodie(
        id: goodie['_id'],
        name: goodie['name'],
        description: goodie['description'],
        img: goodie['img'],
        price: goodie['price'],
        date: goodie['date'],
      );
}
