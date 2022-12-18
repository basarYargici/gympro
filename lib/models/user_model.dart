import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'body_model.dart';

class MyUser {
  final String? id;
  final String? mail;
  final List<BodyModel> bodyModel;
  MyUser({
    this.id,
    this.mail,
    required this.bodyModel,
  });

  MyUser copyWith({
    String? id,
    String? mail,
    List<BodyModel>? bodyModel,
  }) {
    return MyUser(
      id: id ?? this.id,
      mail: mail ?? this.mail,
      bodyModel: bodyModel ?? this.bodyModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'mail': mail,
      'bodyModel': bodyModel.map((x) => x.toMap()).toList(),
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'] != null ? map['id'] as String : null,
      mail: map['mail'] != null ? map['mail'] as String : null,
      bodyModel: List<BodyModel>.from(
        map['bodyModel'].map<BodyModel>(
          (x) => BodyModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyUser(id: $id, mail: $mail, bodyModel: $bodyModel)';

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.mail == mail &&
        listEquals(other.bodyModel, bodyModel);
  }

  @override
  int get hashCode => id.hashCode ^ mail.hashCode ^ bodyModel.hashCode;
}
