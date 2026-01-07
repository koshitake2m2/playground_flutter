import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/shell_notes_view_model.dart';

class ShellNotesScreen extends ConsumerStatefulWidget {
  const ShellNotesScreen({super.key});

  @override
  ConsumerState<ShellNotesScreen> createState() => _ShellNotesScreenState();
}

class _ShellNotesScreenState extends ConsumerState<ShellNotesScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final notes = ref.read(shellNotesViewModelProvider).notes;
    _controller = TextEditingController(text: notes);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shellNotesViewModelProvider);
    if (_controller.text != state.notes) {
      _controller.value = _controller.value.copyWith(
        text: state.notes,
        selection: TextSelection.collapsed(offset: state.notes.length),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notes (state should persist across tabs)'),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 5,
            onChanged: (value) =>
                ref.read(shellNotesViewModelProvider.notifier).updateNotes(value),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'メモを入力してください',
            ),
          ),
        ],
      ),
    );
  }
}
