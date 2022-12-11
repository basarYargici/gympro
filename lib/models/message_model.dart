import 'dart:convert';

class MessageModel {
  String? message;
  bool isSuccess;
  MessageModel({
    this.message,
    required this.isSuccess,
  });

  MessageModel copyWith({
    String? message,
    bool? isSuccess,
  }) {
    return MessageModel(
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'isSuccess': isSuccess,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] != null ? map['message'] as String : null,
      isSuccess: map['isSuccess'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageModel(message: $message, isSuccess: $isSuccess)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MessageModel &&
      other.message == message &&
      other.isSuccess == isSuccess;
  }

  @override
  int get hashCode => message.hashCode ^ isSuccess.hashCode;
}
