class Link {
  final String id;
  final String socialNetwork;
  final String value;

  Link({
    this.id,
    this.socialNetwork,
    this.value,
  });

  factory Link.fromJson(Map<String, dynamic> link) => Link(
        id: link['_id'],
        socialNetwork: link['socialNetwork'],
        value: link['value'],
      );
}
