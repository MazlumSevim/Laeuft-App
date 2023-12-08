


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lauft_app/src/features/log_in/presentation/pages/registration.dart';
import 'package:lauft_app/src/features/my_list/presentation/pages/my_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => Setting()));
}

  void signOutGoogle() async{
  await GoogleSignIn().signOut();
   print("User Sign Out");
 }

   

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
Future launchEmail({
      required String toEmail,
      required String subject,
    }) async {
      final url = 'mailto:$toEmail?subject=${Uri.encodeFull(subject)}';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      }
    }

    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          elevation: 0,
          shape: Border(
    bottom: BorderSide(
      color: Colors.black,
      width: 1
    )
  ),
          toolbarHeight: 90,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/logo.png',
                height: 50,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Einstellungen",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
        
          automaticallyImplyLeading: true,
                    leading: BackButton(
                      color: Colors.black,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
          
        ),
         
      ),
      body: Center(
        child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
         
          Container(
            width: 300,
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(children: [
                  SizedBox(
                    width: 15,
                    height: 50,
                  ),
                  Container(child: Icon(Icons.thumb_up_alt_outlined)),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Text(
                      "Läuft App bewerten",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ]),
                Divider(
                  color: Colors.black,
                  height: 15,
                ),
                TextButton(
                  onPressed: () {  launchEmail(toEmail: 'mazlum.25.ms@gmail.com', subject: 'Verbesserungsvorschlag für die Läuft-App'); },
                  child: Row(children: [
                    SizedBox(
                      width: 8,
                      height: 30,
                    ),
                    Container(child: Icon(Icons.markunread_outlined,color: Colors.black,size: 28,)),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        "Verbesserungsvorschlag",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
          SizedBox(height: 100,),
        
          SizedBox(
            height: 35,
            width: 200,
            child: FloatingActionButton(
              heroTag: 'Profil Löschen',
              onPressed: () {
              
         
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return Registration();
                }), ModalRoute.withName('/'));
  FirebaseAuth.instance.currentUser?.delete();
FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).delete();  
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Text(
                'Profil löschen',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: TextDecoration.underline),
              ),
              backgroundColor: Color.fromRGBO(209, 209, 214, 100),
            ),
          ),
          SizedBox(height: 50,),
          SizedBox(
            height: 35,
            width: 200,
            child: FloatingActionButton(
              heroTag: 'Sign Out',
              onPressed: () {
                signOutGoogle();
                FirebaseAuth.instance.signOut();                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return Registration();
                }), ModalRoute.withName('/'));
              },
              backgroundColor: Color.fromRGBO(209, 209, 214, 100),
              child: Text(
                'Sign Out',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: TextDecoration.underline),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),
          ),
          SizedBox(height: 50,),
          SizedBox(
            height: 35,
            width: 200,
            child: FloatingActionButton(
              heroTag: 'Bestätigen',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyList();
                    },
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Text(
                'Bestätigen',
                style: TextStyle(color: Color.fromRGBO(255, 201, 101, 0.612), fontSize: 18),
              ),
              backgroundColor: Color.fromRGBO(8, 8, 8, 1),
            ),
          ),
        ]),
      ),
    );
  
  }
}
