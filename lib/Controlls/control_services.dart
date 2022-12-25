// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Services/firebase_operations.dart';

import 'control_utils.dart';

class ControlServices with ChangeNotifier {
  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.yellow,
                  ),
                ),
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.purpleAccent[700],
                  backgroundImage: FileImage(
                    Provider.of<ControlUtils>(context, listen: false)
                        .userAvatar,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: Text("Reselect"),
                        onPressed: () {
                          Provider.of<ControlUtils>(context, listen: false)
                              .pickUserAvatar(context, ImageSource.gallery);
                        },
                      ),
                      ElevatedButton(
                        child: Text("Confirm"),
                        onPressed: () {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .uploadUserAvatar(context)
                              .whenComplete(() {
                            // print(
                            //     "The USer Avatar Image url => ${Provider.of<ControlUtils>(context, listen: false).userAvatarUrl}");
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        });
  }

  notifyListeners();
}
