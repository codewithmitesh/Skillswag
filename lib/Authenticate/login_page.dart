// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors_in_immutables, implementation_imports, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/src/provider.dart';
import 'package:skillshare/Authenticate/create_account.dart';
import 'package:skillshare/Screens/home.dart';
import 'create_account.dart';
import '../Services/auth.dart';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: lowercase_with_underscore

//Login page Statefull Widget
class LoginPage extends StatefulWidget {
  LoginPage(BuildContext context, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ChangeNotifier {
  // final Authentication _auth = new Authentication();

  final TextEditingController emailControllerForLogin = TextEditingController();
  final TextEditingController passControllerForLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
              child: Image.asset('assets/Images/shareSKILLS.png'),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailControllerForLogin,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    controller: passControllerForLogin,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password',
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: Text('Forgot Password'),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                // style: ,
                // color: Colors.grey,
                child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (emailControllerForLogin.text.isNotEmpty) {
                    Provider.of<Authentication>(context, listen: false)
                        .logIntoAccount(emailControllerForLogin.text,
                            passControllerForLogin.text)
                        .whenComplete(() => {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: HomeProfile(),
                                    type: PageTransitionType.leftToRight,
                                  ))
                            });
                  } else {
                    print('Please Provide Proper Emails');
                  }
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Dont have an account?'),
                  TextButton(
                    // textColor: Colors.blue,
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: SignUpPage(),
                            type: PageTransitionType.rightToLeft),
                      );
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                Provider.of<Authentication>(context, listen: false)
                    .signInWithGoogle()
                    .whenComplete(() {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: HomeProfile(),
                          type: PageTransitionType.leftToRight));
                });
              },
            ),
            Image.asset('assets/Images/connected.png'),
          ],
        ),
      ),
    );
  }
}
// *  Beware ful whichever widget we use Provider we need to add ' with changeNotifier '

