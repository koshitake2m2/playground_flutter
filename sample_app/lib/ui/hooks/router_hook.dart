import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

void useEffectOnPageVisible(void Function() onVisible) {
  final context = useContext();
  final router = GoRouter.of(context);
  final target =
      router.routerDelegate.currentConfiguration.last.matchedLocation;

  final prev = useRef<String?>(null);

  void listener() {
    final current =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
    if (current != prev.value) {
      prev.value = current;
      if (current == target) {
        onVisible();
      }
    }
  }

  useEffect(() {
    onVisible();
    router.routerDelegate.addListener(listener);
    return () => router.routerDelegate.removeListener(listener);
  }, []);
}
