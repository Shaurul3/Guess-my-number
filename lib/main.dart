import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  late int randomNumber;
  String resultText = '';
  bool showResetButton = false;
  bool showGuessButton = true;

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    final Random random = Random();
    setState(() {
      randomNumber = random.nextInt(100) + 1;
      //print('Generated number: $randomNumber');
      resultText = '';
      showResetButton = false;
      controller.text = '';
      showGuessButton = true;
    });
  }

  void checkNumber() {
    final int? enteredNumber = int.tryParse(controller.text);
    if (enteredNumber != null) {
      if (enteredNumber > randomNumber) {
        setState(() {
          resultText = 'You tried ${controller.text} \nTry lower';
        });
      } else if (enteredNumber < randomNumber) {
        setState(() {
          resultText = 'You tried ${controller.text} \nTry higher';
        });
      } else {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Ai ghicit!'),
              content: const Text('Felicitări, ai ghicit numărul!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    generateRandomNumber();
                  },
                  child: const Text('Try Again'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        setState(() {
          showResetButton = true;
          showGuessButton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Scaffold scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Guess my number'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          const Text(
            "I'm thinking of a number between 1 and 100.",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "It's your turn to guess my number!",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              resultText,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(

                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Try a number!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '',
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (showGuessButton)
                        ElevatedButton(
                          onPressed: () {
                            checkNumber();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            'Guess',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      if (showResetButton)
                        ElevatedButton(
                          onPressed: generateRandomNumber,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return scaffold;
  }
}
