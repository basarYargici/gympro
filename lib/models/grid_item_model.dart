import 'dart:convert';
import 'dart:ui';

class GridItem {
  Color? backgroundColor;
  String? text;
  GridItem({
    this.backgroundColor,
    this.text,
  });

  GridItem copyWith({
    Color? backgroundColor,
    String? text,
  }) {
    return GridItem(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backgroundColor': backgroundColor?.value,
      'text': text,
    };
  }

  factory GridItem.fromMap(Map<String, dynamic> map) {
    return GridItem(
      backgroundColor: map['backgroundColor'] != null
          ? Color(map['backgroundColor'] as int)
          : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GridItem.fromJson(String source) =>
      GridItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GridItem(backgroundColor: $backgroundColor, text: $text)';

  @override
  bool operator ==(covariant GridItem other) {
    if (identical(this, other)) return true;

    return other.backgroundColor == backgroundColor && other.text == text;
  }

  @override
  int get hashCode => backgroundColor.hashCode ^ text.hashCode;
}
