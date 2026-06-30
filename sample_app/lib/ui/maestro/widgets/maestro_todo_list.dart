import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';

class MaestroTodoList extends StatelessWidget {
  const MaestroTodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('TODOがありません', key: Key('maestro_empty_todo_text')),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          key: Key('maestro_todo_${todo.id}'),
          leading: const Icon(Icons.check_box_outline_blank),
          title: Text(todo.title),
        );
      },
    );
  }
}
