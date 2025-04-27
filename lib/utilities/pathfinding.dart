import 'node.dart';

class PriorityQueue<T> {
  final List<T> _queue = [];
  final Comparator<T> _comparator;

  PriorityQueue(this._comparator);

  void add(T element) {
    _queue.add(element);
    _queue.sort(_comparator);
  }

  T removeFirst() {
    return _queue.removeAt(0);
  }

  bool get isNotEmpty => _queue.isNotEmpty;
}

List<int> findShortestPath(Node node, int start, int target) {
  Map<int, double> distances = {};
  Map<int, int?> previous = {};
  PriorityQueue<List<dynamic>> pq = PriorityQueue((a, b) => a[1].compareTo(b[1]));

  for (int node in node.adjacencyList.keys) {
    distances[node] = double.infinity;
    previous[node] = null;
  }

  distances[start] = 0;
  pq.add([start, 0]);

  while (pq.isNotEmpty) {
    List<dynamic> current = pq.removeFirst();
    int currentNode = current[0];
    double currentDistance = current[1];

    if (currentNode == target) break;

    for (int neighbor in node.getNeighbors(currentNode)) {
      double newDistance = currentDistance + 1;
      if (newDistance < distances[neighbor]!) {
        distances[neighbor] = newDistance;
        previous[neighbor] = currentNode;
        pq.add([neighbor, newDistance]);
      }
    }
  }

  List<int> path = [];
  int? current = target;
  while (current != null) {
    path.add(current);
    current = previous[current];
  }

  return path.reversed.toList();
}

Future<Map<String, dynamic>> findAdjustedParkingAlongPath({
  required Node parkingGraph,
  required int userNode,
  required List<Map<String, dynamic>> parkingSpaces,
  required List<Map<String, dynamic>> vehicles,
  required Map<String, int> coordinateToNode,
}) async {
  // Step 1: Get all available parking spaces
  List<Map<String, dynamic>> availableParkings = parkingSpaces
      .where((parking) => parking['status'] == 'available')
      .toList();

  if (availableParkings.isEmpty) {
    throw Exception('No available parking spaces.');
  }

  // Step 2: Prepare vehicles that are "finding"
  List<Map<String, dynamic>> findingCars = vehicles
      .where((vehicle) => vehicle['status'] == 'finding')
      .toList();

  // Step 3: For each parking, find the shortest path
  List<Map<String, dynamic>> parkingWithPathInfo = [];

  for (var parking in availableParkings) {
    List<int> path = findShortestPath(parkingGraph, userNode, parking['id']);

    parkingWithPathInfo.add({
      'id': parking['id'],
      'path': path,
      'distance': path.length,
    });
  }

  // Step 4: Sort parkings by distance
  parkingWithPathInfo.sort((a, b) => a['distance'].compareTo(b['distance']));

  // Step 5: Now check how many finding cars are along the FIRST shortest path
  var firstParking = parkingWithPathInfo.first;
  List<int> firstPath = firstParking['path'];

  int findingCarsOnFirstPath = 0;

  for (var car in findingCars) {
    int row = car['coordinates']['x'] - 1;
    int col = car['coordinates']['y'] - 1;
    String key = '${row}_${col}';
    int? carNode = coordinateToNode[key];

    if (carNode != null && firstPath.contains(carNode)) {
      findingCarsOnFirstPath++;
    }
  }

  print('First parking path has $findingCarsOnFirstPath finding cars along the way.');

  // Step 6: Adjust to another parking
  int adjustedIndex = findingCarsOnFirstPath; // skip that many parkings
  if (adjustedIndex >= parkingWithPathInfo.length) {
    adjustedIndex = parkingWithPathInfo.length - 1;
  }

  var assignedParking = parkingWithPathInfo[adjustedIndex];

  print('Assigned Parking Node: ${assignedParking['id']}');
  print('Shortest Path to Assigned Parking: ${assignedParking['path']}');

  return {
    'assignedParkingId': assignedParking['id'],
    'path': assignedParking['path'],
  };
}