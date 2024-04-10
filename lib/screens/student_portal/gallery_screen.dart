import 'package:flutter/material.dart';
import 'package:rspsa_user/screens/student_portal/gallery_details_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

class ImageDetails {
  final String imagePath;

  ImageDetails({
    required this.imagePath,
  });
}

List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'images/7.jpg',
  ),
  ImageDetails(
    imagePath: 'images/8.jpg',
  ),
  ImageDetails(
    imagePath: 'images/9.jpg',
  ),
  ImageDetails(
    imagePath: 'images/logo.png',
  ),
  ImageDetails(
    imagePath: 'images/insta.png',
  ),
  ImageDetails(
    imagePath: 'images/facbookicon.png',
  ),
];

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryDetailScreen(
                              imagePath: _images[index].imagePath,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _images.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
