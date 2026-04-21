import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../hooks/router_hook.dart';

class ShellRandomHooksScreen extends HookWidget {
  const ShellRandomHooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final random = useMemoized(Random.new);
    final oneTimeRandomValue = useState(0);
    final hookRandomValue = useState(0);

    void generateOneTimeRandomValueLater() {
      Future<void>(() {
        if (!context.mounted) {
          return;
        }
        oneTimeRandomValue.value = random.nextInt(100) + 1;
      });
    }

    void refreshHookRandomValueLater() {
      Future<void>(() {
        if (!context.mounted) {
          return;
        }
        hookRandomValue.value = random.nextInt(100) + 1;
      });
    }

    useEffect(() {
      generateOneTimeRandomValueLater();
      return null;
    }, const []);

    useEffectOnPageVisible(refreshHookRandomValueLater);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Without hook (useEffect once): ${oneTimeRandomValue.value}'),
          const SizedBox(height: 8),
          Text('With useEffectOnPageVisible: ${hookRandomValue.value}'),
        ],
      ),
    );
  }
}
