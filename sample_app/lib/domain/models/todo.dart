class Todo {
  const Todo({required this.id, required this.title});

  final int id;
  final String title;

  Todo copyWith({int? id, String? title}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
