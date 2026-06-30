import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../view_models/maestro_login_view_model.dart';
import '../widgets/maestro_login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(maestroLoginViewModelProvider);
    final viewModel = ref.read(maestroLoginViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maestro Login'),
        leading: Semantics(
          identifier: 'back_button',
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
      ),
      body: SafeArea(
        child: MaestroLoginForm(
          username: state.username,
          password: state.password,
          errorMessage: state.errorMessage,
          onUsernameChanged: viewModel.updateUsername,
          onPasswordChanged: viewModel.updatePassword,
          onLoginPressed: () {
            final isSuccess = viewModel.login();
            if (isSuccess) {
              context.go('/maestro/todos');
            }
          },
        ),
      ),
    );
  }
}
