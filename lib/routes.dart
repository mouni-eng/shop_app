import 'package:flutter/cupertino.dart';
import 'package:shop_app/screens/authantication/logIn_screen.dart';
import 'package:shop_app/screens/onBoarding_screen.dart';

final Map<String, WidgetBuilder> route = {
  OnBoardingScreen.id: (context) => OnBoardingScreen(),
  LoginInScreen.id: (context) => LoginInScreen(),
};