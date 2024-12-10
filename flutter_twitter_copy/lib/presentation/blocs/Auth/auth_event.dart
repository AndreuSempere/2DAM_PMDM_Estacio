import 'package:equatable/equatable.dart';

// Eventos
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

class LogoutButtonPressed extends AuthEvent {}

class GetInfoUser extends AuthEvent {
  final String id;
  GetInfoUser({required this.id});
}

class GetAllUsers extends AuthEvent {
  GetAllUsers();

  @override
  List<Object?> get props => [];
}

class UpdateUserInfoUseCase extends AuthEvent {
  final String userId;
  final String username;
  final String avatar;

  UpdateUserInfoUseCase(
      {required this.userId, required this.username, required this.avatar});
}

class FollowUser extends AuthEvent {
  final String userToFollow;
  final String userId;
  FollowUser(this.userToFollow, this.userId);
}
