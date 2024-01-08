import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:quantum/api/jemini.dart';
import 'package:quantum/pages/test.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _messageController = TextEditingController();
  int _groupIndex = 0; // New variable to keep track of conversation thread

  Future<void> _sendMessage(String message) async {
    // User message
    setState(() {
      messages.add({
        'text': message,
        'isUser': true,
        'group': _groupIndex.toString(),
      });
    });

    // Increment the conversation thread index
    _groupIndex++;

    // Gemini AI response
    try {
      String geminiResponse = await GeminiApi.getGeminiData(message);

      print(
          "------------------------------$geminiResponse-----------------------------");

      --_groupIndex;

      setState(() {
        messages.add({
          'text': geminiResponse,
          'isUser': false,
          'group': _groupIndex.toString(),
        });
      });
    } catch (e) {
      print("Error making Gemini API request: $e");
      setState(() {
        messages.add({
          'text': 'Error communicating with Gemini AI.',
          'isUser': false,
          'group': _groupIndex.toString(),
        });
      });
    }
  }

  void _handleSendButtonPressed() {
    // Get the message directly from the text field
    String message = _messageController.text.trim();

    // Check if the message is not empty before sending
    if (message.isNotEmpty) {
      _sendMessage(message);
      print(
          "------------------------------$messages-----------------------------");
      _messageController.clear();
    }
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
          // ... (existing code)
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Quantum Chat",
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
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        icon: const Icon(Icons.done_all),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Test()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Main content
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: GroupedListView<dynamic, String>(
                                  elements: messages,
                                  groupBy: (element) => element['group'],
                                  groupComparator: (value1, value2) =>
                                      value2.compareTo(value1),
                                  itemComparator: (item1, item2) {
                                    if (item1['timestamp'] == null &&
                                        item2['timestamp'] == null) {
                                      return 0;
                                    } else if (item1['timestamp'] == null) {
                                      return 1;
                                    } else if (item2['timestamp'] == null) {
                                      return -1;
                                    } else {
                                      return item1['timestamp']
                                          .compareTo(item2['timestamp']);
                                    }
                                  },
                                  order: GroupedListOrder.ASC,
                                  useStickyGroupSeparators: true,
                                  groupSeparatorBuilder: (String value) {
                                    return const Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Text(
                                        "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                  itemBuilder: (context, dynamic element) {
                                    return Align(
                                      alignment: element['isUser']
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                              bottomLeft: element['isUser']
                                                  ? Radius.circular(30)
                                                  : Radius.circular(0),
                                              bottomRight: element['isUser']
                                                  ? Radius.circular(0)
                                                  : Radius.circular(30)),
                                        ),
                                        borderOnForeground: true,
                                        color: element['isUser']
                                            ? Colors.blue[600]
                                            : Colors.grey[300],
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: MarkdownViewer(
                                            element['text'],
                                            selectable: true,
                                            enableTaskList: true,
                                            enableSuperscript: false,
                                            enableSubscript: false,
                                            enableFootnote: false,
                                            enableImageSize: false,
                                            enableKbd: false,
                                            copyIconBuilder: (context) => Icon(
                                              Icons.copy,
                                              color: context
                                                  ? Colors.green
                                                  : Colors.grey,
                                            ),
                                          ),
                                          // child: Text(
                                          //   element['text'],
                                          //   style: const TextStyle(
                                          //     color: Colors.white,
                                          //   ),
                                          // )
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        child: TextField(
                                          controller: _messageController,
                                          decoration: const InputDecoration(
                                            hintText:
                                                "Ask your question here...",
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.pending),
                                            contentPadding: EdgeInsets.all(12),
                                          ),
                                          onSubmitted: _sendMessage,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[600],
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: IconButton(
                                        icon: const Icon(Icons.send),
                                        color: Colors.white,
                                        onPressed: _handleSendButtonPressed,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
