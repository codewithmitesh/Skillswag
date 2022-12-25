// Controll_Utills is Landing Utills
// ignore_for_file: avoid_print
//! Notify Lister always comes after all Future Methods

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Controlls/control_services.dart';
import 'package:skillshare/Services/firebase_operations.dart';

class ControlUtils with ChangeNotifier {
  final picker = ImagePicker();
  File userAvatar = File("");
  File get getUserAvatar => userAvatar;
  String userAvatarUrl = "";
  String get getUserAvatarUrl => userAvatarUrl;

  // Noe Declaring Future For Picking the Image from file system
  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.pickImage(source: source);
    if (pickedUserAvatar == null) {
      print("Please Select the user avatar");
      return;
    } else {
      userAvatar = File(pickedUserAvatar.path);
    }

    if (userAvatar != null) {
      Provider.of<ControlServices>(context, listen: false)
          .showUserAvatar(context);
    } else {
      print("Image Upload Error!!!");
    }

    print(userAvatar.path);

    notifyListeners();
  }

  Future selectAvatarOptionSheet(BuildContext context) async {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: Divider(
                  thickness: 4.0,
                  color: Colors.yellow,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text("Gallery"),
                    onPressed: () {
                      pickUserAvatar(context, ImageSource.gallery)
                          .whenComplete(() {
                        Navigator.pop(context);
                        Provider.of<ControlServices>(context, listen: false)
                            .showUserAvatar(context);
                      });
                    },
                  ),
                  ElevatedButton(
                      child: Text("Camera"),
                      onPressed: () {
                        pickUserAvatar(context, ImageSource.camera)
                            .whenComplete(
                          () {
                            Navigator.pop(context);
                            Provider.of<ControlServices>(context, listen: false)
                                .showUserAvatar(context);
                          },
                        );
                      })
                ],
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      },
    );
  }
}
