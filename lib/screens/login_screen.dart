import 'package:chat_app/screens/signup_screen.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LogIn extends StatefulWidget {
  static const String screenRoute = 'login_screen';

  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _auth= FirebaseAuth.instance;
  late String email;
  late String password;

  bool showReloading= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showReloading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset("images/chat.png"),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              TextField(

                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'enter Your Email',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              TextField(
                obscureText: true ,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'enter Your Password',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              MyButton(
                  color: Colors.orange,
                  title: 'Log In',
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);

                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.screenRoute);
                      }
                    }catch(e){
                      print(e);
                    }
                  },
                    ),
              const Padding(padding: EdgeInsets.all(10),),
              MyButton(color: Colors.orangeAccent, title: 'have no account ? register', onPressed:(){
                Navigator.pushNamed(context, SignUp.screenRoute);
              })
            ],
          ),
        ),
      ),
    );
  }
}
