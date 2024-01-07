import 'package:flutter/material.dart';
import 'package:quantum/pages/prompts/prompts_detail.dart';

class PromptsTime extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  const PromptsTime(
      {super.key,
      required this.title,
      required this.icon,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PromptsDetail()))
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        icon,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          softWrap: true,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.more_horiz)
              ],
            )),
      ),
    );
  }
}
