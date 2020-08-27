class Link {
  final String id;
  final String name;
  final String url;

  Link({
    this.id,
    this.name,
    this.url,
  });

  factory Link.fromJson(Map<String, dynamic> link) => Link(
        id: link['_id'],
        name: link['name'],
        url: link['url'],
      );
}
