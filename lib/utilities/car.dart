class Car {
  int id; // Unique car ID
  List<int> path; // List of nodes to follow
  int currentIndex; // Current position index in path
  bool hasArrived; // Flag to indicate if the car reached its destination

  Car({required this.id, required this.path})
      : currentIndex = 0,
        hasArrived = false;
}
