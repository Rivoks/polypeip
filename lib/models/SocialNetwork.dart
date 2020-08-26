class SocialNetwork {
  final String id;
  final String socialNetwork;
  final String value;

  SocialNetwork({
    this.id,
    this.socialNetwork,
    this.value,
  });

  factory SocialNetwork.fromJson(Map<String, dynamic> socialNetwork) =>
      SocialNetwork(
        id: socialNetwork['_id'],
        socialNetwork: socialNetwork['socialNetwork'],
        value: socialNetwork['value'],
      );
}
