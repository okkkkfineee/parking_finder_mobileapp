class Graph {
  Map<int, List<int>> adjacencyList = {};

  void addNode(int node) {
    adjacencyList[node] = [];
  }

  void addEdge(int node1, int node2) {
    if (!adjacencyList.containsKey(node1)) addNode(node1);
    if (!adjacencyList.containsKey(node2)) addNode(node2);
    adjacencyList[node1]!.add(node2);
  }

  List<int> getNeighbors(int node) {
    return adjacencyList[node] ?? [];
  }

  void printGraph() {
    adjacencyList.forEach((key, value) {
      print("$key -> $value");
    });
  }
}
