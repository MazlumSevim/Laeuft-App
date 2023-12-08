

import 'package:flutter/material.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/categorie.dart';
import 'package:lauft_app/src/features/settings/presentation/settings.dart';


void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => AddProduct()));
}

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
                "Kategorie auswählen",
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
          
        ),
         
      ),
      body: Center(
        child: buildCategory(context),
      ),

     
    );
   
  }
}
