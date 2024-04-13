import 'package:articles_app/router/router.dart';
import 'package:articles_app/src/database/database_di.dart';
import 'package:articles_app/src/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
  Log.info('App started');
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useOnAppLifecycleStateChange(createLifecycleCallback(ref));
    // final state = useAppLifecycleState();
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }

  LifecycleCallback createLifecycleCallback(WidgetRef ref) {
    return (
      AppLifecycleState? previous,
      AppLifecycleState current,
    ) {
      switch (current) {
        case AppLifecycleState.resumed:
          Log.info('AppLifecycleState.resumed');
          break;
        case AppLifecycleState.inactive:
          Log.info('AppLifecycleState.inactive');
          break;
        case AppLifecycleState.paused:
          Log.info('AppLifecycleState.paused');
          break;
        case AppLifecycleState.detached:
          Log.info('AppLifecycleState.detached');
          onDetached(ref);
          break;
        case AppLifecycleState.hidden:
          Log.info('AppLifecycleState.hidden');
          break;
      }
    };
  }

  Future<void> onDetached(WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    await db.close();
    Log.info('Database closed');
  }
}
