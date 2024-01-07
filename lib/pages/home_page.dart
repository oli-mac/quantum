import 'package:flutter/material.dart';
import 'package:quantum/components/history_tile.dart';
import 'package:quantum/components/shortcuts.dart';
import 'package:quantum/pages/chat/chat.dart';
import 'package:quantum/pages/prompts/prompts.dart';
import 'package:quantum/pages/prompts/prompts_detail.dart';
import 'package:quantum/pages/test.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded), label: "chat"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        // BottomNavigationBarItem(icon: Icon(Icons.person_2), label: "Profile"),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: Icon(Icons.info_outline),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Test()));
                          },
                        ),
                      ),
                    ]),

                const SizedBox(height: 20),
                //* search
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Row(children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ]),
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Chat()))
                      },
                    ),
                    ShortCuts(
                      image: "assets/notes.png",
                      onTap: () => {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Prompt()))
                      },
                    ),
                    ShortCuts(
                        image: "assets/gallery.png",
                        onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PromptsDetail()))
                            }),
                    ShortCuts(
                      image: "assets/profile.png",
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                //* history
              ]),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(25),
              color: Colors.grey[200],
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
                    child: ListView(
                      children: const [
                        HistoryTile(
                            title: "I want you to act as an advertiser....",
                            icon: Icons.ac_unit,
                            subtitle: "23, jan 2023"),
                        HistoryTile(
                            title: "I want you to act as an advertiser....",
                            icon: Icons.ac_unit,
                            subtitle: "23, jan 2023"),
                      ],
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
