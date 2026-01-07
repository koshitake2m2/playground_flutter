import 'package:test/test.dart';

import 'package:sample_app/data/repositories/demo_page_repository.dart';
import 'package:sample_app/data/services/demo_page_service.dart';
import 'package:sample_app/domain/models/demo_page.dart';

class _FakeDemoPageService implements DemoPageService {
  _FakeDemoPageService(this.pages);

  final List<DemoPage> pages;

  @override
  List<DemoPage> getDemoPages() => pages;
}

void main() {
  test('fetchDemoPages returns pages from service', () async {
    final repository = DemoPageRepositoryImpl(
      _FakeDemoPageService(
        const [DemoPage(name: 'TODO CRUD', route: '/todo')],
      ),
    );

    final pages = await repository.fetchDemoPages();

    expect(pages.single.name, 'TODO CRUD');
  });
}
