import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products
          .map(
            (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                          'assets/Spiderman-Blue-Background-HD-Wallpaper.png'),
                      Text(element),
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}
