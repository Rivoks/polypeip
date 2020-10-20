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
        img: goodie['img'] != null
            ? 'http://192.168.1.128:3000/uploads/i/goodies/${goodie["img"]}'
            : "https://static.lexpress.fr/medias_11577/w_2000,h_1120,c_fill,g_center/v1502354725/paris-vu-du-ciel-des-images-epoustouflantes-filmees-par-un-drone_5927848.jpg",
        price: double.parse(goodie['price'].toString()),
        date: DateTime.parse(goodie['date']),
      );
}
