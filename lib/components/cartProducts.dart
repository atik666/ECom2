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
          );
        });
  }
}

class SingleCartProduct extends StatefulWidget {
  final String productName;
  final String productPicture;
  double prodPrice;
  final String brand;
  final String size;
  int quantity;
  final String condition;
  final String color;

  SingleCartProduct({
    this.condition,
    this.brand,
    this.prodPrice,
    this.productName,
    this.productPicture,
    this.size,
    this.quantity,
    this.color,
  });

  @override
  _SingleCartProductState createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          widget.productPicture,
          width: 40,
          height: 60,
          fit: BoxFit.cover,
        ),
        title: Text(
          widget.productName,
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
                          Text(widget.brand),
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
                          Text(widget.size),
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
                          Text(widget.color),
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
                              setState(() {
                                return addQuantity();
                              });
                            },
                          ),
                          Text(
                            widget.quantity.toString(),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              setState(() {
                                return delQuantity();
                              });
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
                                    "\$" +
                                        (widget.prodPrice * widget.quantity)
                                            .toStringAsFixed(2),
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

  addQuantity() {
    widget.quantity++;
    //return quantity;
    return (widget.quantity);
  }

  delQuantity() {
    widget.quantity = widget.quantity - 1;
    if (widget.quantity < 1) {
      widget.quantity = 1;
      return widget.quantity;
    }
    return (widget.quantity);
  }
}
