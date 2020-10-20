class Post {
  final String id;
  final String name;
  final String content;
  final String img;
  final int totalLikes;
  final int nbTotalLikes;
  final int nbTotalDislikes;
  int likeStatus;
  final DateTime date;

  Post({
    this.id,
    this.name,
    this.content,
    this.img,
    this.totalLikes,
    this.nbTotalLikes,
    this.nbTotalDislikes,
    this.likeStatus,
    this.date,
  });

  factory Post.fromJson(Map<String, dynamic> post) => Post(
        id: post['_id'],
        name: post['name'],
        content: post['content'],
        img: post['img'] != null
            ? 'http://192.168.1.128:3000/uploads/i/posts/${post["img"]}'
            : "https://static.lexpress.fr/medias_11577/w_2000,h_1120,c_fill,g_center/v1502354725/paris-vu-du-ciel-des-images-epoustouflantes-filmees-par-un-drone_5927848.jpg",
        totalLikes: post['totalLikes'],
        nbTotalLikes: post['totalLikes'],
        nbTotalDislikes: post['totalDislikes'],
        likeStatus:
            post['likes'] != null ? 1 : post['dislikes'] != null ? -1 : 0,
        date: DateTime.parse(post['date']),
      );
}
