import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String image;
  final String name;
  final int oldPrice;
  final int newPrice;

  ProductDetails({
    this.image,
    this.name,
    this.oldPrice,
    this.newPrice,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
