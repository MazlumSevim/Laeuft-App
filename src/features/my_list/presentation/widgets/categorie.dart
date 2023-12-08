
import 'package:flutter/material.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/categorie_name.dart';
import '../pages/scan_manual_input.dart';

  @override
  Widget buildCategory(BuildContext context,) {
    return  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 2,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(categoryLebensmittel,style: TextStyle(fontFamily: 'LindenHill', fontSize: 20),),
                ),
                onTap: () {
                 
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanManualInput(categoryLebensmittel)));
                      
                }),
            InkWell(
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 2,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(categoryBeautyKosmetik,style: TextStyle(fontFamily: 'LindenHill', fontSize: 20)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanManualInput(categoryBeautyKosmetik)));
                      
                }),
            InkWell(
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 2,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(categoryGetraenke,style: TextStyle(fontFamily: 'LindenHill', fontSize: 20)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanManualInput(categoryGetraenke)));
                }),
            InkWell(
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 2,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(categoryMedikamente,style: TextStyle(fontFamily: 'LindenHill', fontSize: 20)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanManualInput(categoryMedikamente)));
                }),
            InkWell(
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(categoryTiernahrnug,style: TextStyle(fontFamily: 'LindenHill', fontSize: 20)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanManualInput(categoryTiernahrnug)));
                }),
            InkWell(
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 2,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(categoryAndere,style: TextStyle(fontFamily: 'LindenHill', fontSize: 20)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScanManualInput(categoryAndere)));
                }),
          ],
        );
  }
