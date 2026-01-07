import 'package:riverpod/riverpod.dart';

import '../../domain/models/demo_page.dart';
import '../services/demo_page_service.dart';

abstract class DemoPageRepository {
  Future<List<DemoPage>> fetchDemoPages();
}

class DemoPageRepositoryImpl implements DemoPageRepository {
  DemoPageRepositoryImpl(this._service);

  final DemoPageService _service;

  @override
  Future<List<DemoPage>> fetchDemoPages() async {
    return _service.getDemoPages();
  }
}

final demoPageRepositoryProvider = Provider<DemoPageRepository>(
  (ref) => DemoPageRepositoryImpl(ref.watch(demoPageServiceProvider)),
);
