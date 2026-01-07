import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/data/repositories/todo_repository.dart';
import 'package:sample_app/ui/todo_crud/view_models/todo_crud_view_model.dart';
import '../../testing/fakes/fake_todo_repository.dart';

void main() {
  test('adds todo and updates state', () async {
    final fakeRepository = FakeTodoRepository();
    final container = ProviderContainer(
      overrides: [
        todoRepositoryProvider.overrideWithValue(fakeRepository),
      ],
    );
    final sub = container.listen(todoCrudViewModelProvider, (_, __) {});
    addTearDown(() {
      sub.close();
      fakeRepository.dispose();
      container.dispose();
    });

    final viewModel = container.read(todoCrudViewModelProvider.notifier);
    await viewModel.addTodo('買い物');
    await Future<void>.delayed(Duration.zero);

    final state = container.read(todoCrudViewModelProvider);
    expect(state.todos.length, 1);
    expect(state.todos.first.title, '買い物');
  });
}
