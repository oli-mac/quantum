import 'package:flutter/material.dart';

class ShortCuts extends StatelessWidget {
  final String image;
  const ShortCuts({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Image.asset(image, width: 35, height: 35),
      ),
    );
  }
}
