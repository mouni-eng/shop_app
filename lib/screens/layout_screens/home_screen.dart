// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/categorie_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/view_models/app_cubit/cubit.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) => builderHomeWidget(cubit.homeModel, cubit.categoriesModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

Widget builderHomeWidget(HomeModel? model, CategoriesModel? categoriesModel) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model!.data!.bannerList
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image.toString()),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 14.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 14.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoriesWidget(categoriesModel!.data!.catData[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 15.0,
                      ),
                      itemCount: categoriesModel!.data!.catData.length),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1 / 1.76,
                    children: List.generate(
                        model.data!.productsList.length,
                            (index) =>
                            buildProductsWidget(model.data!.productsList[index])),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildProductsWidget(ProductsModel model) => Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: NetworkImage(model.image.toString()),
                height: 180,
                fit: BoxFit.fill,
              ),
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.all(5.0),
                child: defaultTextField(
                    size: 8.0, text: 'DISCOUNT', color: Colors.white),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultTextField(
                    size: 12.0,
                    text: model.name.toString(),
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    height: 1.3),
                Row(
                  children: [
                    defaultTextField(
                        size: 10.0,
                        text: '${model.price.toString()} LE',
                        color: kPrimaryColor),
                    SizedBox(
                      width: 8,
                    ),
                    if (model.discount != 0)
                      defaultTextField(
                        size: 10.0,
                        text: model.oldPrice.toString(),
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

Widget buildCategoriesWidget(CatDataModel model) => Stack(
    alignment: Alignment.bottomLeft,
    children: [
      Image(
        image: NetworkImage(
            model.image.toString()),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.fill,
      ),
  Container(
    padding: const EdgeInsets.all(4.0),
    width: 100.0,
      color: Colors.black.withOpacity(0.8),
      child: defaultTextField(size: 10.0, text: model.name.toString(), color: Colors.white, overflow: TextOverflow.ellipsis, aligment: TextAlign.center, maxLines: 1),
  )
    ]);
