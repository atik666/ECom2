import 'package:flutter/material.dart';
import '../components/products.dart';

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  List products = [
    {
      'name': 'Blazer',
      'picture': 'assets/products/blazer1.jpeg',
      'oldPrice': 153.0,
      'newPrice': 87.0,
      'brand': 'Puma',
      'condition': 'Excellent',
    },
    {
      'name': 'Red dress',
      'picture': 'assets/products/dress1.jpeg',
      'oldPrice': 174.0,
      'newPrice': 99.0,
      'brand': 'Nike',
      'condition': 'Good',
    },
    {
      'name': 'Hills',
      'picture': 'assets/products/hills1.jpeg',
      'oldPrice': 80.50,
      'newPrice': 50.90,
      'brand': 'Addidas',
      'condition': 'New',
    },
    {
      'name': 'Skirt',
      'picture': 'assets/products/skt1.jpeg',
      'oldPrice': 94.70,
      'newPrice': 93.50,
      'brand': 'Prada',
      'condition': 'Latest',
    },
    {
      'name': 'Pants',
      'picture': 'assets/products/pants1.jpg',
      'oldPrice': 74.10,
      'newPrice': 63.70,
      'brand': 'Wasap',
      'condition': 'New',
    },
    {
      'name': 'Shoes',
      'picture': 'assets/products/shoe1.jpg',
      'oldPrice': 23.10,
      'newPrice': 19.15,
      'brand': 'Well',
      'condition': 'Old',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            productName: products[index]['name'],
            productPicture: products[index]['picture'],
            prodOldPrice: products[index]['oldPrice'],
            prodPrice: products[index]['newPrice'],
            brand: products[index]['brand'],
            condition: products[index]['condition'],
          );
        });
  }
}