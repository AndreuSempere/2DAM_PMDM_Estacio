import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/follow_users_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/get_all_users_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/get_user_info_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/login_usecase.dart';
import 'package:flutter_twitter_copy/domain/usecase/Login/update_user_info_usecase.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_event.dart';
import 'package:flutter_twitter_copy/presentation/blocs/Auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository authRepository;
  final LoginUseCase loginUseCase;
  final GetUserInfoUseCase getUserInfoUseCase;
  final UpdateUserUseCase updateUserInfoUseCase;
  final GetAllUsersUseCase getAllUsers;
  final FollowUserUseCase followUser;

  AuthBloc(
      {required this.loginUseCase,
      required this.authRepository,
      required this.getUserInfoUseCase,
      required this.updateUserInfoUseCase,
      required this.getAllUsers,
      required this.followUser})
      : super(const AuthState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await loginUseCase(event.email, event.password);

      result.fold(
        (error) {
          emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()));
        },
        (user) {
          emit(state.copyWith(isLoading: false, user: user));
        },
      );
    });

    on<GetInfoUser>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await getUserInfoUseCase(event.id);

      result.fold(
        (error) {
          emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()));
        },
        (user) {
          emit(state.copyWith(isLoading: false, user: user));
        },
      );
    });

    on<GetAllUsers>((event, emit) async {
      emit(state.copyWith(isLoading: true, users: []));

      final result = await getAllUsers();
      result.fold(
        (error) => emit(state.copyWith(
            isLoading: false, errorMessage: error.toString(), users: [])),
        (users) {
          emit(state.copyWith(isLoading: false, users: users));
        },
      );
    });

    on<UpdateUserInfoUseCase>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await updateUserInfoUseCase(
          event.userId, event.username, event.avatar);

      result.fold(
        (error) {
          emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()));
        },
        (user) {
          emit(state.copyWith(isLoading: false, user: user));
        },
      );
    });

    on<FollowUser>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final result = await followUser(event.userId, event.userToFollow);

      result.fold(
        (error) {
          emit(
              state.copyWith(isLoading: false, errorMessage: error.toString()));
        },
        (user) {
          emit(state.copyWith(isLoading: false));
        },
      );
    });

    on<LogoutButtonPressed>((event, emit) async {
      await authRepository.isLoggedIn();
      emit(const AuthState());
    });
  }
}
