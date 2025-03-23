import 'package:flutter/material.dart';
import 'package:parking_finder_app/widget/parking_spaces.dart';
import 'package:parking_finder_app/widget/road.dart';
import 'package:parking_finder_app/widget/space_fill.dart';
import 'package:parking_finder_app/utilities/graph.dart';
import 'package:parking_finder_app/utilities/pathfinding.dart';

class ParkingLayout extends StatefulWidget {
  @override
  _ParkingLayoutState createState() => _ParkingLayoutState();
}

class _ParkingLayoutState extends State<ParkingLayout> {
  late Graph parkingGraph;
  List<int> path = [];

  @override
  void initState() {
    super.initState();
    parkingGraph = Graph();
    _initializeGraph();
  }

  void _initializeGraph() {
    for (int i = 1; i <= 44; i++) {
      parkingGraph.addNode(i);
    }

    parkingGraph.addEdge(19, 27);
    parkingGraph.addEdge(20, 1);
    parkingGraph.addEdge(20, 7);
    parkingGraph.addEdge(20, 19);
    parkingGraph.addEdge(21, 2);
    parkingGraph.addEdge(21, 8);
    parkingGraph.addEdge(21, 20);
    parkingGraph.addEdge(22, 3);
    parkingGraph.addEdge(22, 21);
    parkingGraph.addEdge(23, 4);
    parkingGraph.addEdge(23, 22);
    parkingGraph.addEdge(23, 29);
    parkingGraph.addEdge(24, 5);
    parkingGraph.addEdge(24, 9);
    parkingGraph.addEdge(24, 23);
    parkingGraph.addEdge(25, 6);
    parkingGraph.addEdge(25, 10);
    parkingGraph.addEdge(25, 24);
    parkingGraph.addEdge(26, 25);
    parkingGraph.addEdge(27, 31);
    parkingGraph.addEdge(28, 22);
    parkingGraph.addEdge(29, 33);
    parkingGraph.addEdge(30, 26);
    parkingGraph.addEdge(30, 15);
    parkingGraph.addEdge(30, 16);
    parkingGraph.addEdge(31, 35);
    parkingGraph.addEdge(32, 28);
    parkingGraph.addEdge(33, 39);
    parkingGraph.addEdge(34, 30);
    parkingGraph.addEdge(34, 17);
    parkingGraph.addEdge(34, 18);
    parkingGraph.addEdge(35, 36);
    parkingGraph.addEdge(36, 11);
    parkingGraph.addEdge(36, 37);
    parkingGraph.addEdge(37, 12);
    parkingGraph.addEdge(37, 38);
    parkingGraph.addEdge(38, 32);
    parkingGraph.addEdge(38, 39);
    parkingGraph.addEdge(39, 40);
    parkingGraph.addEdge(39, 44);
    parkingGraph.addEdge(40, 13);
    parkingGraph.addEdge(40, 41);
    parkingGraph.addEdge(41, 14);
    parkingGraph.addEdge(41, 42);
    parkingGraph.addEdge(42, 34);
    parkingGraph.addEdge(43, 38);
  }

  void _findPath() {
    setState(() {
      path = findShortestPath(parkingGraph, 32, 4);
      print("Shortest Path: $path");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking Lot Layout"), 
        actions: [
          IconButton(
            icon: Icon(Icons.directions),
            onPressed: _findPath,
          ),
        ],),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: ClipRect(
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.zero,
              minScale: 0.5,
              maxScale: 3.0,
              constrained: false,
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Top Parking Spaces (1-6)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 1),
                          ParkingSpacesWidget(spaceCount: 6, startNumber: 1), // 1-6
                        ],
                      ),

                      // Row 2: Left-moving Road (Nodes 7-12)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 19; i < 27; i++)
                            RoadWidget(numUnits: 1, direction: "left", highlightPath: path.contains(i)),
                        ],
                      ),

                      // Row 3: Middle Parking with Vertical Roads Connected
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(27)),
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(31)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 2, startNumber: 7), // 7-8
                              ParkingSpacesWidget(spaceCount: 2, startNumber: 11), // 11-12
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(28)),
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(32)),
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(29)),
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(33)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 2, startNumber: 9), // 9-10
                              ParkingSpacesWidget(spaceCount: 2, startNumber: 13), // 13-14
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(30)),
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(34)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 4, startNumber: 15, isVertical: false), // 15-18
                            ],
                          ),
                        ],
                      ),

                      // Row 5: Right-moving Road (Nodes 25-30)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 35; i < 43; i++)
                            RoadWidget(numUnits: 1, direction: "right", highlightPath: path.contains(i)),
                        ],
                      ),

                      // Row 6: Entrance and Exit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 3),
                          RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(43)), // Entrance
                          RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(44)), // Exit
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
