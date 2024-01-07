import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quantum/components/history_tile.dart';
import 'package:quantum/components/shortcuts.dart';
import 'package:quantum/pages/test.dart';

class Prompt extends StatefulWidget {
  const Prompt({super.key});

  @override
  State<Prompt> createState() => _PromptState();
}

class _PromptState extends State<Prompt> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                      //? message

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Quantum PromptS",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "23 Jan 2023",
                            style: TextStyle(
                              color: Colors.blue[200],
                            ),
                          ),
                        ],
                      ),

                      //? notification

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Test()));
                          },
                        ),
                      ),
                    ]),
              ),
            );
          }),

          //! main content
          OverlayEntry(builder: (context) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: DraggableScrollableSheet(
                initialChildSize: 0.95,
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
                          child:
                              ListView(controller: controller, children: const [
                            HistoryTile(
                                title: "Act as a JavaScript Console",
                                icon: Icons.pending_actions,
                                subtitle: "23, jan 2023"),
                            SizedBox(height: 8),
                            HistoryTile(
                                title: "I want you to act as an advertiser....",
                                icon: Icons.pending_actions,
                                subtitle: "23, jan 2023"),
                          ]),
                        ),
                      ));
                },
              ),
            ));
          }),
        ],
      ),
    );
  }
}
