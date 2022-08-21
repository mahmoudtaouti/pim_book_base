class Task {
  int? id;
  String description = "";
  String? dueDate;
  String completed = "false";

  Task();
  Task.setWithId(this.id, this.description, this.dueDate, this.completed);
  Task.set(this.id, this.description, this.dueDate, this.completed);

  factory Task.fromMap(Map<String,dynamic> inMap){
    return Task.setWithId(
        inMap["id"],
        inMap["description"],
        inMap["dueDate"],
        inMap["completed"]
    );
  }

  static Map<String,dynamic> toMap(Task task){
    Map<String,dynamic> map = {
      "id": task.id,
      "description" : task.description,
      "dueDate" : task.dueDate,
      "completed" : task.completed
    };
    return map;
  }

}