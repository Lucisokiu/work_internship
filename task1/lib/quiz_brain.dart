import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _correctNumber = 0;
  final List<Question> _questionBank = [
    Question('Can a goldfish remember things for more than 3 months?', false),
    Question('Is it possible for a human to sneeze without closing their eyes?',
        true),
    Question('Does the moon have its own atmosphere?', false),
    Question('Can ostriches fly short distances?', false),
    Question('Is it true that bananas grow on trees?', true),
    Question('Can ants sleep?', false),
    Question('Is there a species of jellyfish that is immortal?', true),
    Question('Do dolphins sleep with one eye open?', true),
    Question('Can penguins fly?', false),
    Question('Is it possible for a plant to feel pain?', false),
  ];
  int getCorrectNumber() {
    return _correctNumber;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  void setCorrectNumber() {
    _correctNumber++;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
    _correctNumber = 0;
  }
}
