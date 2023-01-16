import 'package:flutter/material.dart';
import 'package:xox/backend/game.dart';
import 'package:xox/frontend/theme/color.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  String curPerson = "X";
  bool isGameOver = false;
  int moves = 0;
  String result = "";
  Game game = Game();

  @override
  void initState() {
    super.initState();
    game.board = Game.initBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MainColor.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('TIC TAC TOE'),
          //  backgroundColor: Colors.b,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "It's $curPerson Turn",
              style: GoogleFonts.halant(
                color: Colors.amber,
                fontSize: 54,
                wordSpacing: 0.4,
                //  fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: boardWidth,
              height: boardWidth,
              child: GridView.count(
                crossAxisCount: Game.boardSize ~/ 3,
                padding: const EdgeInsets.all(20.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(Game.boardSize, (index) {
                  return InkWell(
                    onTap: isGameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = curPerson;
                                moves++;
                                isGameOver = game.hasWon(curPerson);

                                if (isGameOver) {
                                  result = "$curPerson won";
                                } else if (!isGameOver && moves == 9) {
                                  result = "Draw";
                                  isGameOver = true;
                                }
                                if (curPerson == "X") {
                                  curPerson = "O";
                                } else {
                                  curPerson = "X";
                                }
                              });
                            }
                          },
                    child: Container(
                      width: Game.squareSize,
                      height: Game.squareSize,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Text(
              result,
              style: GoogleFonts.bubblegumSans(
                color: Colors.lightGreen,
                fontSize: 50,
                letterSpacing: 3.0,
              ),
              softWrap: true,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  game.board = Game.initBoard();
                  curPerson = "X";
                  isGameOver = false;
                  moves = 0;
                  result = "";
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text(
                "Play Again",
                textScaleFactor: 1.3,
              ),
            ),
          ],
        ));
  }
}
