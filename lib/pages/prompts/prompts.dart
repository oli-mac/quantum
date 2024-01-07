import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quantum/components/prompts_tile.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quantum/pages/prompts/add_prompts.dart';

class Prompt extends StatefulWidget {
  const Prompt({super.key});

  @override
  State<Prompt> createState() => _PromptState();
}

class _PromptState extends State<Prompt> {
  List<Map<String, dynamic>> jsonData = [];

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  Future<void> loadJSON() async {
    final String raw = await rootBundle.loadString('data/prompts.json');
    List<dynamic> decodedData = json.decode(raw);

    List<Map<String, dynamic>> jsonDataList = [];
    for (Map<String, dynamic> entry in decodedData) {
      jsonDataList.add(entry);
    }

    setState(() {
      jsonData = jsonDataList;
    });
  }

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
                        padding: const EdgeInsets.all(8),
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
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddPrompts()));
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
                          child: ListView.builder(
                            controller: controller,
                            itemCount: jsonData.length,
                            itemBuilder: (context, index) {
                              return PromptsTile(
                                title: jsonData[index]['act'].toString(),
                                icon: Icons.content_paste_go_rounded,
                                subtitle: jsonData[index]['prompt'].toString(),
                              );
                            },
                          ),
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
