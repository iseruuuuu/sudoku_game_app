import 'package:flutter/material.dart';
import '../sudoku_table.dart';
import '../button/animated_solve_button.dart';
import '../keypad.dart';
import '../options_row.dart';

class VerticalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 0.33,
          child: Container(
            color: Colors.cyan,
          ),
        ),
        Center(
          child: Column(
            children: [
              Spacer(flex: 3),
              FractionallySizedBox(
                widthFactor: 0.92,
                child: OptionsRow(),
              ),
              Spacer(),
              FractionallySizedBox(
                widthFactor: 0.92,
                child: SudokuTable(),
              ),
              Spacer(flex: 2),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: KeyPad(),
              ),
              Spacer(flex: 2),
              FractionallySizedBox(
                widthFactor: 0.75,
                child: AnimatedSolveButton(),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
