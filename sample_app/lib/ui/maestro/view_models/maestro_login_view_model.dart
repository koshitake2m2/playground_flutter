import 'package:riverpod/riverpod.dart';

class MaestroLoginState {
  const MaestroLoginState({
    required this.username,
    required this.password,
    this.errorMessage,
  });

  final String username;
  final String password;
  final String? errorMessage;

  MaestroLoginState copyWith({
    String? username,
    String? password,
    String? errorMessage,
  }) {
    return MaestroLoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      errorMessage: errorMessage,
    );
  }

  factory MaestroLoginState.initial() {
    return const MaestroLoginState(username: '', password: '');
  }
}

final maestroLoginViewModelProvider =
    NotifierProvider.autoDispose<MaestroLoginViewModel, MaestroLoginState>(
      MaestroLoginViewModel.new,
    );

class MaestroLoginViewModel extends Notifier<MaestroLoginState> {
  static const _dummyUsername = 'demo';
  static const _dummyPassword = 'password';

  @override
  MaestroLoginState build() {
    return MaestroLoginState.initial();
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username, errorMessage: null);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password, errorMessage: null);
  }

  bool login() {
    if (state.username == _dummyUsername && state.password == _dummyPassword) {
      state = state.copyWith(errorMessage: null);
      return true;
    }

    state = state.copyWith(errorMessage: 'username または password が違います');
    return false;
  }
}
