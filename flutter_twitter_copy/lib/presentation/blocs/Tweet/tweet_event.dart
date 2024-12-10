import 'package:equatable/equatable.dart';

// Eventos
abstract class TweetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTweet extends TweetEvent {
  final String userId;
  final String content;
  final String image;
  CreateTweet(this.userId, this.content, this.image);
}

class GetAllTweet extends TweetEvent {
  final String filter;

  GetAllTweet(this.filter);

  @override
  List<Object?> get props => [filter];
}
