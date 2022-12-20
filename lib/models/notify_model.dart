import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotifyModel {
  final List<NotifyItemModel> campaigns;
  final List<NotifyItemModel> news;
  NotifyModel({
    required this.campaigns,
    required this.news,
  });

  NotifyModel copyWith({
    List<NotifyItemModel>? campaigns,
    List<NotifyItemModel>? news,
  }) {
    return NotifyModel(
      campaigns: campaigns ?? this.campaigns,
      news: news ?? this.news,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'campaigns': campaigns.map((x) => x.toMap()).toList(),
      'news': news.map((x) => x.toMap()).toList(),
    };
  }

  factory NotifyModel.fromMap(Map<String, dynamic> map) {
    return NotifyModel(
      campaigns: List<NotifyItemModel>.from(
        (map['campaigns']).map<NotifyItemModel>(
          (x) => NotifyItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      news: List<NotifyItemModel>.from(
        (map['news']).map<NotifyItemModel>(
          (x) => NotifyItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifyModel.fromJson(String source) =>
      NotifyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NewsModel(campaigns: $campaigns, news: $news)';

  @override
  bool operator ==(covariant NotifyModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.campaigns, campaigns) &&
        listEquals(other.news, news);
  }

  @override
  int get hashCode => campaigns.hashCode ^ news.hashCode;
}

class NotifyItemModel {
  String? title;
  String? description;
  String? imageUrl;
  NotifyItemModel({
    this.title,
    this.description,
    this.imageUrl,
  });

  NotifyItemModel copyWith({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return NotifyItemModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory NotifyItemModel.fromMap(Map<String, dynamic> map) {
    return NotifyItemModel(
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifyItemModel.fromJson(String source) =>
      NotifyItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NewsItemModel(title: $title, description: $description, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant NotifyItemModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ imageUrl.hashCode;
}
