// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Indicates whether the progress is in progress or not
//   bool _inProgress = false;
//   // Represents the progress value of the LinearProgressIndicator
//   double _progressValue = 0.0;

//   // Asynchronous method to update the progress over time
//   Future<void> _updateProgress() async {
//     for (var i = 0; i < 30; i++) {
//       // Simulates a short delay to update the progress
//       await Future.delayed(Duration(milliseconds: 100));
//       // Sets the progress value based on the loop iteration
//       setState(() {
//         _progressValue = (i + 1) / 30;
//       });
//     }
//     // Resets the in-progress state after completion
//     setState(() {
//       _inProgress = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Async Progress Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Button to initiate the asynchronous progress
//             ElevatedButton(
//               onPressed: () {
//                 if (!_inProgress) {
//                   // Initiates the progress and sets initial values
//                   setState(() {
//                     _inProgress = true;
//                     _progressValue = 0.0;
//                   });
//                   _updateProgress();
//                 }
//               },
//               child: Text('Start'),
//             ),
//             SizedBox(height: 20),
//             // Container holding the LinearProgressIndicator and progress text
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 // Adds a border to the container
//                 border: Border.all(),
//               ),
//               child: Stack(
//                 children: <Widget>[
//                   // LinearProgressIndicator to visualize progress
//                   LinearProgressIndicator(value: _progressValue),
//                   // Text displaying the current progress percentage
//                   Center(child: Text('${(_progressValue * 100).toStringAsFixed(0)}%')),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _displayText = '';

  Future<int> _rollDice() async {
    await Future.delayed(Duration(seconds: 2));
    var random = Random();
    var diceResult = random.nextInt(6) + 1;
    return diceResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Roller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayText = 'Würfel wird geworfen...';
                });
                _rollDice().then((value) {
                  setState(() {
                    _displayText = 'Ergebnis: $value';
                  });
                }).catchError((error) {
                  setState(() {
                    _displayText = 'Fehler: $error';
                  });
                });
              },
              child: Text('Würfeln'),
            ),
            SizedBox(height: 20),
            Text(_displayText),
          ],
        ),
      ),
    );
  }
}