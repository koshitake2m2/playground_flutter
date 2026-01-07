import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/todo.dart';
import '../view_models/todo_crud_view_model.dart';

class TodoCrudScreen extends ConsumerWidget {
  const TodoCrudScreen({super.key});

  Future<void> _showTodoDialog(
    BuildContext context,
    WidgetRef ref, {
    Todo? todo,
  }) async {
    final controller = TextEditingController(text: todo?.title ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(todo == null ? 'TODOを追加' : 'TODOを編集'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'タイトル'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('保存'),
          ),
        ],
      ),
    );

    if (result == null) {
      return;
    }

    final viewModel = ref.read(todoCrudViewModelProvider.notifier);
    if (todo == null) {
      await viewModel.addTodo(result);
    } else {
      await viewModel.updateTodo(todo, result);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoCrudViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO CRUD'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
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
                : state.todos.isEmpty
                    ? const Center(child: Text('TODOがありません'))
                    : ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          final todo = state.todos[index];
                          return ListTile(
                            title: Text(todo.title),
                            leading: const Icon(Icons.check_box_outline_blank),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showTodoDialog(
                                    context,
                                    ref,
                                    todo: todo,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => ref
                                      .read(todoCrudViewModelProvider.notifier)
                                      .deleteTodo(todo.id),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
