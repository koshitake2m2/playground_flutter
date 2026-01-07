import 'package:test/test.dart';

import 'package:sample_app/data/repositories/todo_repository.dart';
import 'package:sample_app/testing/fakes/fake_todo_local_service.dart';

void main() {
  test('add/update/delete flows through repository', () async {
    final fakeService = FakeTodoLocalService();
    final repository = TodoRepositoryImpl(fakeService);

    addTearDown(fakeService.dispose);

    await repository.addTodo('掃除');
    final afterAdd = await repository.watchTodos().first;
    expect(afterAdd.single.title, '掃除');

    final todo = afterAdd.single.copyWith(title: '洗濯');
    await repository.updateTodo(todo);
    final afterUpdate = await repository.watchTodos().first;
    expect(afterUpdate.single.title, '洗濯');

    await repository.deleteTodo(todo.id);
    final afterDelete = await repository.watchTodos().first;
    expect(afterDelete, isEmpty);
  });
}
