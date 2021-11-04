import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const home(),
    );
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  FlutterTts flutterTts = FlutterTts();
  TextEditingController controller = TextEditingController();
  String _dropDownValue = 'en-US';
  speech(String input) async {
    await flutterTts.setLanguage(_dropDownValue);
    await flutterTts.speak(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Text To Speech"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton(
                    hint: Text(
                      _dropDownValue,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    iconSize: 30.0,
                    items: ['en-US', 'fr-FR', 'es-ES'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          _dropDownValue = val.toString();
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: 6,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Input',
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            speech(controller.text);
                          });
                        },
                        icon: Icon(Icons.volume_up),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            controller.clear();
                          });
                        },
                        icon: Icon(Icons.clear_sharp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
