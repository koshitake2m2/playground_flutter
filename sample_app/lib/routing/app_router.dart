import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../ui/home/widgets/home_screen.dart';
import '../ui/stateful_shell_route/widgets/shell_counter_screen.dart';
import '../ui/stateful_shell_route/widgets/shell_random_detail_screen.dart';
import '../ui/stateful_shell_route/widgets/shell_random_hooks_screen.dart';
import '../ui/stateful_shell_route/widgets/shell_random_screen.dart';
import '../ui/stateful_shell_route/widgets/shell_notes_screen.dart';
import '../ui/stateful_shell_route/widgets/stateful_shell_route_screen.dart';
import '../ui/todo_crud/widgets/todo_crud_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/todo',
        name: 'todo',
        builder: (context, state) => const TodoCrudScreen(),
      ),
      GoRoute(path: '/shell', redirect: (_, state) => '/shell/counter'),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            StatefulShellRouteScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shell/counter',
                name: 'shell-counter',
                builder: (context, state) => const ShellCounterScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shell/notes',
                name: 'shell-notes',
                builder: (context, state) => const ShellNotesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shell/random',
                name: 'shell-random',
                builder: (context, state) => const ShellRandomScreen(),
                routes: [
                  GoRoute(
                    path: ':num',
                    name: 'shell-random-detail',
                    builder: (context, state) => ShellRandomDetailScreen(
                      num: state.pathParameters['num'] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/shell/random_hooks',
                name: 'shell-random-hooks',
                builder: (context, state) => const ShellRandomHooksScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
