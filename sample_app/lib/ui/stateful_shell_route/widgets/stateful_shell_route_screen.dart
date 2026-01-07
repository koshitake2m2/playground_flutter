import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view_models/stateful_shell_view_model.dart';

class StatefulShellRouteScreen extends ConsumerWidget {
  const StatefulShellRouteScreen({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(statefulShellViewModelProvider.notifier);
    viewModel.syncWith(navigationShell.currentIndex);
    final state = ref.watch(statefulShellViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StatefulShellRoute'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.currentIndex,
        onTap: (index) {
          viewModel.setIndex(index);
          navigationShell.goBranch(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.exposure_plus_1),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}
