import 'package:flutter/material.dart';
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
