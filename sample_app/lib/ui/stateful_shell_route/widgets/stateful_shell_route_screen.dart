import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatefulShellRouteScreen extends StatelessWidget {
  const StatefulShellRouteScreen({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(child: navigationShell),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: navigationShell.currentIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
            onTap: (index) {
              final isCurrentBranch = index == navigationShell.currentIndex;
              navigationShell.goBranch(index, initialLocation: isCurrentBranch);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.exposure_plus_1),
                label: 'Counter',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
              BottomNavigationBarItem(
                icon: Icon(Icons.casino),
                label: 'Random',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.casino_outlined),
                label: 'RandomHooks',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
