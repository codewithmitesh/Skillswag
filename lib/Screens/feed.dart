// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Screens/feedHelpers.dart';
import 'package:skillshare/Screens/profile.dart';

import '../Controlls/UploadPost.dart';

// Tried with stateless widget
// class FeedPage2 extends StatelessWidget {
//   const FeedPage2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//       preferredSize: const Size.fromHeight(100),
//       child: Provider.of<FeedHelper>(context, listen: false).appBar(context),
//     ));
//   }
// }

class SocialMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedPage(),
    );
  }
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child:
              Provider.of<FeedHelper>(context, listen: false).appBar(context),
        ),
        body:
            Provider.of<FeedHelper>(context, listen: false).FeedBody(context));
  }

  // // Story avatar widget
  // Container buildStoryAvatar(String url) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 18),
  //     height: 60,
  //     width: 60,
  //     padding: EdgeInsets.all(3),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30), color: Colors.red),
  //     child: CircleAvatar(
  //       radius: 18,
  //       backgroundImage: NetworkImage(url),
  //     ),
  //   );
  // }
}
