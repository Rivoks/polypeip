class Post {
  final String id;
  final String name;
  final String content;
  final String img;
  final int totalLikes;
  final int nbTotalLikes;
  final int nbTotalUnlikes;
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

  factory Post.fromJson(Map<String, dynamic> post) => Post(
        id: post['_id'],
        name: post['name'],
        content: post['content'],
        img: post['img'] != null
            ? post['img']
            : "https://static.lexpress.fr/medias_11577/w_2000,h_1120,c_fill,g_center/v1502354725/paris-vu-du-ciel-des-images-epoustouflantes-filmees-par-un-drone_5927848.jpg",
        totalLikes: post['totalLikes'],
        nbTotalLikes: post['nbTotalLikes'],
        nbTotalUnlikes: post['nbTotalUnlikes'],
        date: DateTime.parse(post['date']),
      );
}
