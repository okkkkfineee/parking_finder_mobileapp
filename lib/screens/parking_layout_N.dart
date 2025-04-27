import 'package:flutter/material.dart';
import 'package:parking_finder_app/widget/parking_spaces.dart';
import 'package:parking_finder_app/widget/road.dart';
import 'package:parking_finder_app/widget/space_fill.dart';
import 'package:parking_finder_app/data/parking_space_dummy_data.dart';
import 'package:parking_finder_app/data/vehicle_dummy_data.dart';
import 'package:parking_finder_app/utilities/node.dart';
import 'package:parking_finder_app/utilities/pathfinding.dart';

final List<List<String>> parkingMap = [
  ['S', 'S', 'P', 'P', 'P', 'P', 'P', 'P', 'S', 'S'],
  ['S', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'S'],
  ['S', 'R', 'P', 'P', 'P', 'P', 'P', 'P', 'R', 'S'],
  ['S', 'R', 'P', 'P', 'P', 'P', 'P', 'P', 'R', 'S'],
  ['R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R'],
  ['R', 'P', 'P', 'P', 'R', 'R', 'P', 'P', 'P', 'R'],
  ['R', 'P', 'P', 'P', 'R', 'R', 'P', 'P', 'P', 'R'],
  ['R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R'],
  ['S', 'S', 'S', 'S', 'R', 'R', 'S', 'S', 'S', 'S'],
];

class ParkingLotNLayout extends StatefulWidget {
  @override
  const ParkingLotNLayout({Key? key}) : super(key: key);
  _ParkingLayoutState createState() => _ParkingLayoutState();
}

class _ParkingLayoutState extends State<ParkingLotNLayout> {

  late Node parkingGraph;
  late Map<String, int> coordinateToNode;
  List<int> path = [];

  @override
  void initState() {
    super.initState();
    parkingGraph = Node();
    _initializeGraph();
    _initializeCoordinateToNode();
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

  void _initializeCoordinateToNode() {
    coordinateToNode = {};
    int nodeCounter = 1;

    for (int row = 0; row < parkingMap.length; row++) {
      for (int col = 0; col < parkingMap[row].length; col++) {
        String cellType = parkingMap[row][col];

        if (cellType == 'P' || cellType == 'R') {
          String key = '${row}_${col}';
          coordinateToNode[key] = nodeCounter;
          nodeCounter++;
        }
      }
    }
  }

  void _findPath() async {
    try {
      int userNode = 49; // user node

      var result = await findAdjustedParkingAlongPath(
        parkingGraph: parkingGraph,
        userNode: userNode,
        parkingSpaces: dummyParkingData,
        vehicles: dummyVehicleData,
        coordinateToNode: coordinateToNode,
      );

      print('Assigned Parking Node: ${result['assignedParkingId']}');
      print('Shortest Path to Assigned Parking: ${result['path']}');
    } catch (e) {
      print('Error finding parking: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int parkingSpaceIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking Lot N"), 
        actions: [
          IconButton(
            icon: Icon(Icons.directions),
            onPressed: _findPath,
          ),
        ],),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset('assets/images/ic_right.png', width: 40, height: 40),
                ),
                Expanded(
                  flex: 5,
                  child: const Text(
                    'Navigation instruction goes here...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: parkingMap.length * parkingMap[0].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: parkingMap[0].length,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ parkingMap[0].length;
                int col = index % parkingMap[0].length;
                String cellType = parkingMap[row][col];

                if (cellType == 'P') {
                  if (parkingSpaceIndex < dummyParkingData.length) {
                    Map<String, dynamic> parkingSpace = dummyParkingData[parkingSpaceIndex];
                    String status = parkingSpace['status'];
                    parkingSpaceIndex++;
                    return ParkingSpaceWidget(id: parkingSpace['id'], status: status);
                  }
                } else if (cellType == 'R') {
                  bool hasCar = dummyVehicleData.any((car) =>
                      car['coordinates']['x'] == row && car['coordinates']['y'] == col);
                  return RoadWidget(hasCar: hasCar);
                } else {
                  return SpaceFillWidget();
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
