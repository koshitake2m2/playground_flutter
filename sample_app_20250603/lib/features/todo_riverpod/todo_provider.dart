import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_model.dart';
import 'todo_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository();
});

class TodoFilterNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void update(String filter) {
    state = filter;
  }
}

final todoFilterProvider = NotifierProvider<TodoFilterNotifier, String>(
  () => TodoFilterNotifier(),
);

class TodoListAsyncNotifier extends AsyncNotifier<List<Todo>> {
  late final TodoRepository _repository;

  @override
  Future<List<Todo>> build() async {
    _repository = ref.read(todoRepositoryProvider);
    return await _repository.getTodoList();
  }

  Future<void> add(Todo todo) async {
    _writeAndRefresh(() => _repository.addTodo(todo));

    // This approach is not recommended. It doesn't show loading.
    // await _repository.addTodo(todo);
    // ref.invalidateSelf();
  }

  Future<void> edit(Todo todo) async {
    _writeAndRefresh(() => _repository.updateTodo(todo));
  }

  Future<void> delete(String id) async {
    _writeAndRefresh(() => _repository.deleteTodo(id));
  }

  Future<void> _writeAndRefresh(Future<void> Function() write) async {
    state = const AsyncValue.loading();
    try {
      await write();
      state = AsyncValue.data(await _repository.getTodoList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final todoListProvider =
    AsyncNotifierProvider<TodoListAsyncNotifier, List<Todo>>(
      () => TodoListAsyncNotifier(),
    );

final filteredTodoListProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todosAsync = ref.watch(todoListProvider);
  return todosAsync.whenData((todos) {
    if (filter.isEmpty) return todos;
    return todos
        .where(
          (todo) => todo.title.toLowerCase().contains(filter.toLowerCase()),
        )
        .toList();
  });
});
