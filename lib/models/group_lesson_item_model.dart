// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GroupLessonItem {
  String? text;
  String? imageUrl;
  Function? onTap;
  GroupLessonItem({
    this.text,
    this.imageUrl,
    this.onTap,
  });

  GroupLessonItem copyWith({
    String? text,
    String? imageUrl,
    Function? onTap,
  }) {
    return GroupLessonItem(
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      onTap: onTap ?? this.onTap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'imageUrl': imageUrl,
    };
  }

  factory GroupLessonItem.fromMap(Map<String, dynamic> map) {
    return GroupLessonItem(
      text: map['text'] != null ? map['text'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupLessonItem.fromJson(String source) =>
      GroupLessonItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GroupLessonItem(text: $text, imageUrl: $imageUrl, onTap: $onTap)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupLessonItem &&
        other.text == text &&
        other.imageUrl == imageUrl &&
        other.onTap == onTap;
  }

  @override
  int get hashCode => text.hashCode ^ imageUrl.hashCode ^ onTap.hashCode;
}
