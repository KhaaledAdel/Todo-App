import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Screens/homeScreen/HomeScreen.dart';
import 'package:todo_app/Screens/settingScreen/SettingScreen.dart';
import '../../core/Widget/CustomTextFieldForm.dart';
import '../../core/services/snackbar_service.dart';
import '../../layout/Home_layout/home_layout.dart';
import '../Registeration/RegisterScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        image: const DecorationImage(
            image: AssetImage("assets/images/login_pattern.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: 120,
          title: Text(
            "Login",
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.14,
            left: 20,
            right: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome back!",
                  textAlign: TextAlign.left,
                  style:
                  theme.textTheme.titleLarge!.copyWith(color: Colors.black),
                ),
                const SizedBox(),
                CustomTextFormField(
                  controller: emailController,
                  labelText: "E-mail",
                  maxLines: 1,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "you must enter your name";
                    }

                    var regex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                    if (!regex.hasMatch(v)) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height:10),

                CustomTextFormField(
                  controller: passwordController,
                  labelText: "Password",
                  maxLines: 1,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "you must enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(height:10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password ?",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height:10),

                MaterialButton(
                  onPressed: () {
                    login();
                    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height:10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      "Or Create new account !",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height:10),

              ],
            ),
          ),
        ),
      ),
    );
  }
  login() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        final credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        EasyLoading.dismiss();

        SnackBarService.showSuccessMessage("Your Succerssfully signed in");
        Navigator.pushReplacementNamed(context,HomeLayout.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage('No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}