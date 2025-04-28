import 'package:flutter/material.dart';

class RoadWidget extends StatelessWidget {
  final bool hasCar;
  final bool highlightPath;

  const RoadWidget({
    Key? key,
    this.hasCar = false,
    this.highlightPath = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: highlightPath
            ? Colors.green // highlight color
            : Colors.grey,  // default road color
      ),
      child: hasCar
          ? Center(
              child: Icon(Icons.directions_car, size: 16, color: Colors.white),
            )
          : null,
    );
  }
}

