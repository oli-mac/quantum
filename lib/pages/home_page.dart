import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantum/components/history/history_tile.dart';
import 'package:quantum/components/prompts/prompts_tile.dart';
import 'package:quantum/components/shortcuts.dart';
import 'package:quantum/pages/about/about.dart';
import 'package:quantum/pages/chat/chat.dart';
import 'package:quantum/pages/prompts/prompts.dart';
import 'package:quantum/pages/test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> jsonData = [];
  List<Map<String, dynamic>> results = [];

  bool isSearching = true;

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

  void _runfilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      results = jsonData;
      isSearching = true;
    } else {
      results = jsonData
          .where(
              (prompt) => prompt['prompt'].toString().contains(enteredKeyword))
          .toList();
    }

    setState(() {
      jsonData = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[800],
                borderRadius: const BorderRadius.only(
                  // bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(children: [
                  //* Grettings and notification
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //? message

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hello",
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
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: IconButton(
                            icon: const Icon(Icons.info_outline),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const About()));
                            },
                          ),
                        ),
                      ]),

                  const SizedBox(height: 20),
                  //* search
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(35),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: TextField(
                      // controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        contentPadding: EdgeInsets.all(12),
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: (value) {
                        isSearching = false;

                        _runfilter(value);
                      },
                    ),
                  ),

                  const SizedBox(height: 25),

                  //* shortcuts

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      )
                    ],
                  ),

                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShortCuts(
                        image: "assets/chat.png",
                        onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Chat()))
                        },
                      ),
                      ShortCuts(
                        image: "assets/notes.png",
                        onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Prompt()))
                        },
                      ),
                      ShortCuts(
                          image: "assets/gallery.png",
                          onTap: () => {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => PromptsDetail()))
                              }),
                      const ShortCuts(
                        image: "assets/profile.png",
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  //* history
                ]),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  // topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: Center(
                  child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "history",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: isSearching
                        ? ListView(
                            children: const [
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                              HistoryTile(
                                  title:
                                      "I want you to act as an advertiser....",
                                  icon: Icons.ac_unit,
                                  subtitle: "23, jan 2023"),
                            ],
                          )
                        : ListView.builder(
                            // controller: controller,
                            itemCount: results.length,
                            itemBuilder: (context, index) {
                              return PromptsTile(
                                title: jsonData[index]['act'].toString(),
                                icon: Icons.content_paste_go_rounded,
                                subtitle: jsonData[index]['prompt'].toString(),
                              );
                            },
                          ),
                  ),
                ],
              )),
            ))
          ],
        ),
      ),
    );
  }
}
