import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/my_button.dart';

class MainScreen extends StatefulWidget {
  static const String screenRoute = 'main_screen';

  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/chat.png'),
            )),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          MyButton(
            color: Colors.orange,
            title: 'Log In ',
            onPressed: (){
              Navigator.pushNamed(context, LogIn.screenRoute);
            },

              ),

          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          MyButton(
              color: Colors.orange,
              title: 'Sign Up  ',
              onPressed: () {
                Navigator.pushNamed(context, SignUp.screenRoute);
              }),
        ],
      ),
    );
  }
}
