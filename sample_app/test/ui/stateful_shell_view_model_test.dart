import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/ui/stateful_shell_route/view_models/stateful_shell_view_model.dart';

void main() {
  test('updates current index', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(statefulShellViewModelProvider.notifier);
    notifier.setIndex(1);

    final state = container.read(statefulShellViewModelProvider);
    expect(state.currentIndex, 1);
  });
}
