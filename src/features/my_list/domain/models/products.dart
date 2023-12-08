

import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
   String category;
  String productName;
Timestamp expiryDate;
  int notificationDays;
  String ownerId;
  final String productId;
  // String productImage;
  
  

  Product({required this.category, required this.productName,required this.expiryDate, required this.notificationDays, required this.ownerId,required this.productId});

 Map<String,dynamic> JsonFromProduct(){
    return  {
        'category': category,
         'name': productName,
        'ablaufdatum': expiryDate,
        'benachrichtigungstage': notificationDays,
         'ownerId': ownerId,
         'productId': productId,
        // 'produktbild': productImage,
      };
  }

  factory Product.fromJson(Map<String,dynamic> json,String productId,) => 
    Product(
      category: json["category"],
     productName: json["name"],
      expiryDate:
       json["ablaufdatum"], 
      notificationDays: json["benachrichtigungstage"],
    ownerId: json["ownerId"],
        productId: productId,
      //  productImage: json['produktbild'],
    );
}