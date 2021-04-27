import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Category(
            imageLocation: 'assets/cats/tshirt.png',
            imageCaption: 'Shirt',
          ),
          Category(
            imageLocation: 'assets/cats/accessories.png',
            imageCaption: 'Accessories',
          ),
          Category(
            imageLocation: 'assets/cats/dress.png',
            imageCaption: 'Dress',
          ),
          Category(
            imageLocation: 'assets/cats/formal.png',
            imageCaption: 'Formal',
          ),
          Category(
            imageLocation: 'assets/cats/informal.png',
            imageCaption: 'Informal',
          ),
          Category(
            imageLocation: 'assets/cats/jeans.png',
            imageCaption: 'Jeans',
          ),
          Category(
            imageLocation: 'assets/cats/shoe.png',
            imageCaption: 'Shoes',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  Category({this.imageLocation, this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100,
          child: ListTile(
            title: Image.asset(
              imageLocation,
              width: 100,
              height: 80,
            ),
            subtitle: Text(
              imageCaption,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
