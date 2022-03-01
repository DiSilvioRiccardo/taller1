import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  int counter = 0;
  String word = "";
  int _actualWordType = 0;
  Color textColor = Colors.blue;
  Color buttonColor = Colors.blue;
  bool activeButtons = true;
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    setState(() {
      textColor = Colors.blue;
      buttonColor = Colors.blue;
    });
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      randomItem = (nouns.toList()..shuffle()).first;
    } else {
      randomItem = (adjectives.toList()..shuffle()).first;
    }

    setState(() {
      word = randomItem;
      _actualWordType = option;
    });
  }

  void _onPressed(int wordType) {
    if (wordType == _actualWordType) {
      setState(() {
        counter += 1;
      });
      setRandomWord();
    } else {
      setState(() {
        textColor = Colors.red;
        buttonColor = Colors.grey;
        activeButtons = false;
      });

      Future.delayed(Duration(seconds: 2)).then((_) {
        setState(() {
          activeButtons = true;
        });
        setRandomWord();
      });
    }
  }

  void _onReset() {
    setState(() {
      counter = 0;
    });
    setRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Words"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("$counter"),
          Text("$word", style: TextStyle(color: textColor)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => activeButtons ? _onPressed(0) : null,
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                  child: Text("Noun")),
              ElevatedButton(
                  onPressed: () => activeButtons ? _onPressed(1) : null,
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                  child: Text("Adjective"))
            ],
          ),
          ElevatedButton(onPressed: () => _onReset(), child: Text("Reset")),
        ],
      ),
    );
  }
}
