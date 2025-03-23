import 'dart:async';
import 'package:flutter/material.dart';

class CarWidget extends StatefulWidget {
  final List<int> path;
  final VoidCallback onArrived;
  final Map<int, Offset> nodePositions;

  const CarWidget({
    required this.path,
    required this.nodePositions,
    required this.onArrived,
    Key? key,
  }) : super(key: key);

  @override
  _CarWidgetState createState() => _CarWidgetState();
}

class _CarWidgetState extends State<CarWidget> {
  int currentNodeIndex = 0;
  Timer? _timer; // Store the timer reference

  @override
  void initState() {
    super.initState();
    _startCarAnimation();
  }

  void _startCarAnimation() {
    int i = 1;
    _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      if (!mounted || i >= widget.path.length) {
        timer.cancel();  // Ensure timer is stopped when car reaches destination
        widget.onArrived();
      } else {
        setState(() {
          currentNodeIndex = i;
        });
        i++;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset pos = widget.nodePositions[widget.path[currentNodeIndex]] ?? Offset(0, 0);

    return Positioned(
      top: pos.dy,
      left: pos.dx,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        child: Icon(Icons.directions_car, size: 30, color: Colors.red),
      ),
    );
  }
}
