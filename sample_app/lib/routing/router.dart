import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/ui/counter/counter_page.dart';
import 'package:sample_app/ui/home/home_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
    GoRoute(
      path: '/counter',
      builder:
          (BuildContext context, GoRouterState state) =>
              const CounterPage(title: 'Flutter Demo Counter Page'),
    ),
  ],
);
