import 'package:flutter/material.dart';

class SpaceFillWidget extends StatelessWidget {
  final int numUnits;
  final bool isVerticalFill;

  SpaceFillWidget({required this.numUnits, this.isVerticalFill = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: numUnits * 60 ,
      height: isVerticalFill ? 90 : 50,
      margin: EdgeInsets.all(0),
      color: Colors.transparent,
    );
  }
}
