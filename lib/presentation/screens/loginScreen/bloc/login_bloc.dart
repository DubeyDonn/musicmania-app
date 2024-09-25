import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:musiq/main.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:musiq/services/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

// Initialize the Auth class
final auth = Auth();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await http.post(
          Uri.parse('http://192.168.0.16:8000/user/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': event.email,
            'password': event.password,
          }),
        );

        print(response.body);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          final String jwtToken = responseBody['token'];
          // userIsLoggedIn = event.email;
          // Store the JWT token securely
          await auth.setToken(jwtToken);

          emit(LoginSuccess(
              successMessage: 'Login successful', jwtToken: jwtToken));
        } else {
          emit(LoginError(errorMessage: 'Invalid email or password'));
        }
      } catch (e) {
        print("this is the error that occured: $e");
        emit(LoginError(errorMessage: e.toString()));
      }
    });
  }
}
