import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../settings/presentation/settings.dart';

import '../../domain/models/products.dart';
import '../widgets/categorie_name.dart';
import '../widgets/navigation_bar.dart';

class ProductEditing extends StatefulWidget {
  Product product;

  ProductEditing({
    required this.product,
    super.key,
  });

  @override
  State<ProductEditing> createState() => _ProductEditingState();
}

class _ProductEditingState extends State<ProductEditing> {
  TextEditingController _productName = TextEditingController();

  TextEditingController _productDate = TextEditingController();

  Image? productImage;
  File? temporaryImage;
  bool pictureChanged = false;
  late int benachrichtigungsTage;
  bool s1 = false;
  bool s2 = false;
  bool s3 = false;
  bool s4 = false;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.product.productName);
    _productName.text = widget.product.productName;
    DateTime exDate = widget.product.expiryDate.toDate();
    String endDate = DateFormat('d.M.y').format(exDate);
    _productDate.text = endDate;
    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      //print(image.toString());
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.temporaryImage = imageTemp);
      pictureChanged = true;
      // setState(() => widget.product.productImage );
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Future<String> uploadProductImageToStorage(File imageFile) async {
  //   try {
  //     Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child("productProfiles/${widget.product.productId}/productImage");
  //     TaskSnapshot uploadTask = await storageReference.putFile(imageFile);

  //     String downloadUrl = await uploadTask.ref.getDownloadURL();

  //     return downloadUrl;
  //   } catch (e) {
  //     print(e.toString());
  //     return "";
  //   }
  // }

  void deleteImage() {
    setState(() {
      FirebaseFirestore.instance
          .collection('products')
          .doc('produktbild')
          .delete();
    });
  }

  Future updateProductFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      DateTime exdate = DateFormat('d.M.y').parse(_productDate.text);
      Timestamp endDate = Timestamp.fromDate(exdate);
      String name = _productName.text;
      // upload to Storage
      // String downloadLink =
      //     pictureChanged ?
      //     await uploadProductImageToStorage(this.temporaryImage!) : "";
      Map<String, dynamic> data = {
        "ownerId": user != null
            ? user.uid
            : throw FormatException("You have to be logged in"),
        "name": name,
        "ablaufdatum": endDate,
        'benachrichtigungstage': benachrichtigungsTage,
        // 'produktbild': pictureChanged ? downloadLink : widget.product.productImage
      };

      FirebaseFirestore.instance
          .collection("products")
          .doc(widget.product.productId)
          .update(data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Product?> fetchProductFromFirebase() async {
    try {
      DocumentSnapshot productDocument = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product.productId)
          .get();
      //print(productDocument.data().toString());

      Product product = Product.fromJson(
        productDocument.data() as Map<String, dynamic>,
        widget.product.productId,
      );
      benachrichtigungsTage = product.notificationDays;
      return product;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future _dateonTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2123),
      firstDate: DateTime(2023),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    _productDate.text = DateFormat('d.M.y').format(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: AppBar(
          elevation: 0,
          shape: Border(bottom: BorderSide(color: Colors.black, width: 1)),
          toolbarHeight: 80,
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
                "Produkt bearbeiten",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Setting();
                    },
                  ),
                );
              },
            )
          ],
          automaticallyImplyLeading: true,
          leading: BackButton(
            color: Colors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 150,
            child: Image.asset(
              "assets/logo.png",
            ),
          ),
          // TextButton(
          //     onPressed: () {
          //       pickImage();
          //     },
          //     child: Column(
          //       children: [
          //         Container(
          //           width: 200,
          //           height: 150,
          //           clipBehavior: Clip.hardEdge,
          //           // decoration: BoxDecoration(
          //           //     shape: BoxShape.rectangle,
          //           //     borderRadius: BorderRadius.all(Radius.circular(20))),
          //           // child: this.pictureChanged
          //           //     ? Image.file(
          //           //         (this.temporaryImage!),
          //           //         fit: BoxFit.cover,
          //           //         width: 150,
          //           //       )
          //           //     : Image.network(
          //           //         widget.product.productImage,
          //           //         fit: BoxFit.cover,
          //           //         width: 150,
          //           //       ),
          //         ),
          //         SizedBox(
          //           height: 10,
          //         ),
          //         Text(
          //           'Bild ändern',
          //           style: Theme.of(context).textTheme.displaySmall,
          //         )
          //       ],
          //     )),

          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                controller: _productName,
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(217, 217, 217, 100),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: _productName.clear,
                    icon: Icon(Icons.clear),
                  ),
                ),
              )),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: TextField(
                      controller: _productDate,
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(217, 217, 217, 100),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: _productName.clear,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                      onTap: () {
                        _dateonTapFunction(context: context);
                      })),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.calendar_month_outlined),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Benachrichtigungstage auswählen",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: fetchProductFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  width: 260,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Switch(
                                  activeColor: Colors.green,
                                  value: widget.product.notificationDays == 2,
                                  onChanged: (bool newValue) {
                                    s1 = newValue;
                                    setState(() async {
                                      if (s1 = true) {
                                        benachrichtigungsTage = 2;
                                      }
                                      //update value when switch changed
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  child: Text("2"),
                                )
                              ])),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Switch(
                                  activeColor: Colors.green,
                                  value: widget.product.notificationDays == 4,
                                  onChanged: (bool newValue) {
                                    s2 = newValue;

                                    setState(() async {
                                      //update value when sitch changed
                                      if (s2 = true) {
                                        benachrichtigungsTage = 4;
                                      }
                                    });
                                    //update value when sitch changed
                                  },
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 20,
                                  child: Text("4"),
                                )
                              ])),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(children: [
                                    Switch(
                                      activeColor: Colors.green,
                                      value:
                                          widget.product.notificationDays == 5,
                                      onChanged: (bool newValue) {
                                        s3 = newValue;
                                        setState(() async {
                                          //update value when sitch changed

                                          if (s3 = true) {
                                            benachrichtigungsTage = 5;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 20,
                                      child: Text("5"),
                                    )
                                  ])),
                              SizedBox(
                                width: 50,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(children: [
                                    Switch(
                                      activeColor: Colors.green,
                                      value:
                                          widget.product.notificationDays == 7,
                                      onChanged: (bool newValue) {
                                        s4 = newValue;
                                        setState(() async {
                                          //update value when sitch changed
                                          if (s4 = true) {
                                            benachrichtigungsTage = 7;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 20,
                                      child: Text("7"),
                                    )
                                  ])),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 45,
            width: 200,
            child: FloatingActionButton(
              onPressed: () {
                print(_productName.text);
                updateProductFromFirebase();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NavigationTabBar()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Text(
                'Bestätigen',
                style: TextStyle(
                    color: Color.fromRGBO(255, 219, 152, 0.612),
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromRGBO(8, 8, 8, 1),
            ),
          ),
        ]),
      ),
    );
  }
}
