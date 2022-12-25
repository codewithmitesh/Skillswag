// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Screens/post_screen.dart';
import 'package:skillshare/Screens/profile.dart';

import '../Controlls/UploadPost.dart';

class FeedHelper with ChangeNotifier {
  Widget appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "shareSKILLS",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 68, 5, 73)),
          ),
          MaterialButton(
              child: Icon(Icons.camera_alt),
              // onPressed: null,
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Provider.of<UploadPost>(context, listen: false)
                            .PostScreen(context),
                        type: PageTransitionType.bottomToTop));
              }
              // onPressed:
              //(){
              //
              //
              //
              //Provider.of<UploadPost>(context, listen: false)
              // .selectPostImageType(context),
              // }
              )
        ],
      ),
    );
  }

  Widget FeedBody(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return buildPostSection(context, snapshot);
            }
            //   }).toList() as List<Widget>,
          }),
    );
  }

  // padding: EdgeInsets.only(left: 10, right: 10, top: 45),
  // child: Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Container(
  //       height: 2,
  //       color: Colors.grey[300],
  //       margin: EdgeInsets.symmetric(horizontal: 10),
  //     ),
  //     SizedBox(height: 20),
  // Text(
  //   "Photography",
  //   style: TextStyle(
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //       color: Color.fromARGB(255, 97, 93, 93)),
  // ),
  // Expanded(
  //   child: ListView(
  //     padding: EdgeInsets.only(top: 8),
  //     children: [
  //       // buildPostSection(
  //       //     "https://www.haqseengineer.com/wp-content/uploads/2019/07/campus3-1.jpg",
  //       //     "https://media-exp1.licdn.com/dms/image/C4D03AQFTg2cGxVuocQ/profile-displayphoto-shrink_200_200/0/1623771179828?e=1652313600&v=beta&t=BiOegBDA8jR6N0rFnniGeqvwGGzSuqRe45N9r5BSxIY",
  //       //     context),
  //       // buildPostSection(
  //       //     "https://images.unsplash.com/photo-1433162653888-a571db5ccccf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80",
  //       //     "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
  //       //     context),
  //       // buildPostSection(
  //       //     "https://images.pexels.com/photos/1212600/pexels-photo-1212600.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=200&w=1260",
  //       //     "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=100&w=640",
  //       //     context),
  //     ],
  //   ),
  // )
  // ],

  // Post Section Widget
  Widget buildPostSection(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
        children: snapshot.data?.docs.map((DocumentSnapshot documentSnapshot) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPostFirstRow((documentSnapshot.data() as Map)['userImage'],
                (documentSnapshot.data() as Map)['username'], context),
            SizedBox(
              height: 10,
            ),
            buildPostPicture(
                (documentSnapshot.data() as Map)['PostImage'], context),
            SizedBox(
              height: 5,
            ),
            Text(
              (documentSnapshot.data() as Map)['caption'],
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      );
    }).toList() as List<Widget>);
  }

  // post row widget
  Row buildPostFirstRow(
      String urlProfilePhoto, String userName, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilPage(url: urlProfilePhoto)));
              },
              child: Hero(
                tag: urlProfilePhoto,
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(urlProfilePhoto),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName != null ? userName : 'Default user name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "MITAOE, Alandi, Pune",
                //   style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey[500]),
                // ),
              ],
            )
          ],
        ),
        Icon(Icons.more_vert)
      ],
    );
  }

  // postPicture widget
  Stack buildPostPicture(String urlPost, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.width - 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(urlPost),
              )),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: LikeButton(size: 35),
        )
      ],
    );
  }

  notifyListeners();
}
