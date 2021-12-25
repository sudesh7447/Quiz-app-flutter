import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Quizbrain quizbrain = Quizbrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeep = [];
  int ansj = 0;
  void check(bool x) {
    bool corans = quizbrain.qe[qn].questionAnswer;
    setState(() {
      if (qn < quizbrain.qe.length - 1) {
        qn = qn + 1;

        if (corans == x) {
          ansj++;
          scorekeep.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorekeep.add(Icon(
            Icons.cancel,
            color: Colors.red,
          ));
        }
      } else {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Finished",
          desc: "You Scored $ansj points.",
          buttons: [
            DialogButton(
              child: Text(
                "Attempt again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 150,
            )
          ],
        ).show();
        ansj = 0;
        qn = 0;
        scorekeep.clear();
      }
    });
  }

  int qn = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.qe[qn].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                check(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                check(false);
              },
            ),
          ),
        ),
        //  TODO : add a row as scorekeeper
        Row(children: scorekeep)
      ],
    );
  }
}
