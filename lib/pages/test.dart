import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum/api/jemini.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    RxString result = "".obs;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: Padding(
          padding: EdgeInsets.all(28.0),
          child: Column(
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Enter your text",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              //? Generate button
              ElevatedButton(
                onPressed: () async {
                  result.value =
                      await GeminiApi.getGeminiData(textController.text);
                },
                child: Text("Generate"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              //? Result

              Obx(
                () => Text(
                  result.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
