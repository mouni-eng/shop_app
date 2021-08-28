import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/onboarding_model.dart';

Widget onBoardingBuild(OnBoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(
        height: 30.0,
      ),
      Text("${model.title}", style: TextStyle(
        fontSize: 18.0,
      ),),
    ],
  );
}


void navigateTo(context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateToAndFinish(context, Widget screen) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen), (route) => false);
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
  }) => Text(
text,
maxLines: maxLines,
overflow: overflow?? null,
textAlign: aligment,
style: TextStyle(
fontSize: size,
fontWeight: fontWeight,
color: color,
height: height,
decoration: decoration?? null,
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

enum ToastState {SUCCESS, WARNING, ERROR}

Color chooseColor({required ToastState state}) {

    Color color;

    switch(state) {
      case ToastState.SUCCESS:
        color = Colors.green;
        break;
      case ToastState.WARNING:
        color = Colors.amber;
        break;
      case ToastState.ERROR:
        color = Colors.red;
        break;
    }  return color;
  }