import 'package:riverpod/riverpod.dart';

class ShellNotesState {
  const ShellNotesState({required this.notes});

  final String notes;

  ShellNotesState copyWith({String? notes}) {
    return ShellNotesState(notes: notes ?? this.notes);
  }
}

final shellNotesViewModelProvider = NotifierProvider<ShellNotesViewModel, ShellNotesState>(
  ShellNotesViewModel.new,
);

class ShellNotesViewModel extends Notifier<ShellNotesState> {
  @override
  ShellNotesState build() {
    return const ShellNotesState(notes: '');
  }

  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }
}
