import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import './components/horizontalListView.dart';
import './components/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecom',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      height: 200,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/others/c1.jpg'),
          AssetImage('assets/others/m1.jpeg'),
          AssetImage('assets/others/m2.jpg'),
          AssetImage('assets/others/w1.jpeg'),
          AssetImage('assets/others/w3.jpeg'),
          AssetImage('assets/others/w4.jpeg'),
        ],
        autoplay: false,
        dotSize: 4,
        indicatorBgPadding: 4,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red[900],
        title: Text('ShopApp'),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red[900],
              ),
              accountName: Text('User'),
              accountEmail: Text('Email'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home, color: Colors.brown),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person, color: Colors.indigo),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.deepPurple),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.category, color: Colors.green),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favorites'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.pink,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          imageCarousel,
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            // Horizontal ListView
          ),
          HorizontalList(),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Most recents',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 320,
            child: Products(),
          )
        ],
      ),
    );
  }
}
