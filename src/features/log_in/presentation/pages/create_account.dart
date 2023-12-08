import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/navigation_bar.dart';
import '../../domain/models/user.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({
    super.key,
  });

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  File? image;



  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     //print(image.toString());
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future<String> uploadUserImageToStorage(File imageFile, String userId) async {
  //   try {
  //     Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child("userProfiles/$userId/userImage");
  //     TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

  //     String downloadUrl = await uploadTask.ref.getDownloadURL();

  //     return downloadUrl;
  //   } catch (e) {
  //     print(e.toString());
  //     return "";
  //   }
  // }

  Future createUserDocument() async {
    try {
      // dynamic imagePath = uploadUserImageToStorage(
      //     image!, FirebaseAuth.instance.currentUser!.uid);
      UserFirebase user = UserFirebase(
        userId: FirebaseAuth.instance.currentUser!.uid,
        // userImage: imagePath,
        name: _userNameController.text,
        email: _emailController.text,
      );
      Map<String, dynamic> data = {
        'userId': user.userId,
        // 'userImage': user.userImage,
        'name': user.name,
        'email': user.email
      };
      //hier würde auch data gehen
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.userId)
          .set(user.JsonFromUser());
      print("user erstellt");
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteImage() async {
    setState(() {
      this.image;
    });
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on Exception catch (e) {
      print(e);
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NavigationTabBar()));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            "Profil erstellen",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              "assets/splash_logo.png",
              height: 200,
              width: 200,
            ),

            // TextButton(
            //     onPressed: () => pickImage(),
            //     onLongPress: () => deleteImage(),
            //     child: Center(
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //           Container(
            //               width: 150,
            //               height: 150,
            //               clipBehavior: Clip.hardEdge,
            //               decoration: BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   border: Border.all(
            //                     color: Colors.grey,
            //                     width: 5,
            //                   )),
            //               child: image != null
            //                   ? Image.file(
            //                       (image!),
            //                       fit: BoxFit.cover,
            //                       width: 200,
            //                     )
            //                   : const Icon(
            //                       Icons.person_3_sharp,
            //                       size: 140,
            //                       color: Colors.grey,
            //                     )),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             "Bild ändern",
            //             style: Theme.of(context).textTheme.displaySmall,
            //           ),
            //         ]))),
            Container(
                color: Color.fromRGBO(217, 217, 217, 100),
                width: 300,
                child: TextField(
                  controller: _userNameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Benutzername eingeben",
                    suffixIcon: IconButton(
                      onPressed: _userNameController.clear,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Container(
                color: Color.fromRGBO(217, 217, 217, 100),
                width: 300,
                child: TextField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email eingeben",
                    suffixIcon: IconButton(
                      onPressed: _emailController.clear,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                )),
            SizedBox(
              height: 30,
            ),
            Container(
              color: const Color.fromRGBO(217, 217, 217, 100),
              width: 300,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwort eingeben',
                  suffixIcon: IconButton(
                    onPressed: _passwordController.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: FloatingActionButton(
                onPressed: () async {
                  await signUp();
                  await createUserDocument();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Text(
                  'Bestätigen',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 201, 101, 0.612),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: Color.fromRGBO(8, 8, 8, 1),
              ),
            ),
          ]),
        ));
  }
}
