// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class GridItem {
  Color? backgroundColor;
  String? text;
  IconData? icon;
  GridItem({
    this.backgroundColor,
    this.text,
    this.icon,
  });

  GridItem copyWith({
    Color? backgroundColor,
    String? text,
    IconData? icon,
  }) {
    return GridItem(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      text: text ?? this.text,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backgroundColor': backgroundColor?.value,
      'text': text,
      'icon': icon?.codePoint,
    };
  }

  factory GridItem.fromMap(Map<String, dynamic> map) {
    return GridItem(
      backgroundColor: map['backgroundColor'] != null ? Color(map['backgroundColor'] as int) : null,
      text: map['text'] != null ? map['text'] as String : null,
      icon: map['icon'] != null ? IconData(map['icon'] as int, fontFamily: 'MaterialIcons') : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GridItem.fromJson(String source) => GridItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GridItem(backgroundColor: $backgroundColor, text: $text, icon: $icon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GridItem &&
      other.backgroundColor == backgroundColor &&
      other.text == text &&
      other.icon == icon;
  }

  @override
  int get hashCode => backgroundColor.hashCode ^ text.hashCode ^ icon.hashCode;
}
