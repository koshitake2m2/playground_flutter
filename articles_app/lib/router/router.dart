import 'package:articles_app/src/pages/counter_page.dart';
import 'package:articles_app/src/pages/home_page.dart';
import 'package:articles_app/src/pages/posts_page.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'posts',
          builder: (BuildContext context, GoRouterState state) {
            return const PostsPage();
          },
        ),
        GoRoute(
          path: 'counter',
          builder: (BuildContext context, GoRouterState state) {
            return const CounterPage(
              title: 'COUNTER',
            );
          },
        ),
      ],
    ),
  ],
);
