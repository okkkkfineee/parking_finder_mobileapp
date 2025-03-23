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
  List<int> path = []; // Store the shortest path

  @override
  void initState() {
    super.initState();
    parkingGraph = Graph();
    _initializeGraph();
  }

void _initializeGraph() {
  // Step 1: Add Nodes (Parking + Roads)
  for (int i = 1; i <= 30; i++) {
    parkingGraph.addNode(i);
  }

  // Step 2: Add Edges (Road & Parking Connectivity)

  // Top Parking Spaces to Top Road (One-Way Down)
  parkingGraph.addEdge(1, 7);
  parkingGraph.addEdge(2, 8);
  parkingGraph.addEdge(3, 9);
  parkingGraph.addEdge(4, 10);
  parkingGraph.addEdge(5, 11);
  parkingGraph.addEdge(6, 12);

  // Top Road (One-way Left)
  parkingGraph.addEdge(7, 8);
  parkingGraph.addEdge(8, 9);
  parkingGraph.addEdge(9, 10);
  parkingGraph.addEdge(10, 11);
  parkingGraph.addEdge(11, 12);

  // Vertical Connections from Top Road to Middle Road
  parkingGraph.addEdge(7, 13);
  parkingGraph.addEdge(9, 14);
  parkingGraph.addEdge(11, 15);

  parkingGraph.addEdge(13, 16);
  parkingGraph.addEdge(14, 18);
  parkingGraph.addEdge(15, 20);

  // Middle Parking to Middle Road
  parkingGraph.addEdge(16, 17);
  parkingGraph.addEdge(18, 19);
  parkingGraph.addEdge(20, 21);

  // Middle Road (One-way Left)
  parkingGraph.addEdge(17, 18);
  parkingGraph.addEdge(19, 20);
  parkingGraph.addEdge(21, 22);

  // Vertical Connections from Middle to Bottom Road
  parkingGraph.addEdge(16, 23);
  parkingGraph.addEdge(18, 24);
  parkingGraph.addEdge(20, 25);

  parkingGraph.addEdge(23, 26);
  parkingGraph.addEdge(24, 27);
  parkingGraph.addEdge(25, 28);

  // Bottom Road (One-way Right)
  parkingGraph.addEdge(26, 27);
  parkingGraph.addEdge(27, 28);
  parkingGraph.addEdge(28, 29);
  parkingGraph.addEdge(29, 30);

  // Entrance & Exit Connections
  parkingGraph.addEdge(30, 26); // Entrance to Bottom Road
  parkingGraph.addEdge(25, 1);  // Exit to Top
}

  void _findPath() {
    setState(() {
      path = findShortestPath(parkingGraph, 30, 7); // Example: Entrance (30) to Parking (7)
      print("Shortest Path: $path"); // Debugging
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
            onPressed: _findPath, // Run pathfinding when clicked
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
                          RoadWidget(numUnits: 8, direction: "left", highlightPath: path.any((node) => node >= 7 && node <= 12)),
                        ],
                      ),

                      // Row 3: Middle Parking with Vertical Roads Connected
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(13)),
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(16)),
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
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(9)),
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(14)),
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(15)),
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(18)),
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
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(17)),
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(21)),
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
                          RoadWidget(numUnits: 8, direction: "right", highlightPath: path.any((node) => node >= 25 && node <= 30)),
                        ],
                      ),

                      // Row 6: Entrance and Exit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 3),
                          RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(30)), // Entrance
                          RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(26)), // Exit
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
