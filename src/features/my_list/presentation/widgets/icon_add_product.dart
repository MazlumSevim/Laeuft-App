

import 'package:flutter/material.dart';


Widget iconAddProduct(){
return Column(
children: [
  SizedBox(height: 250,),
Center(
  child:   
   Icon( Icons.add_circle_sharp ,color: Colors.grey[300],size: 100,)),
 Text("Produkt Hinzufügen",style: TextStyle(color: Colors.grey,fontSize: 20),)
],  
);
}