import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productsCartList = [
    {
      'name': 'Blazer',
      'picture': 'assets/products/blazer1.jpeg',
      'newPrice': 87.0,
      'size': 'M',
      'color': 'Red',
      'quantity': 1,
      'brand': 'Puma',
      'condition': 'Excellent',
    },
    {
      'name': 'Pants',
      'picture': 'assets/products/pants1.jpg',
      'newPrice': 63.70,
      'brand': 'Wasap',
      'condition': 'New',
      'size': 'L',
      'color': 'Blue',
      'quantity': 2,
    },
  ];

  void addQuantity(int quantity) {
    int _quantity;
    _quantity = quantity + 1;
  }

  void delQuantity(int quantity) {
    int _quantity;
    _quantity = quantity - 1;
    if (quantity == 0) {
      _quantity = 0;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productsCartList.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(
            condition: productsCartList[index]['condition'],
            brand: productsCartList[index]['brand'],
            quantity: productsCartList[index]['quantity'],
            prodPrice: productsCartList[index]['newPrice'],
            productName: productsCartList[index]['name'],
            size: productsCartList[index]['size'],
            productPicture: productsCartList[index]['picture'],
            color: productsCartList[index]['color'],
            add: addQuantity(productsCartList[index]['quantity']),
          );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final String productName;
  final String productPicture;
  final double prodPrice;
  final String brand;
  final String size;
  final int quantity;
  final String condition;
  final String color;
  Function add;
  Function del;

  SingleCartProduct({
    this.condition,
    this.brand,
    this.prodPrice,
    this.productName,
    this.productPicture,
    this.size,
    this.quantity,
    this.color,
    this.add,
    this.del,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          productPicture,
          width: 40,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          productName,
        ),
        subtitle: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Brand: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(brand),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Size: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(size),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Color: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(color),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Qty.: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_up),
                            onPressed: () {
                              return add(quantity);
                            },
                          ),
                          Text(
                            quantity.toString(),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              return del(quantity);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Price: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "\$" + prodPrice.toString(),
                                    style: TextStyle(
                                      color: Colors.red[900],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
