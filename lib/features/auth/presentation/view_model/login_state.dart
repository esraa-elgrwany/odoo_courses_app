part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  LoginModel loginModel;

  LoginSuccess(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class LoginFailure extends LoginState {
  final Failures failure;

  LoginFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

