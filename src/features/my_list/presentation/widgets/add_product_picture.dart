// import 'dart:io';



// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';


// class AddProductPicture extends StatefulWidget {
 

//   const AddProductPicture({
//     super.key,
//   });

//   @override
//   State<AddProductPicture> createState() => _AddProductPicture();
// }

// class _AddProductPicture extends State<AddProductPicture> {
//  File? image;

//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       //print(image.toString());
//       if (image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   //   Future<String> uploadProductImageToStorage(File imageFile, String productId)async{
//   //   try {
//   //     Reference storageReference = FirebaseStorage.instance.ref().child("productProfiles/$productId/productImage");
//   //     TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

//   //     String downloadUrl = await uploadTask.ref.getDownloadURL();

//   //     return downloadUrl;
      
//   //   } catch (e) {
//   //     print(e.toString());
//   //     return "";
//   //   }
//   // }

//   void deleteImage() {
//     setState(() {
//       this.image;
//     });
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: () => pickImage(),
//         onLongPress: () => deleteImage(),
//         child: Center(
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Container(
//             width: 200,
//             height: 150,
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             child: image != null
//                 ? Image.file(
//                     (image!),
//                     fit: BoxFit.cover,
//                     width: 150,
//                   )
//                 : const Icon(
//                     Icons.add_photo_alternate_outlined,
//                     size: 100,
//                     color: Colors.grey,
//                   )
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Bild hinzufügen",
//             style: TextStyle(color: Color.fromRGBO(0, 179, 255, 1)),
//           ),
//         ])));
//   }
// }
