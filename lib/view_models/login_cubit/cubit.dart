import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';
import 'package:shop_app/view_models/login_cubit/states.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInStates());
  static LogInCubit get(context) => BlocProvider.of(context);

  void userLogIn({
  required String email, required String password,
  }) {
    emit(LogInLoadingState());
    DioHelper.posData(url: LOGIN, data: {
      'email' : email,
      'password' : password,
    },).then((value) { print(value); emit(LogInSuccessState());}).catchError((error) {
      print(error.toString());
      emit(LogInErrorState());
    });
  }
}