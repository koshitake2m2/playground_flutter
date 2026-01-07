import 'package:riverpod/riverpod.dart';

import '../../../data/repositories/demo_page_repository.dart';
import '../../../domain/models/demo_page.dart';

class HomeUiState {
  const HomeUiState({
    required this.pages,
    required this.isLoading,
    this.errorMessage,
  });

  final List<DemoPage> pages;
  final bool isLoading;
  final String? errorMessage;

  HomeUiState copyWith({
    List<DemoPage>? pages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeUiState(
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory HomeUiState.loading() {
    return const HomeUiState(pages: [], isLoading: true);
  }
}

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeUiState>(HomeViewModel.new);

class HomeViewModel extends Notifier<HomeUiState> {
  @override
  HomeUiState build() {
    state = HomeUiState.loading();
    load();
    return state;
  }

  Future<void> load() async {
    try {
      final pages = await ref.read(demoPageRepositoryProvider).fetchDemoPages();
      state = state.copyWith(pages: pages, isLoading: false, errorMessage: null);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }
}
