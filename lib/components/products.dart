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
      'oldPrice': 153,
      'newPrice': 87,
    },
    {
      'name': 'Red dress',
      'picture': 'assets/products/dress1.jpeg',
      'oldPrice': 174,
      'newPrice': 99,
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
          );
        });
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
                  );
                },
              ),
            );
          },
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  '\$$prodPrice',
                  style: TextStyle(
                    color: Colors.red[900],
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '$prodOldPrice',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
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
