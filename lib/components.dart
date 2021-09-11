// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/categorie_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/view_models/app_cubit/cubit.dart';


Widget onBoardingBuild(OnBoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ],
  );
}

void navigateTo(context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateToAndFinish(context, Widget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultTextField({
  FontWeight fontWeight = FontWeight.normal,
  required double size,
  required String text,
  required Color color,
  TextAlign? aligment,
  double? height = 1,
  int? maxLines = 1,
  TextDecoration? decoration,
  TextOverflow? overflow,
}) =>
    Text(text,
        maxLines: maxLines,
        overflow: overflow ?? null,
        textAlign: aligment,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          height: height,
          decoration: decoration ?? null,
        ));

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, WARNING, ERROR }

Color chooseColor({required ToastState state}) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget builderHomeWidget(HomeModel? model, CategoriesModel? categoriesModel, context) => SingleChildScrollView(
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
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 25.0,
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
              height: 30.0,
            ),
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildListProduct(model.data!.productsList[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: model.data!.productsList.length,
                  ),
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget buildProductsWidget(ProductsModel model, context) => Container(
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
                  onPressed: () {
                    AppCubit.get(context).changeFavourite(model.id);
                  },
                  icon: CircleAvatar(
                    backgroundColor: AppCubit.get(context).favourites[model.id]! ? kPrimaryColor : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      size: 14.0,
                    ),
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

Widget buildCategoriesScreen(CatDataModel model) => Column(
  children: [
    SizedBox(
      height: 15.0,
    ),
    Container(
      margin: const EdgeInsets.all(18.0),
      child: ListTile(
        leading: Image(
          image: NetworkImage(
              model.image.toString()),
        ),
        title: defaultTextField(
            size: 18.0, text: model.name.toString(), color: Colors.black),
        trailing: IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    ),
  ],
);

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavourite(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          AppCubit.get(context).favourites[model.id]!
                              ? kPrimaryColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );



