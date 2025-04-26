import 'package:flutter/material.dart';

class RoadWidget extends StatelessWidget {
  final int numUnits;
  final String direction;
  final bool isVerticalFill;
  final bool highlightPath; // New parameter for path highlighting

  RoadWidget({
    required this.numUnits,
    required this.direction,
    this.isVerticalFill = false,
    this.highlightPath = false, // Default: No highlight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: direction == "left" || direction == "right" ? numUnits * 60 : 60,
      height: isVerticalFill ? 90 : 50,
      color: highlightPath ? Colors.green : Colors.grey[300], // Highlight roads in the path
      child: Center(
        child: Icon(
          direction == "left"
              ? Icons.arrow_back
              : direction == "right"
                  ? Icons.arrow_forward
                  : direction == "up"
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
          size: 10,
          color: highlightPath ? Colors.white : Colors.black, // Change arrow color for better contrast
        ),
      ),
    );
  }
}
