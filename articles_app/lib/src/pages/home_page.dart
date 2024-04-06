import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/posts'),
              child: const Text('posts'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/counter'),
              child: const Text('counter'),
            ),
          )
        ],
      ),
    );
  }
}
