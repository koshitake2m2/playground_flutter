import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/ui/stateful_shell_route/view_models/shell_notes_view_model.dart';

void main() {
  test('updates notes', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(shellNotesViewModelProvider.notifier);
    notifier.updateNotes('メモ');

    final state = container.read(shellNotesViewModelProvider);
    expect(state.notes, 'メモ');
  });
}
