// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/view_models/app_cubit/cubit.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        AppCubit cubit = AppCubit.get(context);
        return cubit.favoritesModel!.data!.data!.length == 0 ? Center(
          child: defaultTextField(size: 18.0, text: "No Favourites Yet", color: Colors.grey),
        ) :  Container(
          child: ConditionalBuilder(
            condition: states is! AppGetFavouriteLoadingState,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(cubit.favoritesModel!.data!.data![index].product, context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.favoritesModel!.data!.data!.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
