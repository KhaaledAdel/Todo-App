import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Screens/Login/LoginScreen.dart';

import '../../core/Widget/CustomTextFieldForm.dart';
import '../../core/services/snackbar_service.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class  _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool isVisable = false;

  var globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        image: const DecorationImage(
            image: AssetImage(
                "assets/images/login_pattern.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: 120,
          iconTheme: IconThemeData(
              color: Colors.white),
          title: Text(
            "Create Account",
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
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),

                  CustomTextFormField(
                    controller: fullNameController,
                    labelText: "Full Name",
                    maxLines: 1,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return "you must enter your name";
                      }
                    },
                  ),
                  SizedBox(height: 5),

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
                  SizedBox(height: 5),

                  CustomTextFormField(
                    controller: passwordController,
                    labelText: "Password",
                    maxLines: 1,
                    obscureText: isVisable,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        isVisable = !isVisable;
                        setState(() {});
                      },
                      child: isVisable != true
                          ? Icon(
                          Icons.visibility_off_outlined)
                          : Icon(
                          Icons.visibility_outlined),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return "you must enter your name";
                      }

                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");

                      if (!regex.hasMatch(v)) {
                        return "Invalid password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),

                  CustomTextFormField(
                    controller: confirmPasswordController,
                    labelText: "Confirm Password",
                    maxLines: 1,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return "you must enter your name";
                      }

                      if (v != passwordController.text) {
                        return "doesn't match the password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  MaterialButton(
                    onPressed: () {

                      register();

                    },
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Regsiter",
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

                  TextButton(

                      onPressed: (){
                      Navigator.pushReplacementNamed(
                          context,LoginScreen.routeName);
                      },
                      child: Text("I Already Have an Account",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: Colors.black),
                      ),
                  ),

                  SizedBox(height: 0.03),
                  // ElevatedButton(onPressed: () {}, child: Text(""))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "khaled1@gmail.com",
        password: "Dola123@",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void register() async {
    if (globalKey.currentState!.validate()) {

      EasyLoading.show();

      print(emailController.text);
      print(passwordController.text);
      try {
        var userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage("Your account has been registered");
        Navigator.pop(context);
        print(userCredential.user?.uid);

        // userCredential.user.ui
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The password provided is too weak.');
          print('The password provided is too weak.');
        }
        else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}