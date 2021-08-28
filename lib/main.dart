import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/services/local/cache_helper.dart';
import 'package:shop_app/services/network/dio_helper.dart';
import 'package:shop_app/view_models/app_cubit/cubit.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';
import 'package:shop_app/view_models/bloc_observer.dart';
import 'package:shop_app/view_models/login_cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => AppCubit()..getCacheData()..getHomeData()..getCategoriesData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          Widget home = AppCubit.get(context).chooseInitialPage();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: lightTheme,
            home: home,
          );
        },
      ),
    );
  }
}
