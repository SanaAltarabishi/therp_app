import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:multi_task_app/pages/entertainment/xo_game/xo_homepage.dart';
import 'package:page_transition/page_transition.dart';

class GamePage extends StatefulWidget {
  String player1;
  String player2;
  GamePage({super.key, required this.player1, required this.player2});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _winner = "";
    _gameOver = false;
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ''));
      _currentPlayer = 'X';
      _winner = "";
      _gameOver = false;
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] != '' || _gameOver) {
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;
      if (_board[row][0] == _currentPlayer &&
          _board[row][1] == _currentPlayer &&
          _board[row][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][col] == _currentPlayer &&
          _board[1][col] == _currentPlayer &&
          _board[2][col] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][0] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][2] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_board[0][2] == _currentPlayer &&
          _board[1][1] == _currentPlayer &&
          _board[2][0] == _currentPlayer) {
        _winner = _currentPlayer;
        _gameOver = true;
      }
//switch players :
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
// check for a tie :
      if (!_board.any((row) => row.any((cell) => cell == ''))) {
        _gameOver = true;
        _winner = "It's a tie";
      }
      if (_winner != '') {
        AwesomeDialog(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff7a6c5b),
              fontSize: 20),
          btnOkColor: Color(0xff7a6c5b),
          dialogBackgroundColor: Color(0xfff3dbcc),
          context: context,
          dialogType: DialogType.noHeader,
          animType: AnimType.rightSlide,
          btnOkText: 'Play Again',
          title: _winner == "X"
              ? widget.player1 + " WON!"
              : _winner == 'O'
                  ? widget.player2 + " WON!"
                  : "it's a tie",
          btnOkOnPress: () {
            _resetGame();
          },
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Turn:",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a6c5b),
                          ),
                        ),
                        Text(
                          _currentPlayer == "X"
                              ? widget.player1 + "($_currentPlayer)"
                              : widget.player2 + "($_currentPlayer)",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _currentPlayer == "X"
                                ? Colors.red.shade300
                                : Colors.green.shade200,
                          ),
                        ),
                      ],
                    ).animate().fade(delay: .4.seconds, duration: .5.seconds),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xfff3dbcc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(5),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemCount: 9,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          int row = index ~/ 3;
                          int col = index % 3;
                          return GestureDetector(
                            onTap: () => _makeMove(row, col),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  // color: Color(0xff7a6c5b),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xff7a6c5b),
                                  )),
                              child: Center(
                                child: Text(
                                  _board[row][col],
                                  style: TextStyle(
                                    fontSize: 100,
                                    fontWeight: FontWeight.bold,
                                    color: _board[row][col] == "X"
                                        ? Colors.red.shade300
                                        : Colors.green.shade200,
                                  ),
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .fade(delay: .6.seconds, duration: .7.seconds);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: _resetGame,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff7a6c5b),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              child: const Text(
                                'RESET GAME',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfff3dbcc),
                                    fontSize: 20),
                              ).animate().fade(
                                  delay: 1.seconds, duration: 1.1.seconds),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  PageTransition(
                                      child: const XOHomepage(),
                                      type: PageTransitionType.fade));
                              widget.player1 = "";
                              widget.player2 = "";
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff7a6c5b),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              child: const Text(
                                'RESTART GAME',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xfff3dbcc),
                                    fontSize: 20),
                              ).animate().fade(
                                  delay: 1.seconds, duration: 1.1.seconds),
                            ),
                          ),
                        ],
                      ).animate().fade(delay: .8.seconds, duration: .9.seconds),
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff7a6c5b),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
