import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'todo_model.dart';
import 'todo_provider.dart';

class TodoPage extends HookConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(filteredTodoListProvider);
    // TODO: You should use useState instead of Provider.
    final filter = ref.watch(todoFilterProvider);
    final filterController = useTextEditingController(text: filter);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              decoration: const InputDecoration(
                labelText: 'Filter by title',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(todoFilterProvider.notifier).update(value);
              },
            ),
          ),
          Expanded(
            child: todosAsync.when(
              data:
                  (todos) => ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                final newTitle = await showDialog<String>(
                                  context: context,
                                  builder:
                                      (context) =>
                                          _TodoEditDialog(initial: todo.title),
                                );
                                if (newTitle != null &&
                                    newTitle.trim().isNotEmpty) {
                                  await ref
                                      .read(todoListProvider.notifier)
                                      .edit(
                                        Todo(
                                          id: todo.id,
                                          title: newTitle.trim(),
                                        ),
                                      );
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await ref
                                    .read(todoListProvider.notifier)
                                    .delete(todo.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showDialog<String>(
            context: context,
            builder: (context) => const _TodoEditDialog(),
          );
          if (title != null && title.trim().isNotEmpty) {
            await ref
                .read(todoListProvider.notifier)
                .add(Todo(id: const Uuid().v4(), title: title.trim()));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TodoEditDialog extends StatefulWidget {
  final String? initial;
  const _TodoEditDialog({this.initial});

  @override
  State<_TodoEditDialog> createState() => _TodoEditDialogState();
}

class _TodoEditDialogState extends State<_TodoEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initial == null ? 'Add Todo' : 'Edit Todo'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Title'),
        onSubmitted: (value) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _submit, child: const Text('OK')),
      ],
    );
  }

  void _submit() {
    Navigator.of(context).pop(_controller.text);
  }
}
