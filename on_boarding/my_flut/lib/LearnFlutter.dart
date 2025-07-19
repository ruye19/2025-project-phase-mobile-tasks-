import 'package:flutter/material.dart';

class LearnFlutterScreen extends StatefulWidget {
  const LearnFlutterScreen({super.key});

  @override
  State<LearnFlutterScreen> createState() => _LearnFlutterScreenState();
}

class _LearnFlutterScreenState extends State<LearnFlutterScreen> {
  bool _switchValue = true;
  bool? _checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("learn flutter ")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "images/ruth.jpg",
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10),
              color: const Color.fromARGB(255, 42, 76, 2),
              width: double.infinity,
              child: Center(
                child: Text(
                  "this is the text widget",
                  style: TextStyle(color: Colors.white)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _switchValue ? Color.fromARGB(255, 42, 76, 2) : Colors.blueGrey
              ),
              onPressed: (){
              debugPrint("elevator button");
            }, 
            child: Text("elevator button ")
            ),
        
            ElevatedButton.icon(onPressed: (){
              debugPrint("elevator button with icon");  
            },
            icon: const Icon(Icons.add),    
            label: const Text("elevator button with icon")
            ),
        
            OutlinedButton(onPressed: (){
              debugPrint("outlined button");
            }, 
            child: Text("elevator button ") 
            ),
        
            TextButton(onPressed: (){
              debugPrint("textbutton  button");
            }, 
            child: Text("textbutton button ")
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: (){
                debugPrint("double tap detected");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Icon(Icons.local_fire_department, color: Colors.red),
                const Text("fire icon"),
                Icon(Icons.local_fire_department, color: Colors.red),
              ],
              
              ),
            ),
            Switch(
              value: _switchValue,
              onChanged: (bool newvalue) {
                setState(() {
                  _switchValue = newvalue;
                });

              }),
              Checkbox(value: _checkValue, onChanged: (bool? newvalue) {
                setState(() {
                  _checkValue = newvalue ?? true;
                });
              }),
          ],
        ),
      ),
    );
  }
}
