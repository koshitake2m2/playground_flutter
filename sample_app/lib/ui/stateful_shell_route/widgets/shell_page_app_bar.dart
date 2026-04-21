import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget buildShellPageAppBar(
  BuildContext context, {
  String title = 'StatefulShellRoute',
}) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (context.canPop()) {
          context.pop();
          return;
        }
        context.go('/');
      },
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.home),
        onPressed: () => context.go('/'),
      ),
    ],
  );
}
