abstract class AuthState {}

//Before show form login
class LoginInitial extends AuthState {}

//After toggle login
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final Map<String, dynamic> user;

  LoginSuccess({required this.user});
}

class SignUpSuccess extends AuthState {
  final Map<String, dynamic> user;

  SignUpSuccess({required this.user});
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure({required this.error});
}