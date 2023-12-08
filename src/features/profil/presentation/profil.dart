import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../log_in/domain/models/user.dart';
import '../../my_list/presentation/widgets/navigation_bar.dart';

class Profil extends StatefulWidget {
  Profil({
    super.key,
  });

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Future<UserFirebase?> fetchUserFromFirebase() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDocument = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();
      print(userDocument.data().toString());

      UserFirebase user =
       UserFirebase.fromJson(userDocument.data() as Map<String, dynamic>);

      return user;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _userName = TextEditingController();

    final userEmail = FirebaseAuth.instance.currentUser;
    _email.text = userEmail!.email!;
    updateUserNameToFirebase() {
      final user = FirebaseAuth.instance.currentUser;
      try {
        Map<String, dynamic> data = {
          "userId": user != null
              ? user.uid
              : throw FormatException("You have to be logged in"),
          "name": _userName.text.isNotEmpty
              ? _userName.text
              : throw FormatException("Dein Profil braucht einen Namen"),
        };

        FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .update(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            "Profil",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 FutureBuilder(future: fetchUserFromFirebase(),
             builder:(context, snapshot) {
              if(snapshot.hasData){
                UserFirebase user = snapshot.data!;
                return Column(
                  children: [
              //       Container(width: 150,
              // height: 150,
              // clipBehavior: Clip.hardEdge,
              // decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: Colors.grey,
              //       width: 5,
              //     )),child:  
               Image.asset(
                "assets/splash_logo.png",
                height: 200,
                width: 200,
              ),
              //),
                  
                  ],
                );
                
              }else{
                return CircularProgressIndicator();
              }
            },),
                SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                    future: fetchUserFromFirebase(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserFirebase user = snapshot.data!;
                        _userName.text = user.name;
                        return Container(
                            color: Color.fromRGBO(217, 217, 217, 100),
                            width: 300,
                            child: TextField(
                              controller: _userName,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  onPressed: _userName.clear,
                                  icon: Icon(Icons.clear),
                                ),
                              ),
                            ));
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                SizedBox(
                  height: 50,
                ),
                Container(
                  color: const Color.fromRGBO(217, 217, 217, 100),
                  width: 300,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: _email.clear,
                        icon: Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: FloatingActionButton(
                    onPressed: () {
                      updateUserNameToFirebase();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NavigationTabBar()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Text(
                      'Bestätigen',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 201, 101, 0.612),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Color.fromRGBO(8, 8, 8, 1),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}