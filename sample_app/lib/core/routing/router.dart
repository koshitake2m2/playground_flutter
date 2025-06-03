import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/features/counter/counter_page.dart';
import 'package:sample_app/features/home/home_page.dart';
import 'package:sample_app/features/ui_state/ui_state_page.dart';

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
    GoRoute(
      path: '/counter',
      builder:
          (BuildContext context, GoRouterState state) => const CounterPage(),
    ),
    GoRoute(
      path: '/ui_state',
      builder:
          (BuildContext context, GoRouterState state) => const UiStatePage(),
    ),
  ],
);

GoRouter getRouter() {
  return _router;
}
