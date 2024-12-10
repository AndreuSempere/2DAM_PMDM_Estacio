import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/domain/entities/tweet.dart';
import 'package:flutter_twitter_copy/domain/repositories/tweet_repository.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/create_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/delete_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/get_all_followusers_tweets_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/get_tweets_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/like_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/update_tweet_usecase.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_event.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  final TweetRepository tweetRepository;
  final CreateTweetUseCase createTweet;
  final GetTweetsUseCase getTweets;
  final GetFollowUsersTweetsUseCase getFollowUsersTweets;
  final LikeTweetUseCase likeTweet;
  final UpdateTweetUseCase updateTweet;
  final DeleteTweetUseCase deleteTweet;

  TweetBloc(
      {required this.tweetRepository,
      required this.createTweet,
      required this.getTweets,
      required this.getFollowUsersTweets,
      required this.likeTweet,
      required this.updateTweet,
      required this.deleteTweet})
      : super(const TweetState()) {
    on<GetAllTweet>((event, emit) async {
      emit(state.copyWith(isLoading: true, filter: event.filter, tweets: []));

      final result = await getTweets();
      result.fold(
        (error) => emit(state.copyWith(
            isLoading: false, errorMessage: error.toString(), tweets: [])),
        (tweets) {
          final filteredTweets = tweets.where((tweet) {
            return tweet.userId
                .toLowerCase()
                .contains(event.filter.toLowerCase());
          }).toList();

          emit(state.copyWith(isLoading: false, tweets: filteredTweets));
        },
      );
    });

    on<CreateTweet>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        await createTweet(event.userId, event.content, event.image);
        final newTweet = Tweet(
          userId: event.userId,
          content: event.content,
          image: event.image,
        );
        final updatedTweets = List<Tweet>.from(state.tweets)..add(newTweet);

        emit(state.copyWith(
          tweets: updatedTweets,
          isLoading: false,
        ));
      } catch (error) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Error al crear el tweet: $error',
        ));
      }
    });
  }
}
