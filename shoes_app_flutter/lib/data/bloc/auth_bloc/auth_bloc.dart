import 'package:bloc/bloc.dart' show Bloc;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shoes_shop/data/sql_helper.dart';
import '../../../models/account.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onToggleLogin);
  }

  void _onToggleLogin(LoginButtonPressed event, Emitter<AuthState> emit) async {
    //Emit loading status
    emit(LoginLoading(isLoading: true)); //Emit loading status
    try {
      List<Map<String, dynamic>> users = await DBHelper.instance.getAccountByMail(event.email);
      if (users.isNotEmpty) {
        final user = users.first;
        print(user.toString());
        if (user['Password'] == event.password) {
          emit(LoginSuccess(user: user));
          emit(LoginLoading(isLoading: false));
        } else {
          emit(LoginFailure(error: "Incorrect username or password"));
          emit(LoginLoading(isLoading: false));
        }
      } else {
        emit(LoginFailure(error: "Account are not found"));
        emit(LoginLoading(isLoading: false));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
      emit(LoginLoading(isLoading: false));
    }
  }

  static void login(BuildContext context, String email, String password) {
    context.read<AuthBloc>().add(LoginButtonPressed(email: email, password: password));
  }

  static void register(BuildContext context, Account account) {
    context.read<AuthBloc>().add(SignUpButtonPressed(name: account.name, email: account.email, password: account.password));
  }

}
