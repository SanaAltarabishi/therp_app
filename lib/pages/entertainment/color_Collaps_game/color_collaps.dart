import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

const RELATIVE_GAP_SIZE = 1 / 12;
const GRID_SIZE = 6;
const List<Color> COLORS = [
  Color(0xff7a6c5b),
  Color.fromARGB(114, 122, 108, 91),
  Color(0xffa36168),
  Color(0xff5c666c),
];

class ColorCollapsePage extends StatefulWidget {
  const ColorCollapsePage({super.key});
  @override
  State<ColorCollapsePage> createState() => _ColorCollapsePageState();
}

class GameBox {
  Offset? loc;
  Color? color;
  Offset? startLoc;
  Rect getRect(Size screenSize) {
    double totalBoxWidth = screenSize.shortestSide / GRID_SIZE;
    return Rect.fromCenter(
        center: Offset(screenSize.width / 2 + loc!.dx * totalBoxWidth,
            screenSize.height / 2 + loc!.dy * totalBoxWidth),
        height: totalBoxWidth,
        width: totalBoxWidth);
  }
}

List<GameBox> _generateGameBoxes() {
  List<GameBox> result = [];
  Random r = Random();
  for (double x = -2.5; x <= 2.5; x++) {
    for (double y = -2.5; y <= 2.5; y++) {
      List<Color> candidateColors = [...COLORS];
      for (GameBox box in result) {
        if ((box.loc!.dx == x && box.loc!.dy == y - 1) ||
            (box.loc!.dy == y && box.loc!.dx == x - 1)) {
          candidateColors.remove(box.color);
        }
      }

      result.add(GameBox()
        ..loc = Offset(x, y)
        ..startLoc = Offset(x, y)
        ..color = candidateColors[r.nextInt(candidateColors.length)]);
    }
  }
  return result;
}

class GameBoxWidget extends StatelessWidget {
  final GameBox box;
  const GameBoxWidget({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Rect gameBoxRect = box.getRect(screenSize);
    return Positioned(
      top: gameBoxRect.top,
      left: gameBoxRect.left,
      width: gameBoxRect.width * 1 - RELATIVE_GAP_SIZE,
      height: gameBoxRect.height * 1 - RELATIVE_GAP_SIZE,
      child: Padding(
        padding: EdgeInsets.all((gameBoxRect.width * RELATIVE_GAP_SIZE) / 2),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          // height: 60,
          //width: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: box.color,
          ),
        ),
      ),
    );
  }
}

class _ColorCollapsePageState extends State<ColorCollapsePage> {
  List<GameBox> boxes = _generateGameBoxes();
  late dynamic tappedBox;
  late List<GameBox> tappedRow = [];
  late List<GameBox> tappedColumn = [];
  late dynamic tappedLoc;

  _getTappedBox(Offset glaobalCoords) {
    for (GameBox box in boxes) {
      if (box.getRect(MediaQuery.of(context).size).contains(glaobalCoords)) {
        return box;
      }
    }
    return null;
  }

  List<GameBox> _getRowMatesForBox(GameBox box) {
    List<GameBox> rowMates = [];
    for (GameBox rowMateCandidateBox in boxes) {
      if (box.loc!.dy == rowMateCandidateBox.loc!.dy) {
        rowMates.add(rowMateCandidateBox);
      }
    }
    return rowMates;
  }

  List<GameBox> _getColumnMatesForBox(GameBox box) {
    List<GameBox> columnMates = [];
    for (GameBox columMateCandidateBox in boxes) {
      if (box.loc!.dx == columMateCandidateBox.loc!.dx) {
        columnMates.add(columMateCandidateBox);
      }
    }
    return columnMates;
  }

  void _snapBoxes() {
    for (GameBox box in boxes) {
      late Offset translatedLoc = box.loc! + Offset(.5, .5);
      box.loc =
          Offset(translatedLoc.dx.round() - .5, translatedLoc.dy.round() - .5);
    }
  }

