// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors_in_immutables, implementation_imports, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/src/provider.dart';
import 'package:skillshare/Controlls/control_utils.dart';
import 'package:skillshare/Screens/home.dart';
import '../Controlls/control_services.dart';
import '../Services/auth.dart';
import '../Services/firebase_operations.dart';
import '../Widgets/imagepicker.dart';

// ignore_for_file: prefer_const_constructors
// ignore_for_file: lowercase_with_underscore
class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  var pickUserAV = new ControlUtils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //* Logic of Email And Pass Field Complete
          Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 75, bottom: 0, left: 15),
              child: GestureDetector(
                onTap: () {
                  pickUserAV
                      .pickUserAvatar(context, ImageSource.gallery)
                      .whenComplete(() {
                    Navigator.pop(context);
                    Provider.of<ControlServices>(context, listen: false)
                        .showUserAvatar(context);
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: FileImage(
                      Provider.of<ControlUtils>(context, listen: false)
                          .getUserAvatar),
                  radius: 60,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 360,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 360,
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter Email',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 360,
              child: TextField(
                obscureText: true,
                controller: passController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Already have an account?'),
                  SizedBox(
                    width: 90,
                    child: TextButton(
                      // textColor: Colors.blue,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Container(
              height: 50,
              width: 380,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                // textColor: Colors.white,
                // color: Colors.grey,
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    Provider.of<Authentication>(context, listen: false)
                        .createAccount(
                            emailController.text, passController.text)
                        .whenComplete(() => {
                              print("Creating Collection"),
                              Provider.of<FirebaseOperations>(context,
                                      listen: false)
                                  .createUserCollections(context, {
                                'userId': Provider.of<Authentication>(context,
                                        listen: false)
                                    .getUserUid,
                                'userName': nameController.text,
                                'userEmail': emailController.text,
                                'userImage': Provider.of<ControlUtils>(context,
                                        listen: false)
                                    .getUserAvatarUrl,
                              })
                            })
                        .whenComplete(() {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: HomeProfile(),
                              type: PageTransitionType.bottomToTop));
                    });
                  } else {
                    print("Please Provide the proper email address !!!");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
