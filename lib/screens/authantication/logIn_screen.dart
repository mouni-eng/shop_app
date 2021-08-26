// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/authantication/signUp_screen.dart';
import 'package:shop_app/view_models/login_cubit/cubit.dart';
import 'package:shop_app/view_models/login_cubit/states.dart';

class LoginInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _passwordEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LogInCubit, LogInStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LogInCubit cubit = LogInCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultTextField(size: 28, text: "LOGIN", color: Colors.black),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultTextField(size: 16, text: "Login now and discover our hot offers,", color: Colors.grey),
                    SizedBox(
                      height: 40.0,
                    ),
                    defaultFormField(controller: _emailEditingController, type: TextInputType.emailAddress, validate: (value) {
                      if(value!.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      return null;
                    }, label: "Email", prefix: Icons.email_outlined),
                    SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(controller: _passwordEditingController, type: TextInputType.visiblePassword, validate: (value) {
                      if(value!.isEmpty) {
                        return "Password Is Too Short";
                      }
                      return null;
                    }, label: "Password", prefix: Icons.lock_outline, suffix: Icons.visibility, suffixPressed: () {}, isPassword: true),
                    SizedBox(
                      height: 40.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! LogInLoadingState,
                      builder: (context) => defaultButton(function: () {
                        if(_formKey.currentState!.validate()) {
                          cubit.userLogIn(email: _emailEditingController.text, password: _passwordEditingController.text);
                        }
                      }, text: "LOGIN"),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        defaultTextField(size: 14.0, text: "Don't have an account?", color: Colors.black),
                        TextButton(onPressed: () {
                          navigateTo(context, SignUpScreen());
                        }, child: defaultTextField(size: 14.0, text: "REGISTER", color: kPrimaryColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
