import 'dart:convert';

class BodyModel {
  // todo verinin girildiği tarih için date de al
  String? weight;
  String? height;
  String? fatRate;
  BodyModel({
    this.weight,
    this.height,
    this.fatRate,
  });

  BodyModel copyWith({
    String? weight,
    String? height,
    String? fatRate,
  }) {
    return BodyModel(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      fatRate: fatRate ?? this.fatRate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight,
      'height': height,
      'fatRate': fatRate,
    };
  }

  factory BodyModel.fromMap(Map<String, dynamic> map) {
    return BodyModel(
      weight: map['weight'] != null ? map['weight'] as String : null,
      height: map['height'] != null ? map['height'] as String : null,
      fatRate: map['fatRate'] != null ? map['fatRate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BodyModel.fromJson(String source) =>
      BodyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BodyModel(weight: $weight, height: $height, fatRate: $fatRate)';

  @override
  bool operator ==(covariant BodyModel other) {
    if (identical(this, other)) return true;

    return other.weight == weight &&
        other.height == height &&
        other.fatRate == fatRate;
  }

  @override
  int get hashCode => weight.hashCode ^ height.hashCode ^ fatRate.hashCode;
}

List<BodyModel> bodyModelList = [
  BodyModel(
    weight: "110",
    height: "190",
    fatRate: "24",
  ),
  BodyModel(
    weight: "108",
    height: "190",
    fatRate: "23",
  ),
  BodyModel(
    weight: "106",
    height: "190",
    fatRate: "22",
  ),
  BodyModel(
    weight: "108",
    height: "190",
    fatRate: "22",
  ),
  BodyModel(
    weight: "104",
    height: "190",
    fatRate: "22",
  ),
];
