import 'package:ecom/pages/Home.dart';
import 'package:ecom/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Ecom());
}

class Ecom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: light(context),
      darkTheme: dark(context),
      themeMode: ThemeMode.system,
      home: AnimatedSplashScreen(
        backgroundColor: Color.fromARGB(255, 235, 235, 235),
        splashIconSize: 500,
        splash: Splash(),
        nextScreen: home(),
      ),
    );
  }
}
