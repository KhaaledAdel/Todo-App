import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/Screens/Login/LoginScreen.dart';
import 'package:todo_app/Screens/Registeration/RegisterScreen.dart';
import 'package:todo_app/Screens/SplashScreen_View/Splash_View.dart';
import 'Screens/settingScreen/SettingScreen.dart';
import 'core/services/loading_service.dart';
import 'core/theme/application_theme.dart';
import 'firebase_options.dart';
import 'layout/Home_layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ApplicationTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
      },
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}