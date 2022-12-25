// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skillshare/Authenticate/login_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginPage(context)),
    );
  }

  List<PageViewModel> getpages() {
    return [
      PageViewModel(
        image: Image.network('https://picsum.photos/200'),
        title: 'Welcome to Skill share',
        body: 'Please Rate us On Playstore',
        footer: Text("@copywrite 2022 | codewithmitesh"),
      ),
      PageViewModel(
        image: Image.network('https://picsum.photos/200'),
        title: 'Welcome to Skill share Again',
        body: 'Please Rate us On Playstore',
        footer: const Text("@copywrite 2022 | codewithmitesh"),
      ),
      PageViewModel(
        image: Image.network('https://picsum.photos/200'),
        title: 'Share your Skills',
        body: 'Social media App to Showcase your skills',
        footer: Text("@copywrite 2022 | codewithmitesh"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        done: Text(
          "Done",
          style: TextStyle(color: Colors.black),
        ),
        onDone: () => _onIntroEnd(context),
        // onDone: () {
        //   PageTransition(
        //       child: LoginPage(context), type: PageTransitionType.leftToRight);
        // },
        pages: getpages(),
        globalBackgroundColor: Colors.blue[50],
        showNextButton: false,
      ),
    );
  }
}
