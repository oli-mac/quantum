import 'dart:convert';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:quantum/components/history_tile.dart';
import 'package:quantum/components/prompt_detail_tile.dart';
import 'package:quantum/components/shortcuts.dart';
import 'package:quantum/pages/test.dart';
import 'dart:io';

class AddPrompts extends StatelessWidget {
  const AddPrompts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController textController = TextEditingController();

    Future<void> addPrompt() async {
      // Get the path to the app's documents directory
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;

      // Use the path to create a reference to the JSON file
      File file = File('$path/prompts.json');

      // Check if the file exists
      if (!await file.exists()) {
        // If the file does not exist, create it
        await file.create(recursive: true);
        await file.writeAsString('[]');
      }

      // Read existing data from the JSON file
      String existingData = await file.readAsString();
      List<dynamic> prompts = jsonDecode(existingData);

      // Append the new prompt to the list
      prompts.add({
        'act': titleController.text,
        'prompt': textController.text,
      });

      // Write the updated data back to the JSON file
      try {
        await file.writeAsString(jsonEncode(prompts));
        print(
            '--------------------------------------- writing file: $prompts----------');

        // Clear the text fields
        titleController.clear();
        textController.clear();
      } catch (e) {
        print(
            '-----------Error writing file: $e-------------------------------------------');
      }
    }

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
            return Stack(children: [
              Positioned(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Prompts",
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
                    ],
                  ),
                ),
              ),
            ]);
          }),

          //! main content
          OverlayEntry(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: DraggableScrollableSheet(
                initialChildSize: 0.45,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                builder: (context, controller) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Positioned(
                          bottom: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  hintText: "Enter Prompt Title",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: textController,
                                decoration: InputDecoration(
                                  hintText: "Enter Prompt text",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () async {
                                  await addPrompt();
                                },
                                child: Text("Add Prompt"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
