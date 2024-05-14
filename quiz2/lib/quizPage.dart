import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class SingleQuestion {
  final String? question;
  final List<String>? options;
  final int? ansIndex;
  const SingleQuestion({this.question, this.options, this.ansIndex});
}

class _QuizAppState extends State<QuizApp> {
  List allQuestions = [
    const SingleQuestion(
        question: "Who is Captain of Indian Cricket Team?",
        options: ["Rohit Sharma", "Pat Cummins", "Temba Bavuma", "Babar Azam"],
        ansIndex: 0),
    const SingleQuestion(
        question: "Who is Captain of South Africa Criket Team?",
        options: [
          "Dasun Shanaka",
          "Shai Hope",
          "Temba Bavuma",
          "Shakib Al Hasan"
        ],
        ansIndex: 2),
    const SingleQuestion(
        question: "Who is Captain of Pakistan Cricket Team?",
        options: [
          "Rohit Sharma",
          "David Warner",
          "Mohammad Nabi",
          "Babar Azam"
        ],
        ansIndex: 3),
    const SingleQuestion(
        question: "Who is Captain of Australian Cricket Team?",
        options: ["Virat Kohli", "Pat Cummins", "David Warner", "Tim David"],
        ansIndex: 1),
    const SingleQuestion(
        question: "Who is Captain of England Cricket Team?",
        options: ["Jofra Archer", "Josh Buttler", "Steve Smith", "Tom Letham"],
        ansIndex: 1),
  ];
  int queIndex = 0;
  int correctAns = 0;
  bool isQuestionScreen = true;
  int ansChoosen = -1;
  bool startQuiz = false;

  Color? correct1(int optionSelected) {
    if (ansChoosen != -1) {
      if (optionSelected == allQuestions[queIndex].ansIndex) {
        return Colors.green;
      } else if (ansChoosen != optionSelected) {
        return Colors.blueGrey;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.blueGrey;
    }
  }

  Scaffold screen() {
    if (!startQuiz) {
      return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Center(
              child: AppBar(
                automaticallyImplyLeading: false,
                title: const Text(
                  "QUIZAPP",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                ),
                centerTitle: true,
              ),
            ),
          ),
          body: Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    startQuiz = !startQuiz;
                  });
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Start Quiz",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                )),
          ));
    } else {
      if (isQuestionScreen) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Center(
              child: AppBar(
                title: const Text(
                  "QUIZAPP",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
                ),
                centerTitle: true,
              ),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Questions: ",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${queIndex + 1}/${allQuestions.length}",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 65,
                width: 400,
                alignment: Alignment.center,
                child: Text(
                  allQuestions[queIndex].question,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(correct1(0)),
                ),
                onPressed: () {
                  setState(() {
                    ansChoosen = 0;
                  });
                },
                child: Text(
                  allQuestions[queIndex].options[0],
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(correct1(1)),
                ),
                onPressed: () {
                  setState(() {
                    ansChoosen = 1;
                  });
                },
                child: Text(allQuestions[queIndex].options[1],
                    style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(correct1(2)),
                ),
                onPressed: () {
                  setState(() {
                    ansChoosen = 2;
                  });
                },
                child: Text(allQuestions[queIndex].options[2],
                    style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(
                height: 22,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(correct1(3)),
                ),
                onPressed: () {
                  setState(() {
                    ansChoosen = 3;
                  });
                },
                child: Text(allQuestions[queIndex].options[3],
                    style: const TextStyle(fontSize: 22)),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (ansChoosen == allQuestions[queIndex].ansIndex) {
                  correctAns++;
                }
                if (ansChoosen != -1) {
                  ansChoosen = -1;
                  if (queIndex < allQuestions.length - 1) {
                    queIndex++;
                  } else {
                    isQuestionScreen = false;
                  }
                } else {
                  _showAlert(context);
                }
              });
            },
            tooltip: "next",
            child: const Icon(Icons.forward),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "QUIZAPP",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK6UDRoQ6tpnxg-FQN30lvaytKIT3rRKhOVA&usqp=CAU',
                  height: 200,
                  width: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Congratulations...!!!",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
                const Center(
                  child: Text(
                    "You have Completed the Quiz",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  "$correctAns/${allQuestions.length}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50)),
                    ),
                    onPressed: () {
                      setState(() {
                        queIndex = 0;
                        ansChoosen = -1;
                        isQuestionScreen = true;
                        correctAns = 0;
                      });
                    },
                    child: const Text("Reset"))
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return screen();
  }

  void _showAlert(BuildContext context) {
    Alert(
      context: context,
      content: const Column(
        children: [
          Text(
            "Option not Selected",
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Select any option to continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.blueGrey,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ],
    ).show();
  }
}
