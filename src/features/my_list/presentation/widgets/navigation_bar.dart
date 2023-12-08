import 'package:flutter/material.dart';
import 'package:lauft_app/src/features/profil/presentation/profil.dart';
import 'package:lauft_app/src/features/my_list/presentation/pages/add_product.dart';
import 'package:lauft_app/src/features/my_list/presentation/pages/my_list.dart';

class NavigationTabBar extends StatefulWidget {
  
  
   NavigationTabBar({super.key});

  @override
  State<NavigationTabBar> createState() => _NavigationTabBarState();
}

class _NavigationTabBarState extends State<NavigationTabBar> {
  int _currentIndex = 2;
  List<Widget> screen = [
     Profil(),
    const AddProduct(),
    const MyList(),
  ];
  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screen[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4_outlined),
              label: 'Profil',
              backgroundColor: Color.fromRGBO(249, 249, 249, 94),
            ),
           const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined),
              label: 'Hinzufügen',
              backgroundColor: Color.fromRGBO(249, 249, 249, 94),
            ), // BottomNavigationBarItem BottomNavigationBarItem( icon: Icon (Icons. school), label: 'School'
            const BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: "Meine Liste",
              backgroundColor: Color.fromRGBO(249, 249, 249, 94),
            ),
          ],

          // BottomNavigationBarItem ],
          // <BottomNavigationBarItem>[]
          currentIndex: _currentIndex,
          onTap: setIndex,
          selectedItemColor:  Color.fromRGBO(255, 201, 101, 0.612)),
        );
  }
}