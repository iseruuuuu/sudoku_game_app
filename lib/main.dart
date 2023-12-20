import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/solve_screen.dart';
import 'models/sudoku_grid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SudokuGrid>(
      create: (context) => SudokuGrid.blank(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SolveScreen(),
      ),
    );
  }
}
