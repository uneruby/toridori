import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/model/label_state.dart';

class LabelStateNotifier extends StateNotifier<Label> {
  LabelStateNotifier() : super(Label("documentation"));

  setLabel(String labelName){
    state = state.copyWith(name: labelName);
  }
}

final labelProvider =
    StateNotifierProvider.autoDispose<LabelStateNotifier, Label>(
  (ref) => LabelStateNotifier(),
);