import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/ui/stateful_shell_route/view_models/shell_counter_view_model.dart';

void main() {
  test('increments counter', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(shellCounterViewModelProvider.notifier);
    notifier.increment();

    final state = container.read(shellCounterViewModelProvider);
    expect(state.count, 1);
  });
}
