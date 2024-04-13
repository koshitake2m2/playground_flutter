import 'dart:io';

import 'package:articles_app/router/router.dart';
import 'package:articles_app/src/database/database_di.dart';
import 'package:articles_app/src/utils/log.dart';
import 'package:flutter/material.dart';
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
      callbackByState(current)(ref);
    };
  }

  Future<void> Function(WidgetRef) callbackByState(AppLifecycleState current) {
    return (WidgetRef ref) {
      switch (current) {
        case AppLifecycleState.resumed:
          return onResumed(ref);
        case AppLifecycleState.inactive:
          return onInactive(ref);
        case AppLifecycleState.paused:
          return onPaused(ref);
        case AppLifecycleState.detached:
          return onDetached(ref);
        case AppLifecycleState.hidden:
          return onHidden(ref);
      }
    };
  }

  Future<void> onResumed(WidgetRef ref) async {
    Log.info('AppLifecycleState.resumed');
  }

  Future<void> onInactive(WidgetRef ref) async {
    Log.info('AppLifecycleState.inactive');
  }

  Future<void> onPaused(WidgetRef ref) async {
    Log.info('AppLifecycleState.paused');
  }

  Future<void> onDetached(WidgetRef ref) async {
    Log.info('AppLifecycleState.detached');
    final db = ref.read(databaseProvider);
    await db.close();
    Log.info('Database closed');
  }

  Future<void> onHidden(WidgetRef ref) async {
    Log.info('AppLifecycleState.hidden');
  }
}
