import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/src/provider.dart';

import '../Controlls/control_services.dart';

class ImagePickerSheet extends StatefulWidget {
  ImagePickerSheet({Key? key}) : super(key: key);

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  @override
  Widget build(BuildContext context) {
    return Container();
    //      context: context,
    //     builder: (context) {
    //       return Container(
    //         child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 150),
    //               child: Divider(
    //                 thickness: 4.0,
    //                 color: Colors.yellow,
    //               ),
    //             ),
    //             Row(
    //               children: [
    //                 ElevatedButton(
    //                   child: Text("Gallery"),
    //                   onPressed: () {
    //                     pickUserAvatar(context, ImageSource.gallery)
    //                         .whenComplete(() {
    //                       Navigator.pop(context);
    //                       Provider.of<ControlServices>(context, listen: false)
    //                           .showUserAvatar(context);
    //                     });
    //                   },
    //                 ),
    //                 ElevatedButton(
    //                     child: Text("Camera"),
    //                     onPressed: () {
    //                       pickUserAvatar(context, ImageSource.camera)
    //                           .whenComplete(
    //                         () {
    //                           Navigator.pop(context);
    //                           Provider.of<ControlServices>(context, listen: false)
    //                               .showUserAvatar(context);
    //                         },
    //                       );
    //                     })
    //               ],
    //             ),
    //           ],
    //         ),
    //         height: MediaQuery.of(context).size.height * 0.1,
    //         width: MediaQuery.of(context).size.width,
    //         decoration: BoxDecoration(
    //           color: Colors.blueAccent,
    //           borderRadius: BorderRadius.circular(12.0),
    //         ),
    //       );
    //     },
    // }
  }
}

// Future selectAvatarOptionSheet(BuildContext context) async {
//   return showBottomSheet(
//     context: context,
//     builder: (context) {
//       return Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 150),
//               child: Divider(
//                 thickness: 4.0,
//                 color: Colors.yellow,
//               ),
//             ),
//             Row(
//               children: [
//                 ElevatedButton(
//                   child: Text("Gallery"),
//                   onPressed: () {
//                     pickUserAvatar(context, ImageSource.gallery)
//                         .whenComplete(() {
//                       Navigator.pop(context);
//                       Provider.of<ControlServices>(context, listen: false)
//                           .showUserAvatar(context);
//                     });
//                   },
//                 ),
//                 ElevatedButton(
//                     child: Text("Camera"),
//                     onPressed: () {
//                       pickUserAvatar(context, ImageSource.camera).whenComplete(
//                         () {
//                           Navigator.pop(context);
//                           Provider.of<ControlServices>(context, listen: false)
//                               .showUserAvatar(context);
//                         },
//                       );
//                     })
//               ],
//             ),
//           ],
//         ),
//         height: MediaQuery.of(context).size.height * 0.1,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//       );
//     },
//   );
// }
