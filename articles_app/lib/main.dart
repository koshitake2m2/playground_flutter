import 'package:articles_app/router/router.dart';
import 'package:articles_app/src/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/database/migration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await database.into(database.authors).insert(AuthorsCompanion.insert(
        name: 'Hello',
      ));
  List<Author> allItems = await database.select(database.authors).get();

  Log.info('items in database: $allItems');
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