  void _removeContiguousFromRowsOrCols(List<List<GameBox>> rowsOrCols) {
    Set<GameBox> boxesToRemove = Set();
    for (List<GameBox> rowOrCol in rowsOrCols) {
      List<GameBox> currentStreak = [];
      Color? streakColor;
      Offset? lastBoxLox;
      for (GameBox box in rowOrCol) {
        if (streakColor != box.color ||
            (lastBoxLox!.dx - box.loc!.dx).abs() > 1 ||
            (lastBoxLox.dy - box.loc!.dy).abs() > 1) {
          if (currentStreak.length >= 3) {
            boxesToRemove.addAll(currentStreak);
          }
          currentStreak = [box];
          streakColor = box.color;
        } else {
          currentStreak.add(box);
        }
        lastBoxLox = box.loc;
      }
    }
    boxes.removeWhere((b) => boxesToRemove.contains(b));
  }

  List<List<GameBox>> _getRows() {
    Map<double, List<GameBox>> rows = Map();
    for (GameBox box in boxes) {
      List<GameBox> row = rows.putIfAbsent(box.loc!.dy, () => []);
      row.add(box);
      row.sort((a, b) => a.loc!.dx.compareTo(b.loc!.dx));
    }
    return rows.values.toList();
  }

  List<List<GameBox>> _getCols() {
    Map<double, List<GameBox>> cols = Map();
    for (GameBox box in boxes) {
      List<GameBox> col = cols.putIfAbsent(box.loc!.dx, () => []);
      col.add(box);
      col.sort((a, b) => a.loc!.dy.compareTo(b.loc!.dy));
    }
    return cols.values.toList();
  }

  void _removeContiguous() {
    _removeContiguousFromRowsOrCols(_getRows());
    _removeContiguousFromRowsOrCols(_getCols());
  }

  _getBoxAtLoc(Offset loc) {
    for (GameBox box in boxes) {
      if (box.loc == loc) {
        return box;
      }
    }
    return null;
  }

  void _gravitize() {
    List<GameBox> distSortedBoxes = [...boxes];
    distSortedBoxes.sort((GameBox a, GameBox b) {
      return a.loc!.distanceSquared.compareTo(b.loc!.distanceSquared);
    });
    List<double> cardinals = [-pi, -pi / 2, 0, pi / 2, pi];
    for (GameBox box in distSortedBoxes) {
      List<double> possibleMoves = [];
      Offset centerOffset = Offset(0, 0) - box.loc!;
      for (double cardinal in cardinals) {
        double angleDelta = (cardinal - centerOffset.direction).abs();
        if (angleDelta < pi / 3) {
          possibleMoves.add(cardinal);
        }
      }
      for (double move in possibleMoves) {
        Offset newLoc = box.loc! + Offset.fromDirection(move);
        if (_getBoxAtLoc(newLoc) == null) {
          box.loc = newLoc;
          box.startLoc = newLoc;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<Widget> stackChildren =
        boxes.map((b) => GameBoxWidget(box: b)).toList();
    Size screenSize = MediaQuery.of(context).size;
    Rect gameBoxRect =
        (GameBox()..loc = const Offset(0, 0)).getRect(screenSize);
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onPanStart: (DragStartDetails deets) {
                tappedBox = _getTappedBox(deets.globalPosition);
                tappedRow = _getRowMatesForBox(tappedBox);
                tappedColumn = _getColumnMatesForBox(tappedBox);
                tappedLoc = deets.globalPosition;
              },
              onPanUpdate: (DragUpdateDetails deets) {
                final Offset dragOffset = deets.globalPosition - tappedLoc;
                setState(() {
                  if (dragOffset.dx.abs() > dragOffset.dy.abs()) {
                    for (GameBox box in tappedRow) {
                      box.loc = box.startLoc! +
                          Offset(dragOffset.dx / gameBoxRect.width, 0);
                    }
                  } else {
                    for (GameBox box in tappedColumn) {
                      box.loc = box.startLoc! +
                          Offset(0, dragOffset.dy / gameBoxRect.height);
                    }
                  }
                });
              },
              onPanEnd: (DragEndDetails deets) {
                setState(() {
                  _snapBoxes();
                  _removeContiguous();
                  _gravitize();
                  for (GameBox box in boxes) {
                    box.startLoc = box.loc;
                  }
                  tappedBox = null;
                  tappedLoc = null;
                  tappedColumn = [];
                  tappedRow = [];
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: stackChildren,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xff7a6c5b),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Color Collaps",
              style: GoogleFonts.bagelFatOne(
                fontSize: screenWidth / 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xff7a6c5b),
              ),
            ),
          ),
        ],
      ).animate().fade(delay: .4.seconds, duration: .9.seconds),
    );
  }
}
