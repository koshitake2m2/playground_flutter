import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/ui/maestro/view_models/maestro_login_view_model.dart';

void main() {
  test('login succeeds with dummy credentials', () {
    final container = ProviderContainer();
    final sub = container.listen(maestroLoginViewModelProvider, (_, __) {});
    addTearDown(() {
      sub.close();
      container.dispose();
    });

    final viewModel = container.read(maestroLoginViewModelProvider.notifier);
    viewModel.updateUsername('demo');
    viewModel.updatePassword('password');

    final isSuccess = viewModel.login();
    final state = container.read(maestroLoginViewModelProvider);

    expect(isSuccess, isTrue);
    expect(state.errorMessage, isNull);
  });

  test('login fails with invalid credentials', () {
    final container = ProviderContainer();
    final sub = container.listen(maestroLoginViewModelProvider, (_, __) {});
    addTearDown(() {
      sub.close();
      container.dispose();
    });

    final viewModel = container.read(maestroLoginViewModelProvider.notifier);
    viewModel.updateUsername('wrong');
    viewModel.updatePassword('credentials');

    final isSuccess = viewModel.login();
    final state = container.read(maestroLoginViewModelProvider);

    expect(isSuccess, isFalse);
    expect(state.errorMessage, isNotNull);
  });
}
