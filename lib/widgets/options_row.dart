import 'package:flutter/material.dart';
import '../models/sudoku_grid.dart';
import 'button/secondary_button.dart';
import 'package:provider/provider.dart';

class OptionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            onTap: () => context.read<SudokuGrid>().resetBoard(),
            label: 'リセット',
            icon: Icons.refresh_outlined,
          ),
        ),
      ],
    );
  }
}
