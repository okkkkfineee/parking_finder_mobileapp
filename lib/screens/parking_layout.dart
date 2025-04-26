import 'package:flutter/material.dart';
import 'package:parking_finder_app/widget/parking_spaces.dart';
import 'package:parking_finder_app/widget/road.dart';
import 'package:parking_finder_app/widget/space_fill.dart';
import 'package:parking_finder_app/utilities/node.dart';
import 'package:parking_finder_app/utilities/pathfinding.dart';

class ParkingLayout extends StatefulWidget {
  @override
  _ParkingLayoutState createState() => _ParkingLayoutState();
}

class _ParkingLayoutState extends State<ParkingLayout> {
  late Node parkingGraph;
  List<int> path = [];

  @override
  void initState() {
    super.initState();
    parkingGraph = Node();
    _initializeGraph();
  }

  void _initializeGraph() {
    for (int i = 1; i <= 72; i++) {  //Total 72 parking space and road
      parkingGraph.addNode(i);
    }

    parkingGraph.addEdges(31, [39]);
    parkingGraph.addEdges(32, [1, 7, 31]);
    parkingGraph.addEdges(33, [2, 8, 32]);
    parkingGraph.addEdges(34, [3, 9, 33]);
    parkingGraph.addEdges(35, [4, 10, 34]);
    parkingGraph.addEdges(36, [5, 11, 35]);
    parkingGraph.addEdges(37, [6, 12, 36]);
    parkingGraph.addEdges(38, [37]);
    parkingGraph.addEdges(39, [41]);
    parkingGraph.addEdges(40, [38]);
    parkingGraph.addEdges(41, [44]);
    parkingGraph.addEdges(42, [40]);
    parkingGraph.addEdges(43, [53]);
    parkingGraph.addEdges(44, [19, 43]);
    parkingGraph.addEdges(45, [13, 20, 44]);
    parkingGraph.addEdges(46, [14, 21, 45]);
    parkingGraph.addEdges(47, [15, 46]);
    parkingGraph.addEdges(48, [16, 55, 47]);
    parkingGraph.addEdges(49, [17, 22, 48]);
    parkingGraph.addEdges(50, [18, 23, 49]);
    parkingGraph.addEdges(51, [24, 42, 50]);
    parkingGraph.addEdges(52, [51]);
    parkingGraph.addEdges(53, [57]);
    parkingGraph.addEdges(54, [47]);
    parkingGraph.addEdges(55, [59]);
    parkingGraph.addEdges(56, [52]);
    parkingGraph.addEdges(57, [61]);
    parkingGraph.addEdges(58, [54]);
    parkingGraph.addEdges(59, [66]);
    parkingGraph.addEdges(60, [56]);
    parkingGraph.addEdges(61, [62]);
    parkingGraph.addEdges(62, [25, 63]);
    parkingGraph.addEdges(63, [26, 64]);
    parkingGraph.addEdges(64, [27, 65]);
    parkingGraph.addEdges(65, [58, 66]);
    parkingGraph.addEdges(66, [72, 67]);
    parkingGraph.addEdges(67, [28, 68]);
    parkingGraph.addEdges(68, [29, 69]);
    parkingGraph.addEdges(69, [30, 70]);
    parkingGraph.addEdges(70, [60]);
    parkingGraph.addEdges(71, [65]);
  }

  void _findPath() {
    setState(() {
      path = findShortestPath(parkingGraph, 49, 5);  // From, To
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
                          SpaceFillWidget(numUnits: 2),
                          ParkingSpacesWidget(spaceCount: 6, startNumber: 1), // 1-6
                        ],
                      ),

                      // Row 2: Left-moving Road (Nodes 31-38)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 1),
                          for (int i = 31; i < 39; i++)
                            RoadWidget(numUnits: 1, direction: "left", highlightPath: path.contains(i)),
                        ],
                      ),

                      // Row 3: Center row of Parking with Vertical Roads Connected
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 1),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(39)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 6, startNumber: 7), // 7-12
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(40)),
                            ],
                          ),
                        ],
                      ),

                      // Row 4: Center row of Parking with Vertical Roads Connected
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 1),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(41)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 6, startNumber: 13), // 13-18
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(42)),
                            ],
                          ),
                        ],
                      ),

                      // Row 5: Left-moving Road (Nodes 43-52)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 43; i < 53; i++)
                            RoadWidget(numUnits: 1, direction: "left", highlightPath: path.contains(i)),
                        ],
                      ),

                      // Row 6: Middle Parking with Vertical Roads Connected
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(53)),
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(57)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 3, startNumber: 19), // 19-21
                              ParkingSpacesWidget(spaceCount: 3, startNumber: 25), // 25-27
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(54)),
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(58)),
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(55)),
                              RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(59)),
                            ],
                          ),
                          Column(
                            children: [
                              ParkingSpacesWidget(spaceCount: 3, startNumber: 22), // 22-24
                              ParkingSpacesWidget(spaceCount: 3, startNumber: 28), // 28-30
                            ],
                          ),
                          Column(
                            children: [
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(56)),
                              RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(60)),
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     ParkingSpacesWidget(spaceCount: 4, startNumber: 15, isVertical: false), // 15-18
                          //   ],
                          // ),
                        ],
                      ),

                      // Row 7: Right-moving Road (Nodes 61-70)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 61; i < 71; i++)
                            RoadWidget(numUnits: 1, direction: "right", highlightPath: path.contains(i)),
                        ],
                      ),

                      // Row 8: Entrance and Exit
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SpaceFillWidget(numUnits: 4),
                          RoadWidget(numUnits: 1, direction: "up", isVerticalFill: true, highlightPath: path.contains(71)), // Entrance
                          RoadWidget(numUnits: 1, direction: "down", isVerticalFill: true, highlightPath: path.contains(72)), // Exit
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
