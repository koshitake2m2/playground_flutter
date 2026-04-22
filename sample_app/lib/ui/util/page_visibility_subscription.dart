import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PageVisibilitySubscription {
  final VoidCallback _unsubscribe;

  PageVisibilitySubscription(this._unsubscribe);

  void dispose() {
    _unsubscribe();
  }

  static PageVisibilitySubscription listen({
    required BuildContext context,
    required VoidCallback onVisible,
  }) {
    final router = GoRouter.of(context);
    final target =
        router.routerDelegate.currentConfiguration.last.matchedLocation;
    String? prev;
    print('Subscribing to page visibility for $target');

    void listener() {
      print('Checking page visibility for $target');
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
    return PageVisibilitySubscription(() {
      router.routerDelegate.removeListener(listener);
      print('Unsubscribed from page visibility for $target');
    });
  }
}
