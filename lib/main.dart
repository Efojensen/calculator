import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

  String userQuestion = "";
  String userAnswer = "";

class _MyAppState extends State<MyApp> {
  final List<String> texts = [
    "CLS", "DEL", "%", "/",
    "9", "8", "7", "x",
    "6", "5", "4", "-",
    "3", "2", "1", "+",
    "0", ".", "ANS", "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(userQuestion, style: const TextStyle(fontSize: 20))
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(userAnswer, style: const TextStyle(fontSize: 20))
                )
              ],
            )
            ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey,
              child: GridView.builder(
                itemCount: texts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index){
                  if (index == 0) {
                    return MyButton(
                    onTapped: () {
                      setState(() {
                        userQuestion = "";
                      });
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    buttonText: texts[index]
                  );
                  } else if(index == 1) {
                    return MyButton(
                    onTapped: () {
                      setState(() {
                        userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonText: texts[index]
                  );
                  } else if(index == texts.length - 1) {
                    return MyButton(
                    onTapped: () {
                      setState(() {
                        pressedEqual();
                      });
                    },
                    color: isOperation(texts[index]) ? Colors.deepPurple : Colors.white,
                    textColor: isOperation(texts[index]) ? Colors.white : Colors.black,
                    buttonText: texts[index]
                  );
                  }
                  else{
                    return MyButton(
                    onTapped:() {
                      setState(() {
                        userQuestion += texts[index];
                      });
                    },
                    color: isOperation(texts[index]) ? Colors.deepPurple : Colors.white,
                    textColor: isOperation(texts[index]) ? Colors.white : Colors.black,
                    buttonText: texts[index]
                  );
                  }
                }
                ),
            )
            )
        ]
      )
    );
  }
}

bool isOperation(String dunno){
  if (dunno == "+" || dunno == "-" || dunno =="x" || dunno =="/" || dunno == "=") {
    return true;
  }
  return false;
}

void pressedEqual(){
  String finalQuestion = userQuestion;
  finalQuestion = finalQuestion.replaceAll('x', '*');

  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);

  userAnswer = eval.toString();
}