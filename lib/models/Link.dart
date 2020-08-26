class Link {
  final String id;
  final String name;
  final String file;

  Link({
    this.id,
    this.name,
    this.file,
  });

  factory Link.fromJson(Map<String, dynamic> link) => Link(
        id: link['_id'],
        name: link['name'],
        file: link['file'],
      );
}
