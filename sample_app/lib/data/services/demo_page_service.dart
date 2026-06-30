import 'package:riverpod/riverpod.dart';

import '../../domain/models/demo_page.dart';

abstract class DemoPageService {
  List<DemoPage> getDemoPages();
}

class StaticDemoPageService implements DemoPageService {
  @override
  List<DemoPage> getDemoPages() {
    return const [
      DemoPage(name: 'TODO CRUD', route: '/todo'),
      DemoPage(name: 'StatefulShellRoute', route: '/shell/counter'),
      DemoPage(name: 'Maestro Sample', route: '/maestro/login'),
    ];
  }
}

final demoPageServiceProvider = Provider<DemoPageService>(
  (ref) => StaticDemoPageService(),
);
