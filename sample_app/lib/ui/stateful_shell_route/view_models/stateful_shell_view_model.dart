import 'package:riverpod/riverpod.dart';

class StatefulShellUiState {
  const StatefulShellUiState({required this.currentIndex});

  final int currentIndex;

  StatefulShellUiState copyWith({int? currentIndex}) {
    return StatefulShellUiState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

final statefulShellViewModelProvider = NotifierProvider<StatefulShellViewModel, StatefulShellUiState>(
  StatefulShellViewModel.new,
);

class StatefulShellViewModel extends Notifier<StatefulShellUiState> {
  @override
  StatefulShellUiState build() {
    return const StatefulShellUiState(currentIndex: 0);
  }

  void syncWith(int index) {
    if (state.currentIndex != index) {
      state = state.copyWith(currentIndex: index);
    }
  }

  void setIndex(int index) {
    if (state.currentIndex != index) {
      state = state.copyWith(currentIndex: index);
    }
  }
}
