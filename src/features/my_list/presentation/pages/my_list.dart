import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lauft_app/src/features/my_list/presentation/widgets/notification.dart';
import '../../../settings/presentation/settings.dart';
import '../../domain/models/products.dart';
import '../widgets/build_list_item.dart';
import '../widgets/icon_add_product.dart';

class MyList extends StatefulWidget {
  const MyList({
    super.key,
  });

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  Stream<List<Product>> fetchProductStreamFromFirebase() {
    Stream<QuerySnapshot> productCollectionStream =
        FirebaseFirestore.instance.collection("products").snapshots();

    Stream<List<Product>> products =
        productCollectionStream.map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((doc) =>
              Product.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });

    print(products);

    return products;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
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
                  "Meine Liste",
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
        body: Column(
            children: [
              StreamBuilder(
                stream: fetchProductStreamFromFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> productList = snapshot.data ?? [];
                    return Expanded(
                      child: ListView(
                        children: productList
                            .map((product) => ListItem(
                                  product: product,
                                ))
                            .toList(),
                      ),
                    );
                  } else {
                    return  Center( child: iconAddProduct());
                  }
                },
              ),
            
            ],
          ),
        );
  }
}