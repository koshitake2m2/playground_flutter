import 'package:riverpod/riverpod.dart';

class ShellCounterState {
  const ShellCounterState({required this.count});

  final int count;

  ShellCounterState copyWith({int? count}) {
    return ShellCounterState(count: count ?? this.count);
  }
}

final shellCounterViewModelProvider = NotifierProvider<ShellCounterViewModel, ShellCounterState>(
  ShellCounterViewModel.new,
);

class ShellCounterViewModel extends Notifier<ShellCounterState> {
  @override
  ShellCounterState build() {
    return const ShellCounterState(count: 0);
  }

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}
