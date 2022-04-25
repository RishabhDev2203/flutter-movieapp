import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContentDto{
  ContentDto({
    this.createdAt,
    this.duration,
    this.extension,
    this.outputUrl,
    this.sourceUrl,
    this.status,
  });
  
  Timestamp? createdAt;
  int? duration;
  String? extension;
  String? outputUrl;
  String? sourceUrl;
  String? status;

  ContentDto contentDtoFromJson(String str) => ContentDto.fromJson(json.decode(str));

  String? contentDtoToJson(ContentDto data) => json.encode(data.toJson());

  factory ContentDto.fromJson(Map<String, dynamic> json) => ContentDto(
    createdAt: json["createdAt"],
    duration: json["duration"],
    extension: json["extension"],
    outputUrl: json["outputUrl"],
    sourceUrl: json["sourceUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "duration": duration,
    "extension": extension,
    "outputUrl": outputUrl,
    "sourceUrl": sourceUrl,
    "status": status,
  };

}