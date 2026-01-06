class Todo {
  Todo({required this.id, required this.title});

  final String id;
  final String title;

  factory Todo.fromJson(Map<String, dynamic> json) =>
      Todo(id: json['id'] as String, title: json['title'] as String);

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}
