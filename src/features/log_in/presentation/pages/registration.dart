import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lauft_app/src/features/log_in/presentation/pages/create_account.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/navigation_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NavigationTabBar()));
  }

  Future<UserCredential> signInWithGoogle() async {
 
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
      

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    
  }


  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NavigationTabBar()));
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigationTabBar();
          } else {
            return CreateAccount();
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title:
            Text("Anmeldung", style: Theme.of(context).textTheme.displayLarge),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            "assets/logo.png",
            height: 140,
            width: 140,
          ),
          Text(
            "Läuft App",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
              color: Color.fromRGBO(217, 217, 217, 100),
              width: 300,
              child: TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email eingeben",
                  suffixIcon: IconButton(
                    onPressed: emailController.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
              )),
          SizedBox(
            height: 50,
          ),
          Container(
            color: const Color.fromRGBO(217, 217, 217, 100),
            width: 300,
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Passwort eingeben',
                suffixIcon: IconButton(
                  onPressed: passwordController.clear,
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreateAccount()));
            },
            child: Text(
              "Konto erstellen",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
           SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: FloatingActionButton(
              onPressed: () {
                signIn();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Text(
                'Anmelden',
                style: TextStyle(
                    color: Color.fromRGBO(255, 201, 101, 0.612),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(8, 8, 8, 1),
            ),
          ),
          // InkWell(
          //   child: Container(
          //       width: 220,
          //       height: 50,
          //       margin: EdgeInsets.only(top: 25),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(20),
          //           color: Colors.black),
          //       child: Center(
          //           child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: <Widget>[
          //           Container(
          //             height: 30.0,
          //             width: 30.0,
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage('assets/google.jpg'),
          //                   fit: BoxFit.cover),
          //               shape: BoxShape.circle,
          //             ),
          //           ),
          //           Text(
          //             'Sign in with Google',
          //             style: TextStyle(
          //                 fontSize: 16.0,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.white),
          //           ),
          //         ],
          //       ))),
          //   onTap: () async {
          //     signInWithGoogle().then((UserCredential user) {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return NavigationTabBar();
          //           },
          //         ),
          //       );
          //     }).catchError((e) => print(e));
          
          //   },
          // ),
         
        ]),
      ),
    );
  }
}
