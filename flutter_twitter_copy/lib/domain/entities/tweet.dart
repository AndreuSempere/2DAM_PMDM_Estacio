class Tweet {
  final String? id;
  final String userId;
  final String content;
  final DateTime? createdAt;
  final List<dynamic>? likes;
  final String? image;
  final String? userAvatar;

  Tweet(
      {this.id,
      required this.userId,
      required this.content,
      this.createdAt,
      this.likes,
      this.image,
      this.userAvatar});
}
