import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view_models/maestro_todo_list_view_model.dart';
import '../widgets/maestro_todo_list.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maestroTodoListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maestro TODO List'),
        leading: Semantics(
          identifier: 'back_button_in_todo_list_screen',
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/maestro/login'),
          ),
        ),
        actions: [
          TextButton(
            key: const Key('maestro_logout_button'),
            onPressed: () => context.go('/maestro/login'),
            child: const Text('Logout'),
          ),
        ],
      ),
      body: Column(
        children: [
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : MaestroTodoList(todos: state.todos),
          ),
        ],
      ),
    );
  }
}
