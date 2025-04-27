import 'package:flutter/material.dart';

class ParkingSpaceWidget extends StatelessWidget {
  final String status;

  const ParkingSpaceWidget({
    Key? key,
    required this.id,
    required this.status,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: status == 'occupied' ? Colors.red : status == 'available' ? Colors.green : Colors.blue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          id.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            decoration: TextDecoration.none, 
          ),
        )
      ),
    );
  }
}

