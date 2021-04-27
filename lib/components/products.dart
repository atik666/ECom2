import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List products = [
    {
      'name': 'Blazer',
      'picture': 'assets/pproducts/blazer1.jpeg',
      'oldPrice': 153,
      'newPrice': 87,
    },
    {
      'name': 'Red dress',
      'picture': 'assets/pproducts/dress1.jpeg',
      'oldPrice': 174,
      'newPrice': 99,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SingleProduct extends StatelessWidget {
  final String productName;
  final String productPicture;
  final int prodOldPrice;
  final int prodPrice;

  SingleProduct({
    this.productName,
    this.productPicture,
    this.prodOldPrice,
    this.prodPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
