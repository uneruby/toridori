import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/model/label_state.dart';

class LabelStateNotifier extends StateNotifier<Label> {
  LabelStateNotifier() : super(Label(name: null));

  Future setLabel(String? labelName) async {
    state = state.copyWith(name: labelName);
  }
}

final labelProvider =
    StateNotifierProvider.autoDispose<LabelStateNotifier, Label>(
  (ref) => LabelStateNotifier(),
);