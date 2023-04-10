import 'package:freezed_annotation/freezed_annotation.dart';
part 'label_state.freezed.dart';

@freezed
class Label with _$Label {
  const factory Label(String name) = _Label;

  // Label({@Default(null) String? name});

  // factory Label.fromNullable(String? name) {
  //   return Label(name: name);
  // }

  // @override
  // final String? name;
}