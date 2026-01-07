import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:sample_app/data/repositories/demo_page_repository.dart';
import 'package:sample_app/domain/models/demo_page.dart';
import 'package:sample_app/ui/home/view_models/home_view_model.dart';

class _FakeDemoPageRepository implements DemoPageRepository {
  _FakeDemoPageRepository(this.pages);

  final List<DemoPage> pages;

  @override
  Future<List<DemoPage>> fetchDemoPages() async => pages;
}

void main() {
  test('loads demo pages into state', () async {
    final container = ProviderContainer(
      overrides: [
        demoPageRepositoryProvider.overrideWithValue(
          _FakeDemoPageRepository(
            const [
              DemoPage(name: 'TODO CRUD', route: '/todo'),
              DemoPage(name: 'StatefulShellRoute', route: '/shell/counter'),
            ],
          ),
        ),
      ],
    );
    final sub = container.listen(homeViewModelProvider, (_, __) {});
    addTearDown(() {
      sub.close();
      container.dispose();
    });

    await container.read(homeViewModelProvider.notifier).load();
    final state = container.read(homeViewModelProvider);

    expect(state.isLoading, isFalse);
    expect(state.pages.length, 2);
  });
}
