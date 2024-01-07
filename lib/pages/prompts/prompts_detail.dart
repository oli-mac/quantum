import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quantum/components/history_tile.dart';
import 'package:quantum/components/prompt_detail_tile.dart';
import 'package:quantum/components/shortcuts.dart';
import 'package:quantum/pages/test.dart';

class PromptsDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const PromptsDetail({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue,
      body: Overlay(
        initialEntries: [
          //! back ground image
          OverlayEntry(builder: (context) {
            return Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: const EdgeInsets.all(14),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      //? message

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "23 Jan 2023",
                              style: TextStyle(
                                color: Colors.blue[200],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //? notification

                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue[600],
                      //     borderRadius: BorderRadius.circular(50),
                      //   ),
                      //   padding: const EdgeInsets.all(16),
                      //   child: IconButton(
                      //     icon: const Icon(Icons.add),
                      //     color: Colors.white,
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (context) => const Test()));
                      //     },
                      //   ),
                      // ),
                    ]),
              ),
            );
          }),

          //! main content
          OverlayEntry(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: DraggableScrollableSheet(
                initialChildSize: 0.85,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                builder: (context, controller) {
                  return ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: PromptsDetailTile(
                              title: title,
                              icon: Icons.pending_actions,
                              subtitle: subtitle,
                            )),
                      ));
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
