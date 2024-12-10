import 'package:dartz/dartz.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';

class FollowUserUseCase {
  final UserRepository repository;
  FollowUserUseCase(this.repository);

  Future<Either<String, void>> call(String userToFollow, String userId) async {
    return await repository.followUser(userToFollow, userId);
  }
}
