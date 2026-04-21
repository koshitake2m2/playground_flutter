import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../util/page_visible_subscription.dart';
import 'shell_page_app_bar.dart';

class ShellRandomDetailScreen extends StatefulWidget {
  const ShellRandomDetailScreen({required this.num, super.key});

  final String num;

  @override
  State<ShellRandomDetailScreen> createState() =>
      _ShellRandomDetailScreenState();
}

class _ShellRandomDetailScreenState extends State<ShellRandomDetailScreen> {
  final Random _random = Random();
  PageVisibleSubscription? _subscription;
  int _oneTimeRandomValue = 0;
  int _subscriptionRandomValue = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _subscription = subscribePageVisible(
        context: context,
        onVisible: _refreshSubscriptionRandomValue,
      );
      _generateOneTimeRandomValueOnce();
      _refreshSubscriptionRandomValue();
    });
  }

  @override
  void dispose() {
    _subscription?.dispose();
    super.dispose();
  }

  int _nextValue() {
    return _random.nextInt(100) + 1;
  }

  void _generateOneTimeRandomValueOnce() {
    setState(() {
      _oneTimeRandomValue = _nextValue();
    });
  }

  void _refreshSubscriptionRandomValue() {
    if (!mounted) {
      return;
    }
    setState(() {
      _subscriptionRandomValue = _nextValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildShellPageAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Path num: ${widget.num}'),
              const SizedBox(height: 8),
              Text('Without subscribe (post frame once): $_oneTimeRandomValue'),
              const SizedBox(height: 8),
              Text('With subscribePageVisible: $_subscriptionRandomValue'),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => context.go('/shell/random'),
                child: const Text('Back to /shell/random'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
