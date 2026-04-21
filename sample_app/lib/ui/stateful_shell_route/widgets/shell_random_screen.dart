import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../util/page_visible_subscription.dart';

class ShellRandomScreen extends StatefulWidget {
  const ShellRandomScreen({super.key});

  @override
  State<ShellRandomScreen> createState() => _ShellRandomScreenState();
}

class _ShellRandomScreenState extends State<ShellRandomScreen> {
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
    final detailNum = _subscriptionRandomValue > 0
        ? _subscriptionRandomValue
        : 0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Without subscribe (post frame once): $_oneTimeRandomValue'),
          const SizedBox(height: 8),
          Text('With subscribePageVisible: $_subscriptionRandomValue'),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => context.go('/shell/random/$detailNum'),
            child: const Text('Open /shell/random/:num'),
          ),
        ],
      ),
    );
  }
}
