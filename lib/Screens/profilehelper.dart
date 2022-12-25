// ignore_for_file: prefer_const_constructors

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Authenticate/login_page.dart';
import '../Services/auth.dart';

class ProfileHelper with ChangeNotifier {
  Widget HeaderProfile(BuildContext context, dynamic snapshot) {
    return Column(
      children: [
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        Container(
          margin: EdgeInsets.only(top: 35),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 20,
              )
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(snapshot.data.data()['userImage'].toString()),
              //snapshot.data.data()['userImage']
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          snapshot.data.data()['userName'],
          // "me",
          // snapshot.data.data()['userName']
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(EvaIcons.emailOutline),
            //snapshot.data.data()['userEmail']
            Text(
              snapshot.data.data()['userEmail'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildStatColumn("53", "skills shared"),
            buildStatColumn("223k", "Followers"),
            buildStatColumn("117", "Following"),
          ],
        ),
      ],
    );
  }

  Widget FooterProfile(BuildContext context, dynamic snapshot) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 5 / 6,
          children: [
            buildPictureCard(
                "https://www.haqseengineer.com/wp-content/uploads/2019/07/campus3-1.jpg"),
            buildPictureCard(
                "https://images.pexels.com/photos/132037/pexels-photo-132037.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=1260"),
            buildPictureCard(
                "https://images.pexels.com/photos/733475/pexels-photo-733475.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=1260 "),
            buildPictureCard(
                "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=1260"),
            buildPictureCard(
                "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=1260"),
            buildPictureCard(
                "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=200&w=1260"),
          ],
        ),
      ),
    );
  }

  LogOutDiaglog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Log Out?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              MaterialButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  color: Colors.red,
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<Authentication>(context, listen: false)
                        .logOutEmail()
                        .whenComplete(() {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: LoginPage(context),
                              type: PageTransitionType.bottomToTop));
                    });
                  })
            ],
          );
        });
  }

  Card buildPictureCard(String url) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(url),
            )),
      ),
    );
  }

  Column buildStatColumn(String value, String title) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
