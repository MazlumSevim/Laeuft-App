import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/navigation_bar.dart';
import 'package:lauft_app/src/features/settings/presentation/settings.dart';
import '../../domain/models/products.dart';

// ignore: must_be_immutable
class ScanManualInput extends StatefulWidget {
  String category;

  ScanManualInput(
    this.category, {
    super.key,
  });

  @override
  State<ScanManualInput> createState() => _ScanManualInput();
}

class _ScanManualInput extends State<ScanManualInput> {
  bool s1 = false, s2 = false, s3 = false, s4 = false;
  TextEditingController _productController = TextEditingController();
  TextEditingController _productDate = TextEditingController();
  late int benachrichtigungsTage;
  File? img;

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     //print(image.toString());
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.img = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Future<String> uploadProductImageToStorage(File imageFile, String produktbild ) async {
  //     Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child(produktbild);

  //     TaskSnapshot uploadTask = await storageReference.putFile(imageFile);
  //   try {

  //   var downloadUrl = await uploadTask.ref.getDownloadURL();

  //     return downloadUrl;
  //   } catch (e) {
  //     print(e.toString());
  //     return "";
  //   }
  // }

  void deleteImage() {
    setState(() {
      this.img;
    });
  }

  Future dateonTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime(2123),
      firstDate: DateTime(2023),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    _productDate.text = DateFormat('d.M.y').format(pickedDate);
  }

  Future addToProduct() async {
    try {
      String productName = _productController.text;
      String productDate = _productDate.text;
      DateTime exdate = DateFormat('d.M.y').parse(productDate);
      Timestamp endDate = Timestamp.fromDate(exdate);
//  String imagePath = await uploadProductImageToStorage(
//           img!, FirebaseFirestore.instance.collection('products').doc().id);
      final productId =
          FirebaseFirestore.instance.collection('products').doc().id;
      Product product = Product(
          category: widget.category,
          productName: productName,
          expiryDate: endDate,
          notificationDays: benachrichtigungsTage,
          ownerId: FirebaseAuth.instance.currentUser!.uid,
          // productImage: imagePath,
          productId: productId);

      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .set(product.JsonFromProduct());
      print('produkt erstellt');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //    String productName = _productController.text;
    //   String productDate = _productDate.text;
    //     addToProduct() async{

    //   try {
    //     Map<String, dynamic> data = {
    //       "ownerId": FirebaseAuth.instance.currentUser!.uid,
    //       "category": this.widget.category,
    //       'name': productName.isNotEmpty
    //           ? productName
    //           : throw FormatException("Ein restaurant braucht einen Namen"),
    //       "ablaufdatum": productDate,
    //       'benachrichtigungstage': benachrichtigungsTage
    //     };

    //     await FirebaseFirestore.instance.collection("products").add(data);
    //   } catch (e) {
    //     debugPrint(e.toString());
    //   }
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(95.0),
          
          child: AppBar(
            elevation: 0,
            shape: Border(bottom: BorderSide(color: Colors.black, width: 1)),
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
                  "Produkt hinzufügen",
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

        // bottom: TabBar(
        //   indicator: BoxDecoration(
        //       borderRadius: BorderRadius.circular(6),
        //       color: Color.fromARGB(255, 215, 215, 215)),
        //   indicatorColor: Colors.grey,
        //   labelColor: Colors.black,
        //   tabs: [
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Tab(text: "Kamerascan"),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Icon(
        //         Icons.qr_code_scanner_rounded,
        //       ),
        //     ]),
        //   Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [Tab(text: ("Manuelle Eingabe"))])
        // ],

        body: Center(
          // AiBarcodeScanner(
          //   onScan: (String) {},
          // ),
          child: Column(children: [
            // TextButton(
            //     onPressed: () => pickImage(),
            //     onLongPress: () => deleteImage(),
            //     child: Center(
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //           Container(
            //               width: 200,
            //               height: 150,
            //               clipBehavior: Clip.hardEdge,
            //               decoration: BoxDecoration(
            //                   shape: BoxShape.rectangle,
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(20))),
            //               child: img != null
            //                   ? Image.file(
            //                       (img!),
            //                       fit: BoxFit.cover,
            //                       width: 150,
            //                     )
            //                   : const Icon(
            //                       Icons.add_photo_alternate_outlined,
            //                       size: 100,
            //                       color: Colors.grey,
            //                     )),
            //           SizedBox(
            //             height: 5,
            //           ),
            //           Text(
            //             "Bild hinzufügen",
            //             style: Theme.of(context).textTheme.displaySmall,
            //           ),
            //         ]))),
            Image.asset(
              "assets/logo.png",
              height: 140,
              width: 140,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                  controller: _productController,
                  decoration: InputDecoration(
                      labelText: "Produktname",
                      suffixIcon: IconButton(
                        onPressed: _productController.clear,
                        icon: Icon(Icons.clear),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(217, 217, 217, 100),
                      border: OutlineInputBorder())),
            ),
            SizedBox(
              height: 20,
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
                      decoration: const InputDecoration(
                          labelText: "Ablaufdatum auswählen",
                          filled: true,
                          fillColor: Color.fromRGBO(217, 217, 217, 100),
                          border: OutlineInputBorder()),
                      onTap: () {
                        dateonTapFunction(context: context);
                      }),
                ),
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
            Container(
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
                              value: s1,
                              onChanged: (bool newValue) {
                                setState(() async {
                                  s1 = newValue;
                                  //update value when sitch changed
                                  if (s1 = true) {
                                    benachrichtigungsTage = 2;
                                  }
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
                              value: s2,
                              onChanged: (bool newValue) {
                                setState(() async {
                                  s2 =
                                      newValue; //update value when sitch changed
                                  if (s2 = true) {
                                    benachrichtigungsTage = 4;
                                  }
                                });
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
                                      width: 1, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Switch(
                                  activeColor: Colors.green,
                                  value: s3,
                                  onChanged: (bool newValue) {
                                    setState(() async {
                                      s3 =
                                          newValue; //update value when sitch changed
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
                                      width: 1, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Switch(
                                  activeColor: Colors.green,
                                  value: s4,
                                  onChanged: (bool newValue) {
                                    setState(() async {
                                      s4 = newValue; //update value when sitch changed
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
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 35,
              width: 200,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NavigationTabBar()));
                  addToProduct();
                  // _productDate.clear();
                  // _productController.clear();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Text(
                  'Bestätigen',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 201, 101, 0.612),
                      fontSize: 18),
                ),
                backgroundColor: Color.fromRGBO(8, 8, 8, 1),
              ),
            ),
          ]),
        ));
  }
}
