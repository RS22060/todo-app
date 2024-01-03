class Todo {
  late int id;
  late String title;
  late bool isDone;
  late String userId;

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
    required this.userId
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
      userId: json['userId']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'isDone': isDone,
    'userId': userId
  };
}
