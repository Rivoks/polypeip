class Post {
  final String id;
  final String name;
  final String content;
  final String img;
  final double totalLikes;
  final double nbTotalLikes;
  final double nbTotalUnlikes;
  final DateTime date;

  Post({
    this.id,
    this.name,
    this.content,
    this.img,
    this.totalLikes,
    this.nbTotalLikes,
    this.nbTotalUnlikes,
    this.date,
  });

  factory Post.fromJson(Map<String, dynamic> goodie) => Post(
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
