class Task {
  String name;
  String details;
  bool isDone;

  Task({
    required this.name,
    required this.details,
    this.isDone = false,
  });
}
