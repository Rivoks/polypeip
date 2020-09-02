class SocialNetwork {
  final String id;
  final String socialNetwork;
  final String username;
  final String url;

  SocialNetwork({
    this.id,
    this.socialNetwork,
    this.username,
    this.url,
  });

  factory SocialNetwork.fromJson(Map<String, dynamic> socialNetwork) =>
      SocialNetwork(
        id: socialNetwork['_id'],
        socialNetwork: socialNetwork['socialNetwork'],
        username: socialNetwork['username'],
        url: socialNetwork['url'],
      );
}
