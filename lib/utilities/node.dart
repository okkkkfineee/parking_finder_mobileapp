class Node {
  Map<int, List<int>> adjacencyList = {};

  void addNode(int node) {
    adjacencyList[node] = [];
  }

  void addEdges(int node, List<int> edges) {
    if (!adjacencyList.containsKey(node)) addNode(node);
    for (var edge in edges) {
      if (!adjacencyList.containsKey(edge)) addNode(edge);
      adjacencyList[node]!.add(edge);
    }
  }

  List<int> getNeighbors(int node) {
    return adjacencyList[node] ?? [];
  }
}

