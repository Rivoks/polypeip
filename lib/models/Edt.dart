class Edt {
  final String id;
  final String name;
  final String img;

  Edt({
    this.id,
    this.name,
    this.img,
  });

  factory Edt.fromJson(Map<String, dynamic> edt) => Edt(
        id: edt['_id'],
        name: edt['name'],
        img: 'http://192.168.1.128:3000/uploads/i/edts/${edt["img"]}',
      );
}
