// ignore: file_names
import 'package:flutter/material.dart';
import 'package:my_flut/LearnFlutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const LearnFlutterScreen(),
              
            ),
          );
        },
        child: Text("learn flutter"),
      ),
    );
  }
}
