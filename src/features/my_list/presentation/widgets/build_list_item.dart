import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lauft_app/src/features/my_list/presentation/pages/product_editing.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/categorie_name.dart';
import '../../domain/models/products.dart';
import 'notification.dart';

class ListItem extends StatefulWidget {
  Product product;

  ListItem({required this.product, super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    Future deleteProductFromFirebase() async {
      try {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.product.productId)
            .delete();
      } catch (e) {
        print(e.toString());
      }
    }

    dynamic productExpiryDate =
        '${widget.product.expiryDate.toDate().day}.${widget.product.expiryDate.toDate().month}.${widget.product.expiryDate.toDate().year}';
    int remainingDays =
        widget.product.expiryDate.toDate().difference(DateTime.now()).inDays;

        categoryBild(){
      if (widget.product.category == categoryLebensmittel) {
      var  productBild =  Image.asset(
            "assets/lebensmittel_logo.png",
            height: 40,
            width: 40,color: Color.fromRGBO(255, 201, 101, 0.612)
          );
          return productBild;
      }    if (widget.product.category == categoryBeautyKosmetik) {
      var  productBild =  Image.asset(
            "assets/beauty_logo.png",
            height: 40,
            width: 40,color: Color.fromRGBO(255, 201, 101, 0.612)
          );
          return productBild;
    }    if (widget.product.category == categoryGetraenke) {
      var  productBild =  Image.asset(
            "assets/getränke_logo.png",
            height: 40,
            width: 40,color: Color.fromRGBO(255, 201, 101, 0.612)
          );
          return productBild;
    } if (widget.product.category == categoryMedikamente) {
      var  productBild =  Image.asset(
            "assets/medikamente_logo.png",
            height: 40,
            width: 40,color: Color.fromRGBO(255, 201, 101, 0.612)
          );
          return productBild;
    } if (widget.product.category == categoryTiernahrnug) {
      var  productBild = Image.asset(
            "assets/tiernahrung.png",
            height: 40,
            width: 40,color: Color.fromRGBO(255, 201, 101, 0.612)
          );
      return productBild;
    } if (widget.product.category == categoryAndere) {
      var  productBild =  Image.asset(
            "assets/other_icon.png",
            height: 60,
            width: 60,color: Color.fromRGBO(255, 201, 101, 0.612)
          );
      return productBild;
    }
        }

    abgelaufenProductName() {
      if (remainingDays <= -1) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProductEditing(product: widget.product);
                  },
                ),
              );
            },
              child: Expanded(
             
                child: Row(children: [
                  Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child:categoryBild(),
                      decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),color: Colors.black)
                      // Image.network(
                      //   //widget.product.productImage,
                      //   fit: BoxFit.cover,
                      //   width: 40,
                      //   height: 40,
                      // )
                      ),
                  SizedBox(
                    width: 10,
                  ),
                 
                     Container(
                      child: Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.productName,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ),
                              Text(
                                  'Ablaufdatum: $productExpiryDate, abgelaufen seit ${remainingDays.abs()} Tag/e',
                                  
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      decoration: TextDecoration.underline)),
                            ]),
                      ),
                     ),
                    
                  
                    SizedBox(
                      width: 50,
                      child: Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                      ),
                    ),
                     
                ]),
              ),
            );
      }if (remainingDays == 0) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProductEditing(
                      product: widget.product,
                    );
                  },
                ),
              );
            },
            child: Row(children: [
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: categoryBild(),
                    decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),color: Colors.black)
                  ),
              SizedBox(
                width: 10,
              ),
              Container(
              
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        width: 280,
                        child: Expanded(
                          child: Text(
                              'Ablaufdatum: $productExpiryDate, heute ist der letze Tag bevor dein ${widget.product.productName} abläuft !',
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ),
                      )
                    ]),
              ),
            ]));
      }
       else{
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProductEditing(
                      product: widget.product,
                    );
                  },
                ),
              );
            },
            child: Row(children: [
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: categoryBild(),
                    decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),color: Colors.black)
                  ),
              SizedBox(
                width: 10,
              ),
              Container(
              
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(children: [
                        Text(
                            'Ablaufdatum: $productExpiryDate, noch $remainingDays Tag/e',
                            style: TextStyle(
                              fontSize: 10,
                            )),
                      ])
                    ]),
              ),
            ]));
      }
    }

 

    nochVerwendbar() {
  if (remainingDays <= widget.product.notificationDays && remainingDays > 0) {
        NotificationService().showNotification(
            title: 'Läuft app',
            subtitle:
                'Dein ${widget.product.productName} läuft am $productExpiryDate ab du hast noch $remainingDays Tag/e vergiss es nicht zu verbrauchen');
      }
    }

    abgelaufen(){
  if(remainingDays <0) {
         NotificationService().showNotification(
            title: 'Läuft app',
            subtitle:
                'Dein ${widget.product.productName} ist seit ${remainingDays.abs()} Tag/en abgelaufen BITTE ENTSORGEN!');
      }
    }

     

   setState(() {
   nochVerwendbar();
   abgelaufen();
   categoryBild();
    });

   

    return Column(
      children: [
        ListTile(
          title: Column(
            children: [
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Colors.black))),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.product.category,
                    style: TextStyle(fontFamily: 'LindenHill', fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Löschen',style: 
                        TextStyle(color: Colors.white,fontWeight: FontWeight.bold)
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    deleteProductFromFirebase();
                  },
                  
                  child: Expanded(child: abgelaufenProductName()))
            ],
          ),
        ) ,
      ],
    );
  }
}
