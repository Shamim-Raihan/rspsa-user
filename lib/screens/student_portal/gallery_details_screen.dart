import 'package:flutter/material.dart';

class GalleryDetailScreen extends StatelessWidget {
  final String imagePath;

  final int index;
  GalleryDetailScreen({
    required this.imagePath,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo$index',
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
