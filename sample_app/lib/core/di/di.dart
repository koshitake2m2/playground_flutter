import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sample_app/core/routing/router.dart';

//////////////////////////
/// core
/// //////////////////////
final routerProvider = Provider<GoRouter>((ref) {
  return getRouter();
});
