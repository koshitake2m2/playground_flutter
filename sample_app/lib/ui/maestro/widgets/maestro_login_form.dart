import 'package:flutter/material.dart';

class MaestroLoginForm extends StatelessWidget {
  const MaestroLoginForm({
    super.key,
    required this.username,
    required this.password,
    required this.errorMessage,
    required this.onUsernameChanged,
    required this.onPasswordChanged,
    required this.onLoginPressed,
  });

  final String username;
  final String password;
  final String? errorMessage;
  final ValueChanged<String> onUsernameChanged;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Maestro Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Semantics(
            identifier: 'username_text_form_field',
            child: TextFormField(
              key: const Key('maestro_username_field'),
              initialValue: username,
              onChanged: onUsernameChanged,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Semantics(
            identifier: 'password_text_form_field',
            child: TextFormField(
              key: const Key('maestro_password_field'),
              initialValue: password,
              onChanged: onPasswordChanged,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                errorMessage!,
                key: const Key('maestro_login_error_text'),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ElevatedButton(
            key: const Key('maestro_login_button'),
            onPressed: onLoginPressed,
            child: const Text('Login'),
          ),
          const SizedBox(height: 12),
          const Text(
            'dummy username: demo / password: password',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
