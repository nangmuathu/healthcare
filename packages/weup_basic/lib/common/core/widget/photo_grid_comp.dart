import 'dart:math';
import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  final int maxImages;
  final List<String> imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;

  const PhotoGrid({required this.imageUrls, required this.onImageClicked, required this.onExpandClicked, this.maxImages = 4, Key? key}) : super(key: key);

  @override
  createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  @override
  Widget build(BuildContext context) {
    final numImages = widget.imageUrls.length;
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      children: List<Widget>.generate(min(numImages, widget.maxImages), (index) {
        String imageUrl = widget.imageUrls[index];

        if (index == widget.maxImages - 1) {
          int remaining = numImages - widget.maxImages;

          if (remaining == 0) {
            return GestureDetector(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              onTap: () => widget.onImageClicked(index),
            );
          } else {
            return GestureDetector(
              onTap: () => widget.onExpandClicked(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black54,
                      child: Text(
                        '+' + remaining.toString(),
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return GestureDetector(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => widget.onImageClicked(index),
          );
        }
      }),
    );
  }
}
