class Task {
  String content;
  DateTime timestamp;
  bool done;

  Task({
    required this.content,
    required this.timestamp,
    required this.done,
  });

// Factory method is created which takes certain arguments and create the instance of the class required
  // For example in this case taking content, etc to create the instance of task
  factory Task.fromMap(Map task) {
    return Task(
        content: task["content"],
        timestamp: task["timestamp"],
        done: task["done"]);
  } //Or may be like taking the class and converting it to a map

  Map toMap() {
    return {"content": content, "timestamp": timestamp, "done": done};
  } //This map is created to send it to hive database and also a map is obtained from it when requested

}
