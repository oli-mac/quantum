import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantum/pages/prompts/prompts_detail.dart';

class PromptsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  const PromptsTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PromptsDetail(
                  title: title,
                  subtitle: subtitle,
                )))
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
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: subtitle));
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            title.length > 25
                                ? '${title.substring(0, 25)}...'
                                : title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 5),
                        Text(
                          subtitle.length > 30
                              ? '${subtitle.substring(0, 30)}...'
                              : subtitle,
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
