import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

import 'package:confetti/confetti.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
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
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  bool _isHovered_true = false;
  bool _isHovered_false = false;

  bool? isTrue_true;
  bool? isTrue_false;

  late ConfettiController _confettiController;

  bool checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (userPickedAnswer == correctAnswer) {
        quizBrain.setCorrectNumber();
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
        if (userPickedAnswer) {
          isTrue_true = true;
        } else {
          isTrue_false = true;
        }
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            isTrue_true = null;
            isTrue_false = null;
          });
        });
      } else {
        if (userPickedAnswer) {
          isTrue_true = false;
        } else {
          isTrue_false = false;
        }
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            isTrue_true = null;
            isTrue_false = null;
          });
        });
      }
      if (quizBrain.isFinished() == true) {
        _confettiController =
            ConfettiController(duration: const Duration(seconds: 1));
        if (quizBrain.getCorrectNumber() > 5) {
          Alert(
              context: context,
              title: 'Kết thúc!',
              desc: 'Chúc mừng!\nBạn đã chiến thắng',
              closeFunction: () {
                _confettiController.stop();
                Navigator.pop(context);
              },
              buttons: [
                DialogButton(
                  onPressed: () {
                    _confettiController.stop();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ]).show().then((value) => () {
                _confettiController.stop();
                Navigator.pop(context);
              });
          _showCongratulationsDialog(context);
        } else {
          Alert(
              context: context,
              title: 'Kết thúc!',
              desc: 'Bạn chưa hoàn thành\nHãy thử lại nhé!',
              closeFunction: () {
                _confettiController.stop();
                Navigator.pop(context);
              },
              buttons: [
                DialogButton(
                    onPressed: () {
                      _confettiController.stop();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ]).show().then((value) => () {
                _confettiController.stop();
                Navigator.pop(context);
              });
          _showCongratulationsDialog(context);
        }

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        quizBrain.nextQuestion();
      }
    });
    return correctAnswer;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isHovered_true = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isHovered_true = false;
                });
              },
              child: GestureDetector(
                onTap: () => checkAnswer(true),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isHovered_true
                        ? isTrue_true != null
                            ? isTrue_true!
                                ? Colors.green
                                : Colors.red
                            : Colors.blue.shade700
                        : isTrue_true != null
                            ? isTrue_true!
                                ? Colors.green
                                : Colors.red
                            : Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: MouseRegion(
              onEnter: (_) {
                setState(() {
                  _isHovered_false = true;
                });
              },
              onExit: (_) {
                setState(() {
                  _isHovered_false = false;
                });
              },
              child: GestureDetector(
                onTap: () => checkAnswer(false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isHovered_false
                        ? isTrue_false != null
                            ? isTrue_false!
                                ? Colors.green
                                : Colors.red
                            : Colors.blue.shade700
                        : isTrue_false != null
                            ? isTrue_false!
                                ? Colors.green
                                : Colors.red
                            : Colors.blue,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (scoreKeeper.isEmpty)
          Container(
            height: 20,
          )
        else
          SizedBox(
            height: 20,
            child: Row(
              children: scoreKeeper,
            ),
          )
      ],
    );
  }

  void _showCongratulationsDialog(BuildContext context) {
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
        builder: (context) => Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: true,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: true,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                  ),
                ),
              ],
            ));
    Overlay.of(context).insert(overlayEntry);
    _confettiController.play();
  }
}
