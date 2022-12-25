// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, avoid_unnecessary_containers

// import 'dart:io';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skillshare/Services/firebase_operations.dart';

import '../Services/auth.dart';

class UploadPost with ChangeNotifier {
  TextEditingController captionController = TextEditingController();

  PostScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            Text(
              "Please Select Your Image ",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Center(
              child: ElevatedButton(
                  child: Icon(Icons.image),
                  onPressed: () {
                    pickUploadPostImage(context, ImageSource.gallery);
                    // Provider.of<UploadPost>(context, listen: false)
                    //     .pickUploadPostImage(context, ImageSource.gallery)
                    //     .whenComplete(() {
                    //   initialImage =
                    //       Provider.of<UploadPost>(context, listen: false)
                    //           .uploadPostImage;
                    // });
                  }),
            ),
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 80.0,
              backgroundImage: FileImage(uploadPostImage),
            ),
            ElevatedButton(
                child: Icon(Icons.upload),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         child: editPostSheet(context),
                  //         type: PageTransitionType.bottomToTop));

                  // Original Code
                  uploadPostImagetoFIrebase().whenComplete(() {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: editPostSheet(context),
                            type: PageTransitionType.bottomToTop));

                    print("Image Uploaded Successfully!!");
                  });
                }),
            ElevatedButton(
              child: Icon(Icons.backspace_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
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
                    onPressed: () {},
                  ),
                  ElevatedButton(child: Text("Camera"), onPressed: () {})
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
// upload task Code for uploading thw task

  File uploadPostImage = File("");
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl = "";
  String get getUploadPostImageUrl => uploadPostImageUrl;
  late UploadTask imagePostUploadTask;

  final picker = ImagePicker();

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.pickImage(source: source);

    if (uploadPostImageVal == null) {
      print("Please Select the user avatar");
      return;
    } else {
      uploadPostImage = File(uploadPostImageVal.path);
    }
    print(uploadPostImageVal.path);
    if (uploadPostImage != null) {
    } else {
      print("Image Upload Error!!!");
    }
    notifyListeners();
  }

  Future uploadPostImagetoFIrebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');

    imagePostUploadTask = imageReference.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print("Post Image Uploaded Successfully to firsestore");
    });

    imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  editPostSheet(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 150, right: 150, top: 100),
              child: Divider(
                thickness: 4.0,
                color: Colors.grey,
              ),
            ),
            Container(
              child: Row(children: [
                SizedBox(
                  height: 200,
                  width: 50,
                ),
                Container(
                  height: 190.0,
                  width: 300.0,
                  child: Image.file(uploadPostImage, fit: BoxFit.contain),
                )
              ]),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                  ),
                  Container(
                    height: 110,
                    width: 5.0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 120,
                      width: 330.0,
                      child: TextField(
                        maxLines: 5,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        maxLength: 100,
                        controller: captionController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add Caption... ',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () async {
                Provider.of<FirebaseOperations>(context, listen: false)
                    .uploadPostData(captionController.text, {
                  'PostImage': getUploadPostImageUrl,
                  'caption': captionController.text,
                  'username':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .initUserName,
                  'userImage':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .initUserImage,
                  'userUid': Provider.of<Authentication>(context, listen: false)
                      .getUserUid,
                  'time': Timestamp.now(),
                  'useremail':
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .initUserEmail,
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              },
              child: Text("Share"),
              color: Colors.deepOrange,
            ),
          ]),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

 // return showBottomSheet(
    //   context: context,
    //   builder: (context) {
    //     return Container(
    //       height: MediaQuery.of(context).size.height * 0.1,
    //       width: MediaQuery.of(context).size.width,
    //       decoration: BoxDecoration(
    //         color: Colors.yellowAccent,
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //       child: Column(children: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 150.0),
    //           child: Divider(
    //             thickness: 4.0,
    //             color: Colors.white70,
    //           ),
    //         ),
    //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //           MaterialButton(
    //             child: Text('Gallery'),
    //             onPressed: null,
    //           ),
    //           MaterialButton(
    //             child: Text('Camera'),
    //             onPressed: null,
    //           )
    //         ]),
    //       ]),
    //     );
    //   },
    // );