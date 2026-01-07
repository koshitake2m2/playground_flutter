import 'package:sample_app/data/services/demo_page_service.dart';
import 'package:sample_app/domain/models/demo_page.dart';

class FakeDemoPageService implements DemoPageService {
  FakeDemoPageService({List<DemoPage>? pages})
      : _pages = pages ?? const [
          DemoPage(name: 'TODO CRUD', route: '/todo'),
          DemoPage(name: 'StatefulShellRoute', route: '/shell/counter'),
        ];

  final List<DemoPage> _pages;

  @override
  List<DemoPage> getDemoPages() => _pages;
}
