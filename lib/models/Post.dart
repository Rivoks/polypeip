class Goodie {
  final String id;
  final String name;
  final String content;
  final String img;
  final double totalLikes;
  final double nbTotalLikes;
  final double nbTotalUnlikes;
  final DateTime date;

  Goodie({
    this.id,
    this.name,
    this.content,
    this.img,
    this.totalLikes,
    this.nbTotalLikes,
    this.nbTotalUnlikes,
    this.date,
  });

  factory Goodie.fromJson(Map<String, dynamic> goodie) => Goodie(
        id: goodie['_id'],
        name: goodie['name'],
        content: goodie['content'],
        img: goodie['img'],
        totalLikes: goodie['totalLikes'],
        nbTotalLikes: goodie['nbTotalLikes'],
        nbTotalUnlikes: goodie['nbTotalUnlikes'],
        date: goodie['date'],
      );
}
