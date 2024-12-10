import 'package:equatable/equatable.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';

class TweetState extends Equatable {
  final List<Tweet> tweets;
  final bool isLoading;
  final String errorMessage;
  final String filter;

  const TweetState({
    this.tweets = const [],
    this.isLoading = false,
    this.errorMessage = '',
    this.filter = '',
  });

  TweetState copyWith({
    List<Tweet>? tweets,
    bool? isLoading,
    String? errorMessage,
    String? filter,
  }) {
    return TweetState(
      tweets: tweets ?? this.tweets,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [tweets, isLoading, errorMessage, filter];
}
