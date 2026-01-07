import 'package:test/test.dart';

import 'package:sample_app/data/repositories/todo_repository.dart';
import '../../testing/fakes/fake_todo_local_service.dart';

void main() {
  test('add/update/delete flows through repository', () async {
    final fakeService = FakeTodoLocalService();
    final repository = TodoRepositoryImpl(fakeService);

    addTearDown(fakeService.dispose);

    final afterAddFuture = repository.watchTodos().first;
    await repository.addTodo('掃除');
    final afterAdd = await afterAddFuture;
    expect(afterAdd.single.title, '掃除');

    final todo = afterAdd.single.copyWith(title: '洗濯');
    final afterUpdateFuture = repository.watchTodos().first;
    await repository.updateTodo(todo);
    final afterUpdate = await afterUpdateFuture;
    expect(afterUpdate.single.title, '洗濯');

    final afterDeleteFuture = repository.watchTodos().first;
    await repository.deleteTodo(todo.id);
    final afterDelete = await afterDeleteFuture;
    expect(afterDelete, isEmpty);
  });
}
