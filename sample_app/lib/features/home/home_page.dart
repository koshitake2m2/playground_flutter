import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = [
      {'name': 'Home', 'path': '/'},
      {'name': 'Counter', 'path': '/counter'},
      {'name': 'UI State', 'path': '/ui_state'},
      {'name': 'todo_riverpod', 'path': '/todo_riverpod'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('URL List')),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return ListTile(
            title: Text(route['name']!),
            subtitle: Text(route['path']!),
            onTap: () => context.go(route['path']!),
          );
        },
      ),
    );
  }
}
