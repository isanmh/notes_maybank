import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class AiImageGenerator extends StatefulWidget {
  const AiImageGenerator({super.key});

  @override
  State<AiImageGenerator> createState() => _AiImageGeneratorState();
}

class _AiImageGeneratorState extends State<AiImageGenerator> {
  /// query untuk inputan text
  final TextEditingController _queryController = TextEditingController();

  /// pengaturan untuk stability.ai
  final StabilityAI _ai = StabilityAI();

  /// api key punya kita
  final String apiKey = 'sk-TU1RBq4lpAPMfsUVMKHwIP55hXwiLJIuep7k5VZuLxz4WoOA';

  /// style yang kita mau
  final ImageAIStyle imageAIStyle = ImageAIStyle.cyberPunk;

  /// The boolean value to run the function.
  bool run = false;

  /// generate image function
  Future<Uint8List> _generate(String query) async {
    Uint8List image = await _ai.generateImage(
      apiKey: apiKey,
      imageAIStyle: imageAIStyle,
      prompt: query,
    );
    return image;
  }

  @override
  void dispose() {
    // ketika widget hilang
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Ai Image Generator",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _queryController,
                  decoration: InputDecoration(
                    hintText: 'Enter query text...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child:
                      run
                          ? FutureBuilder<Uint8List>(
                            future: _generate(_queryController.text),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: const CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(snapshot.data!),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                          : const Center(
                            child: Text(
                              'Enter Text and Click the button to generate',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// Get the user input from the [_queryController].
          String query = _queryController.text;
          if (query.isNotEmpty) {
            /// If the user input is not empty, set [run] to true to generate the image.
            setState(() {
              run = true;
            });
          } else {
            /// If the user input is empty, print an error message.
            if (kDebugMode) {
              print('Query is empty !!');
            }
          }
        },
        tooltip: 'Generate',
        child: const Icon(Icons.gesture),
      ),
    );
  }
}
