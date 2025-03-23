import 'package:flutter/material.dart';

class ParkingSpacesWidget extends StatelessWidget {
  final int spaceCount;
  final int startNumber; 
  final bool isVertical;
  final Color color;

  ParkingSpacesWidget({
    required this.spaceCount,
    required this.startNumber,
    this.isVertical = true,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: isVertical ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(spaceCount, (index) {
        return Container(
          width: isVertical ? 50 : 80,
          height: isVertical ? 80 : 41,
          margin: isVertical ? EdgeInsets.all(5) : EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text((startNumber + index).toString()),
          ),
        );
      }),
    );
  }
}
