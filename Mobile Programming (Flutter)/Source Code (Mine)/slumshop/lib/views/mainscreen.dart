import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SlumShop'),
      ),
      drawer: Drawer(
          child: ListView(children: [
        const UserAccountsDrawerHeader(
          accountName: Text("Jackson Chong"),
          accountEmail: Text("chongqijun@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.marinemammalcenter.org/storage/app/uploads/public/616/556/803/thumb__1270_1000_0_0_crop.jpg"),
          ),
        ),
          _createDrawerItem(
              icon: Icons.abc_outlined,
              text: 'Products',
              onTap: () {},
            ),
          _createDrawerItem(
              icon: Icons.shopping_bag,
              text: 'Products',
              onTap: () {},
            ),
          _createDrawerItem(
              icon: Icons.shopping_basket,
              text: 'Cart',
              onTap: () {},
            ),  
      ])),
    
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
