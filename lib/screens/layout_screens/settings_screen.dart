import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components.dart';
import 'package:shop_app/view_models/app_cubit/cubit.dart';
import 'package:shop_app/view_models/app_cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return SingleChildScrollView(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (cubit.profileModel != null) {
            nameController.text = cubit.profileModel!.data!.name!;
            emailController.text = cubit.profileModel!.data!.email!;
            phoneController.text = cubit.profileModel!.data!.phone!;
          }
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is AppUpdateProfileLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {},
                      label: "Name",
                      prefix: Icons.person),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {},
                      label: "Email",
                      prefix: Icons.email_outlined),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {},
                      label: "Phone Number",
                      prefix: Icons.phone),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultButton(
                      function: () {
                        cubit.updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text);
                      },
                      text: "Update"),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        cubit.logOut(context);
                      },
                      text: "Log Out"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
