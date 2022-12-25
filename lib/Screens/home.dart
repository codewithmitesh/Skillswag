// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Authenticate/login_page.dart';
import 'package:skillshare/Screens/chatroom.dart';
import 'package:skillshare/Screens/feed.dart';
import 'package:skillshare/Screens/profile.dart';
import 'package:skillshare/Services/auth.dart';
import 'package:skillshare/Services/firebase_operations.dart';

import 'homepagehelpers.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({Key? key}) : super(key: key);

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> with ChangeNotifier {
  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);

    super.initState();
  }

  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: PageView(
          controller: homepageController,
          children: [FeedPage(), ChatRoom(), ProfilPage(url: "@")],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<HomePageHelpers>(context, listen: false)
                .bottomNavBar(pageIndex, homepageController));
  }
}
