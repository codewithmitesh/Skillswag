// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Authenticate/login_page.dart';
import '../Services/auth.dart';
import 'profilehelper.dart';

class ProfilPage extends StatefulWidget {
  final String url;

  ProfilPage({required this.url});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: ,
      body: SingleChildScrollView(
        // controller: ,
        child: Container(
          height: MediaQuery.of(context).size.height, // *5

          // height: MediaQuery.of(context).size.height * 5,

          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<DocumentSnapshot>(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return new Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back_ios)),
                          IconButton(
                            icon: Icon(EvaIcons.logOut),
                            onPressed: () {
                              Provider.of<ProfileHelper>(context, listen: false)
                                  .LogOutDiaglog(context);
                            },
                          )
                        ],
                      ),
                    ),
                    Provider.of<ProfileHelper>(context, listen: false)
                        .HeaderProfile(context, snapshot),
                    Provider.of<ProfileHelper>(context, listen: false)
                        .FooterProfile(context, snapshot),
                  ],
                );
              }
            },
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(Provider.of<Authentication>(context, listen: false)
                    .getUserUid)
                .snapshots(),
          ),
          decoration: BoxDecoration(),
        ),
      ),
    );
  }
}

// Widget buildNavBarItem(IconData icon, int index) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         _selectedItemIndex = index;
//       });
//     },
//     child: Container(
//       // width: MediaQuery.of(context).size.width / 5,
//       height: 45,
//       child: icon != null
//           ? Icon(
//               icon,
//               size: 25,
//               color: index == _selectedItemIndex
//                   ? Colors.black
//                   : Colors.grey[700],
//             )
//           : Container(),
//     ),
//   );
// }

//   Card buildPictureCard(String url) {
//     return Card(
//       elevation: 10,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: NetworkImage(url),
//             )),
//       ),
//     );
//   }

//   Column buildStatColumn(String value, String title) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey[400],
//           ),
//         ),
//       ],
//     );
//   }
// }
