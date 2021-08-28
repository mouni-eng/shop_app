import 'package:shop_app/models/login_model.dart';

class LogInStates {}
class LogInLoadingState extends LogInStates{}
class LogInSuccessState extends LogInStates{
  final LogInModel logInModel;
  LogInSuccessState({required this.logInModel});
}
class LogInErrorState extends LogInStates{
  final String error;
  LogInErrorState({required this.error});
}
class LogInChangePasswordVisibilityState extends LogInStates{}