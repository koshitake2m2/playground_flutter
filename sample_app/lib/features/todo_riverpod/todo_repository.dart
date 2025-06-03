import 'todo_model.dart';

class TodoRepository {
  TodoRepository();

  final List<Todo> _todoList = [
    Todo(id: '1', title: 'Apples'),
    Todo(id: '2', title: 'Bananas'),
    Todo(id: '3', title: 'Cherries'),
  ];

  Future<void> _sleep() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<List<Todo>> getTodoList() async {
    await _sleep();
    return List.unmodifiable(_todoList);
  }

  Future<void> addTodo(Todo todo) async {
    await _sleep();
    _todoList.add(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _sleep();
    final index = _todoList.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todoList[index] = todo;
    }
  }

  Future<void> deleteTodo(String id) async {
    await _sleep();
    _todoList.removeWhere((t) => t.id == id);
  }
}
