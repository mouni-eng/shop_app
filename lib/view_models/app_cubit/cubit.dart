import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());
  static AppCubit get(context) => BlocProvider.of(context);
}