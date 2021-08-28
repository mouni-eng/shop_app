import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';
import 'package:shop_app/view_models/login_cubit/states.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInStates());
  static LogInCubit get(context) => BlocProvider.of(context);

  LogInModel? logInModel;

  void userLogIn({
    required String email,
    required String password,
  }) {
    emit(LogInLoadingState());
    DioHelper.posData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      logInModel = LogInModel.fromJson(value.data);
      emit(LogInSuccessState(logInModel: logInModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LogInErrorState(error: error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LogInChangePasswordVisibilityState());
  }
}


