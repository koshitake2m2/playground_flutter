import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PageVisibleSubscription {
  final VoidCallback _unsubscribe;

  PageVisibleSubscription(this._unsubscribe);

  void dispose() {
    _unsubscribe();
  }
}

PageVisibleSubscription subscribePageVisible({
  required BuildContext context,
  required VoidCallback onVisible,
}) {
  final router = GoRouter.of(context);
  final target =
      router.routerDelegate.currentConfiguration.last.matchedLocation;
  String? prev;
  print('Subscribing to page visibility for $target');

  void listener() {
    final current =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
    if (current != prev) {
      prev = current;
      if (current == target) {
        onVisible();
      }
    }
  }

  router.routerDelegate.addListener(listener);
  return PageVisibleSubscription(
    () => router.routerDelegate.removeListener(listener),
  );
}
