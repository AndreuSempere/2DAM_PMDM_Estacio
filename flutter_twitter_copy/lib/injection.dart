import 'package:flutter_twitter_copy/data/datasources/tweet_remote_datasource.dart';
import 'package:flutter_twitter_copy/data/datasources/user_remote_datasource.dart';
import 'package:flutter_twitter_copy/data/repositories/tweet_repository_impl.dart';
import 'package:flutter_twitter_copy/data/repositories/user_repository_impl.dart';
import 'package:flutter_twitter_copy/domain/repositories/tweet_repository.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/follow_users_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/get_all_users_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/get_user_info_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/login_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/update_user_info_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/create_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/delete_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/get_all_followusers_tweets_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/get_tweets_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/like_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Tweets/update_tweet_usecase.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_bloc.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Tweet/tweet_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
void setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // DataSource
  sl.registerLazySingleton(() => UserRemoteDatasource());
  sl.registerLazySingleton(() => TweetRemoteDataSource());

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TweetRepository>(
    () => TweetRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => GetAllUsersUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl())); // Registro agregado
  sl.registerLazySingleton(() => GetTweetsUseCase(sl()));
  sl.registerLazySingleton(() => CreateTweetUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTweetUseCase(sl()));
  sl.registerLazySingleton(() => LikeTweetUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTweetUseCase(sl()));
  sl.registerLazySingleton(() => GetFollowUsersTweetsUseCase(sl()));
  sl.registerLazySingleton(() => FollowUserUseCase(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(
      loginUseCase: sl(),
      getUserInfoUseCase: sl(),
      updateUserInfoUseCase: sl(),
      authRepository: sl(),
      getAllUsers: sl(),
      followUser: sl()));

  sl.registerFactory(() => TweetBloc(
        tweetRepository: sl(),
        createTweet: sl(),
        getTweets: sl(),
        getFollowUsersTweets: sl(),
        likeTweet: sl(),
        updateTweet: sl(),
        deleteTweet: sl(),
      ));
}
