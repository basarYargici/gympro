import 'dart:convert';

class BodyModel {
  // todo verinin girildiği tarih için date de al
  String weight = "0";
  String height = "0";
  String fatRate = "0";
  
  BodyModel({
    required this.weight,
    required this.height,
    required this.fatRate,
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
      weight: map['weight'] as String,
      height: map['height'] as String,
      fatRate: map['fatRate'] as String,
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

Map<String, dynamic> toMapBodyModelList(List<BodyModel> list) {
  return <String, dynamic>{
    'bodyModel': list.map((x) => x.toMap()).toList(),
  };
}
