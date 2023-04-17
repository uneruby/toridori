import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toridori/model/label_state.dart';

List<String?> labelName = [
  null,
  'p: webview',
  'p: shared_preferences',
  'waiting for customer response',
  'severe: new feature',
  'p: share',
];

class LabelStateNotifier extends StateNotifier<Label> {
  LabelStateNotifier() : super(Label(name: null));

  Future setLabel(int? index) async {
    state = state.copyWith(name: labelName[index!]);
  }
}

final labelProvider =
    StateNotifierProvider.autoDispose<LabelStateNotifier, Label>(
  (ref) => LabelStateNotifier(),
);