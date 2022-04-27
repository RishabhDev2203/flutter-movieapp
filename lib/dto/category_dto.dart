// To parse this JSON data, do
//     final userDto = userDtoFromJson(jsonString?);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_ott/dto/content_dto.dart';
import 'package:flutter_firebase_ott/dto/library_dto.dart';

class CategoryDto {
  CategoryDto({
    this.id,
    this.avatar,
    this.createdAt,
    this.description,
    this.haveType,
    this.libraryId,
    this.position,
    this.rootId,
    this.status,
    this.title,
    this.updatedAt,
    this.library
  });

  String? id;
  String? avatar;
  Timestamp? createdAt;
  String? description;
  List<dynamic>? haveType;
  DocumentReference? libraryId;
  dynamic position;
  dynamic rootId;
  LibraryDto? library;
  String? status;
  String? title;
  Timestamp? updatedAt;

  factory CategoryDto.fromRawJson(String str) => CategoryDto.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());


  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
    avatar: json["avatar"],
    createdAt: json["createdAt"],
    description: json["description"],
    haveType: json["haveType"],
    libraryId: json["libraryId"],
    position: json["position"],
    rootId: json["rootId"],
    status: json["status"],
    title: json["title"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "createdAt": createdAt,
    "description": description,
    "haveType": haveType,
    "libraryId": libraryId,
    "position": position,
    "rootId": rootId,
    "status": status,
    "updatedAt": updatedAt,
    "title": title,
  };

}
