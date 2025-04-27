import 'package:flutter/material.dart';

class RoadWidget extends StatelessWidget {
  final bool hasCar;

  const RoadWidget({Key? key, this.hasCar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: hasCar
          ? Center(
              child: Icon(Icons.directions_car, size: 16, color: Colors.white),
            )
          : null,
    );
  }
}
