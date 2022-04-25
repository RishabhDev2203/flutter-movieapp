// To parse this JSON data, do
//     final userDto = userDtoFromJson(jsonString?);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_ott/dto/content_dto.dart';

LibraryDto libraryDtoFromJson(String str) => LibraryDto.fromJson(json.decode(str));

String? libraryDtoToJson(LibraryDto data) => json.encode(data.toJson());

class LibraryDto {
  LibraryDto({
    this.content,
    this.createdAt,
    this.deletedAt,
    this.description,
    this.disableAt,
    this.publishedAt,
    this.isFeatures,
    this.slug,
    this.sortDescription,
    this.videoContent,
    this.status,
    this.tag,
    this.type,
    this.thumbnails,
    this.title,
  });

  DocumentReference? content;
  Timestamp? createdAt;
  dynamic deletedAt;
  String? description;
  Timestamp? disableAt;
  Timestamp? publishedAt;
  bool? isFeatures;
  String? slug;
  String? sortDescription;
  ContentDto? videoContent;
  String? status;
  List<dynamic>? tag;
  List<dynamic>? type;
  List<Thumbnail>? thumbnails;
  String? title;

  factory LibraryDto.fromRawJson(String str) => LibraryDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());


  factory LibraryDto.fromJson(Map<String, dynamic> json) => LibraryDto(
    content: json["content"],
    createdAt: json["createdAt"],
    deletedAt: json["deletedAt"],
    description: json["description"],
    disableAt: json["disableAt"],
    publishedAt: json["publishedAt"],
    isFeatures: json["isFeatures"],
    slug: json["slug"],
    sortDescription: json["sortDescription"],
    status: json["status"],
    tag: json["tag"],
    type: json["type"],
    // thumbnails: json["thumbnails"],
    thumbnails: json["thumbnails"] == null ? null : List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "createdAt": createdAt,
    "deletedAt": deletedAt,
    "description": description,
    "disableAt": disableAt,
    "publishedAt": publishedAt,
    "isFeatures": isFeatures,
    "slug": slug,
    "sortDescription": sortDescription,
    "status": status,
    "tag": tag,
    // "thumbnails": thumbnails,
    "thumbnails": thumbnails == null ? null : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
    "type": type,
    "title": title,
  };

}

class Thumbnail {
  Thumbnail({
    this.type,
    this.url,
  });

 String? type;
 String? url;

  factory Thumbnail.fromRawJson(String str) => Thumbnail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "url": url,
  };

}