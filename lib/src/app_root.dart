import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/main_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      home:  const SplashScreen(),
      routes: {
        SplashScreen.screenRoute:(context)=> const SplashScreen(),
        MainScreen.screenRoute: (context) => const MainScreen(),
        LogIn.screenRoute: (context) =>const LogIn(),
        SignUp.screenRoute:(context)=>const SignUp(),
        ChatScreen.screenRoute: (context)=>const ChatScreen()
      },
    );
  }
}
