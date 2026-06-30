import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/data/repositories/todo_repository.dart';
import 'package:sample_app/ui/maestro/view_models/maestro_todo_list_view_model.dart';
import '../../testing/fakes/fake_todo_repository.dart';

void main() {
  test('updates state when todo stream emits', () async {
    final fakeRepository = FakeTodoRepository();
    final container = ProviderContainer(
      overrides: [todoRepositoryProvider.overrideWithValue(fakeRepository)],
    );
    final sub = container.listen(maestroTodoListViewModelProvider, (_, __) {});
    addTearDown(() {
      sub.close();
      fakeRepository.dispose();
      container.dispose();
    });

    await fakeRepository.addTodo('テストTODO');
    await Future<void>.delayed(Duration.zero);

    final state = container.read(maestroTodoListViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.todos.length, 1);
    expect(state.todos.first.title, 'テストTODO');
  });
}
