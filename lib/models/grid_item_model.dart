// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class GridItem {
  Color? backgroundColor;
  String? text;
  IconData? icon;
  Function? onTap;

  GridItem({
    this.backgroundColor,
    this.text,
    this.icon,
    this.onTap,
  });

  GridItem copyWith({
    Color? backgroundColor,
    String? text,
    IconData? icon,
    Function? onTap,
  }) {
    return GridItem(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      text: text ?? this.text,
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
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
  String toString() {
    return 'GridItem(backgroundColor: $backgroundColor, text: $text, icon: $icon, onTap: $onTap)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GridItem &&
      other.backgroundColor == backgroundColor &&
      other.text == text &&
      other.icon == icon &&
      other.onTap == onTap;
  }

  @override
  int get hashCode {
    return backgroundColor.hashCode ^
      text.hashCode ^
      icon.hashCode ^
      onTap.hashCode;
  }
}
