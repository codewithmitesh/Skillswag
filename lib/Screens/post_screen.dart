// ignore_for_file: prefer_const_constructors

// import 'dart:htm';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Controlls/UploadPost.dart';

class PostSelection extends StatefulWidget {
  @override
  State<PostSelection> createState() => _PostSelectionState();
}

class _PostSelectionState extends State<PostSelection> {
  // const PostSelection({Key? key}) : super(key: key);
  File initialImage = File("");
  // @override
  // void initState() {
  //   initialImage =
  //       Provider.of<UploadPost>(context, listen: false).uploadPostImage;

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
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
                    Provider.of<UploadPost>(context, listen: false)
                        .pickUploadPostImage(context, ImageSource.gallery)
                        .whenComplete(() {
                      initialImage =
                          Provider.of<UploadPost>(context, listen: false)
                              .uploadPostImage;
                    });
                  }),
            ),
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 80.0,
              backgroundImage: FileImage(
                  Provider.of<UploadPost>(context, listen: false)
                      .uploadPostImage),
            ),
            ElevatedButton(
                child: Icon(Icons.upload),
                onPressed: () {
                  Provider.of<UploadPost>(context, listen: false)
                      .uploadPostImagetoFIrebase()
                      .whenComplete(() {
                    print('Image Uploaded');
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
}
