import 'package:sample_app/data/repositories/demo_page_repository.dart';
import 'package:sample_app/domain/models/demo_page.dart';

class FakeDemoPageRepository implements DemoPageRepository {
  FakeDemoPageRepository({List<DemoPage>? pages})
      : _pages = pages ?? const [];

  final List<DemoPage> _pages;

  @override
  Future<List<DemoPage>> fetchDemoPages() async => _pages;
}
