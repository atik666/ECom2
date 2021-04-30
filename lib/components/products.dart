import 'package:flutter/material.dart';
import '../pages/productDetails.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
        itemCount: products.length,
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

class SingleProduct extends StatelessWidget {
  final String productName;
  final String productPicture;
  final double prodOldPrice;
  final double prodPrice;
  final String brand;
  final String condition;

  SingleProduct({
    this.productName,
    this.productPicture,
    this.prodOldPrice,
    this.prodPrice,
    this.brand,
    this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: productName,
        child: InkWell(
          onTap: () {
            return Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductDetails(
                    image: productPicture,
                    name: productName,
                    oldPrice: prodOldPrice,
                    newPrice: prodPrice,
                    brand: brand,
                    condition: condition,
                  );
                },
              ),
            );
          },
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    productName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '$prodOldPrice',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    '\$$prodPrice',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    productPicture,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
