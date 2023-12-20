import 'package:flutter/material.dart';
import '../widgets/layout/horizontal_layout.dart';
import '../widgets/layout/vertical_screen.dart';

class SolveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return VerticalScreen();
          } else {
            return HorizontalLayout();
          }
        },
      ),
    );
  }
}
