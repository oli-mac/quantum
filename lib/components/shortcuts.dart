import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/pages/chat.dart';

class ShortCuts extends StatelessWidget {
  final String image;
  final Function? onTap;
  const ShortCuts({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Chat()))
        },
        child: Center(
          child: Image.asset(image, width: 35, height: 35),
        ),
      ),
    );
  }
}
