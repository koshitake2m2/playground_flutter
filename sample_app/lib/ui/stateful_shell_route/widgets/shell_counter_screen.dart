import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/shell_counter_view_model.dart';

class ShellCounterScreen extends ConsumerWidget {
  const ShellCounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shellCounterViewModelProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: ${state.count}', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.read(shellCounterViewModelProvider.notifier).increment(),
            child: const Text('Increment'),
          ),
        ],
      ),
    );
  }
}
