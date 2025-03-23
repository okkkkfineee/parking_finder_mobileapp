import 'graph.dart';

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

List<int> findShortestPath(Graph graph, int start, int target) {
  Map<int, double> distances = {};
  Map<int, int?> previous = {};
  PriorityQueue<List<dynamic>> pq = PriorityQueue((a, b) => a[1].compareTo(b[1]));

  for (int node in graph.adjacencyList.keys) {
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

    for (int neighbor in graph.getNeighbors(currentNode)) {
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
