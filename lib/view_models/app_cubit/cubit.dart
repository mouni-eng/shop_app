import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categorie_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/screens/authantication/logIn_screen.dart';
import 'package:shop_app/screens/layout_screens/categories_screen.dart';
import 'package:shop_app/screens/layout_screens/favourite_screen.dart';
import 'package:shop_app/screens/layout_screens/home_screen.dart';
import 'package:shop_app/screens/layout_screens/layout_screen.dart';
import 'package:shop_app/screens/layout_screens/settings_screen.dart';
import 'package:shop_app/screens/onBoarding_screen.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  // section handling the initial screen for user

  bool? isBoarding;
  String? token;

  void getCacheData() {
    isBoarding = CacheHelper.getData(key: "onBoarding");
    token = CacheHelper.getData(key: "token");
    emit(AppInitialPageState());
  }

  Widget chooseInitialPage() {
    if(isBoarding != null) {
      if(token == null) return LoginInScreen();
      else return LayoutScreen();
    }else return OnBoardingScreen();
  }

  // section handling the Bottom Nav Bar

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    BottomNavigationBarItem(
      label: "Home",
      icon: Icon(Icons.home)
    ),
    BottomNavigationBarItem(
        label: "Categories",
        icon: Icon(Icons.apps)
    ),
    BottomNavigationBarItem(
        label: "Favourites",
        icon: Icon(Icons.favorite)
    ),
    BottomNavigationBarItem(
        label: "Settings",
        icon: Icon(Icons.settings)
    ),

  ];
  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  // section handling getting the home page data from the server

  HomeModel? homeModel;

  void getHomeData() {
    emit(AppLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(AppHomeSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppHomeErrorDataState());
    });
  }

  // section handling getting the categories data from the server

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(AppLoadingState());
    DioHelper.getData(
      url: categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppCategorieSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppCategorieErrorDataState());
    });
  }


}