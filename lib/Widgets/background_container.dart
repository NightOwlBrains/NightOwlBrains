import 'package:catch_the_monkey/Utils/images.dart';
import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final String image;
  BackgroundContainer({required this.child, this.image = Images.background});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
      ),
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}
