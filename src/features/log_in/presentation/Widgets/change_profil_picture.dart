import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';





class ChangeProfilPicture extends StatefulWidget {
  const ChangeProfilPicture(   {
    super.key,
  });

  @override
  State<ChangeProfilPicture> createState() => _ChangeProfilPictureState();
}

class _ChangeProfilPictureState extends State<ChangeProfilPicture> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      //print(image.toString());
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //   Future<String> uploadUserImageToStorage(File imageFile, String userId)async{
  //   try {
  //     Reference storageReference = FirebaseStorage.instance.ref().child("userProfiles/$userId/userImage");
  //     TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

  //     String downloadUrl = await uploadTask.ref.getDownloadURL();

  //     return downloadUrl;
      
  //   } catch (e) {
  //     print(e.toString());
  //     return "";
  //   }
  // }
  
  

 Future deleteImage() async {
    setState(() {
      this.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => pickImage(),
        onLongPress: () => deleteImage(),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 150,
            height: 150,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 5,
                )),
                
            child: image != null
                ? Image.file(
                    (image!),
                    fit: BoxFit.cover,
                    width: 200,
                  )
                : const Icon(
                    Icons.person_3_sharp,
                    size: 140,
                    color: Colors.grey,
                  )
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Bild ändern",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ])));
  }
}
