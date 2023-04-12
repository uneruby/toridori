import 'package:freezed_annotation/freezed_annotation.dart';

part 'label_state.freezed.dart';

@freezed
class Label with _$Label {
  const factory Label({required String? name}) = _Label;

  factory Label.fromName(String? name) {
    return Label(name: name);
  }
}