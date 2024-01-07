import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShortCuts extends StatelessWidget {
  final String image;
  final Function? onTap;
  const ShortCuts({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: onTap as void Function()?,
        child: Center(
          child: Image.asset(image, width: 35, height: 35),
        ),
      ),
    );
  }
}
