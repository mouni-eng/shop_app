import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/categorie_model.dart';
import 'package:shop_app/models/change_favourite_model.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/screens/authantication/logIn_screen.dart';
import 'package:shop_app/screens/layout_screens/categories_screen.dart';
import 'package:shop_app/screens/layout_screens/favourite_screen.dart';
import 'package:shop_app/screens/layout_screens/home_screen.dart';
import 'package:shop_app/screens/layout_screens/settings_screen.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/services/network/end_points.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);

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
      homeModel!.data!.productsList.forEach((element) {
        favourites.addAll({
          element.id! : element.inFavorites!
        });
      });
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

  // section handling the favourites logic

  Map<int, bool> favourites = {};
  ChangeFavouriteModel? changeFavouriteModel;

  void changeFavourite(int? id) {

    favourites[id!] = !favourites[id]!;
    emit(AppFavouriteChangeState());

    DioHelper.postData(
        url: FAVOURITES,
        data: {
          'product_id' : id,
        },
      token: token,
    ).then((value) {
          changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);

          if(!changeFavouriteModel!.status!) {
            favourites[id] = !favourites[id]!;
          }else{
            getFavourites();
          }
          emit(AppFavouriteSuccessState());
        }).catchError((error) {
      emit(AppFavouriteErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavourites() {
    emit(AppGetFavouriteLoadingState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.data!.data);
      emit(AppGetFavouriteSuccessState());
    }).catchError((error) {
      print(error);
      emit(AppGetFavouriteErrorState());
    });
  }

  // section handling profile data

  LogInModel? profileModel;

  void getProfileData() {
    emit(AppGetProfileLoadingState());
    DioHelper.getData(
        url: PROFILE,
        token: token,
    ).then((value) {
      profileModel = LogInModel.fromJson(value.data);
      emit(AppGetProfileSuccessState());
    }).catchError((error) {
      print(error);
      emit(AppGetProfileErrorState());
    });
  }


  void logOut(context) {
    CacheHelper.sharedPreferences!.remove("token").then((value) {
      if(value) {
        navigateToAndFinish(context, LoginInScreen());
      }
    });
  }

  void updateProfile({
  required String name, email, phoneNumber
}) {
    emit(AppUpdateProfileLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          "name" : name,
          "email" : email,
          "phone" : phoneNumber,
        },
      token: token,
    ).then((value) {
      emit(AppUpdateProfileSuccessState());
    }).catchError((error) {
      emit(AppUpdateProfileErrorState());
    });
  }

  // section handling search screen

  SearchModel? searchModel;

  void search(String text) {
    emit(AppGetSearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        data: {
          "text" : text,
        },
        token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(AppGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorState());
    });
  }
}