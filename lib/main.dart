import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToe());
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> _board = List.filled(9, ""); // 9 empty squares
  bool _isXTurn = true;
  String _result = "";

  // Variables to store the score for X and O
  int _xScore = 0;
  int _oScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBoard(),
          SizedBox(height: 10),
          Text(
            _result,
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text("Restart Game"),
          ),
          SizedBox(height: 20),
          _buildScoreBoard(), // Display the score below the button
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onTileTapped(index),
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.purple[100],
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildScoreBoard() {
    return Column(
      children: [
        Text(
          "Score",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "X: $_xScore    O: $_oScore",
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  void _onTileTapped(int index) {
    if (_board[index] != "" || _result != "") return;

    setState(() {
      _board[index] = _isXTurn ? "X" : "O";
      _isXTurn = !_isXTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var positions in winningPositions) {
      String a = _board[positions[0]];
      String b = _board[positions[1]];
      String c = _board[positions[2]];

      if (a != "" && a == b && a == c) {
        setState(() {
          _result = "$a is the Winner!";
          if (a == "X") {
            _xScore++; // Increment X's score
          } else {
            _oScore++; // Increment O's score
          }
        });
        return;
      }
    }

    if (!_board.contains("")) {
      setState(() {
        _result = "It's a Draw!";
      });
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, "");
      _isXTurn = true;
      _result = "";
    });
  }
}
