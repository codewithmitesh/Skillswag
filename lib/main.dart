// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skillshare/Controlls/UploadPost.dart';
import 'package:skillshare/Screens/feedHelpers.dart';
import 'package:skillshare/Screens/homepagehelpers.dart';
import 'package:skillshare/Services/firebase_operations.dart';
import './Authenticate/login_page.dart';
import 'Authenticate/landing_helper.dart';
import 'Controlls/control_services.dart';
import 'Controlls/control_utils.dart';
import 'Screens/feed.dart';
import 'Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Services/auth.dart';
import 'OnboardingScreen/onboarding_screen.dart';
import 'Screens/profile.dart';
import 'Screens/profilehelper.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseOperations()),
        ChangeNotifierProvider(create: (_) => UploadPost()),
        ChangeNotifierProvider(create: (_) => ControlUtils()),
        ChangeNotifierProvider(create: (_) => LandingHelpers()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => ControlServices()),
        ChangeNotifierProvider(create: (_) => ProfileHelper()),
        ChangeNotifierProvider(create: (_) => FeedHelper()),
        ChangeNotifierProvider(create: (_) => HomePageHelpers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
        home: wrapper(),
      ),
    );
  }
}

class wrapper extends StatefulWidget {
  wrapper({Key? key}) : super(key: key);

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    // TODO: Here We need Maintain the Already login Situation and here Login Screen will be Floated
    // return LoginPage()

//! Uncomment this to show again Introscreen and Everything
    return IntroScreen();
    // return HomeProfile();

    // return ProfilPage(url: "http://#");
  }
}
