import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../../../data/repositories/todo_repository.dart';
import '../../../domain/models/todo.dart';

class TodoCrudState {
  const TodoCrudState({
    required this.todos,
    required this.isLoading,
    this.errorMessage,
  });

  final List<Todo> todos;
  final bool isLoading;
  final String? errorMessage;

  TodoCrudState copyWith({
    List<Todo>? todos,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TodoCrudState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory TodoCrudState.initial() {
    return const TodoCrudState(todos: [], isLoading: true);
  }
}

final todoCrudViewModelProvider =
    NotifierProvider.autoDispose<TodoCrudViewModel, TodoCrudState>(
  TodoCrudViewModel.new,
);

class TodoCrudViewModel extends Notifier<TodoCrudState> {
  StreamSubscription<List<Todo>>? _subscription;

  @override
  TodoCrudState build() {
    state = TodoCrudState.initial();
    _subscription?.cancel();
    final repository = ref.read(todoRepositoryProvider);
    _subscription = repository.watchTodos().listen(
      (todos) {
        state = state.copyWith(todos: todos, isLoading: false, errorMessage: null);
      },
      onError: (error, stackTrace) {
        state = state.copyWith(isLoading: false, errorMessage: error.toString());
      },
    );
    ref.onDispose(() => _subscription?.cancel());
    return state;
  }

  Future<void> addTodo(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      state = state.copyWith(errorMessage: 'タイトルを入力してください');
      return;
    }
    await ref.read(todoRepositoryProvider).addTodo(trimmed);
  }

  Future<void> updateTodo(Todo todo, String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      state = state.copyWith(errorMessage: 'タイトルを入力してください');
      return;
    }
    await ref.read(todoRepositoryProvider).updateTodo(todo.copyWith(title: trimmed));
  }

  Future<void> deleteTodo(int id) async {
    await ref.read(todoRepositoryProvider).deleteTodo(id);
  }
}
