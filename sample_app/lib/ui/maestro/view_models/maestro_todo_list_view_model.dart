import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../../../data/repositories/todo_repository.dart';
import '../../../domain/models/todo.dart';

class MaestroTodoListState {
  const MaestroTodoListState({
    required this.todos,
    required this.isLoading,
    this.errorMessage,
  });

  final List<Todo> todos;
  final bool isLoading;
  final String? errorMessage;

  MaestroTodoListState copyWith({
    List<Todo>? todos,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MaestroTodoListState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory MaestroTodoListState.initial() {
    return const MaestroTodoListState(todos: [], isLoading: true);
  }
}

final maestroTodoListViewModelProvider =
    NotifierProvider.autoDispose<
      MaestroTodoListViewModel,
      MaestroTodoListState
    >(MaestroTodoListViewModel.new);

class MaestroTodoListViewModel extends Notifier<MaestroTodoListState> {
  StreamSubscription<List<Todo>>? _subscription;

  @override
  MaestroTodoListState build() {
    state = MaestroTodoListState.initial();
    _subscription?.cancel();
    final repository = ref.read(todoRepositoryProvider);
    _subscription = repository.watchTodos().listen(
      (todos) {
        state = state.copyWith(
          todos: todos,
          isLoading: false,
          errorMessage: null,
        );
      },
      onError: (error, stackTrace) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      },
    );
    ref.onDispose(() => _subscription?.cancel());
    return state;
  }
}
