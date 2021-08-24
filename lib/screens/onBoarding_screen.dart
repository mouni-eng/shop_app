import 'package:flutter/material.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/onboarding_model.dart';
import 'package:shop_app/screens/authantication/logIn_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static String id = "OnBoardingScreen";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

PageController controller = PageController();
bool isLast = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> onBoardingList = [
      OnBoardingModel(
          title: "Welcome to DISH IT, Let’s shop!",
          image: "assets/images/onboard_1.jpg"),
      OnBoardingModel(
          title: "We help people connect with store",
          image: "assets/images/onboard_1.jpg"),
      OnBoardingModel(
          title: "We show the easy way to shop. \nJust stay at home with us",
          image: "assets/images/onboard_1.jpg"),
    ];
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: () {
              navigateToAndFinish(context, LoginInScreen());
            }, child: Text("SKIP")),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == onBoardingList.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: controller,
                  physics: BouncingScrollPhysics(),
                  itemCount: onBoardingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return onBoardingBuild(onBoardingList[index]);
                  },
                ),
              ),
              SizedBox(
                height: 90.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onBoardingList.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: primaryColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast) {
                        navigateToAndFinish(context, LoginInScreen());
                      }
                      controller.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
