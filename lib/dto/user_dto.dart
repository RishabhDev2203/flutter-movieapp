// To parse this JSON data, do
//     final userDto = userDtoFromJson(jsonString?);

import 'dart:convert';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));

String? userDtoToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  UserDto({
    // this.result,
    // this.token,
    this.message,
    this.email,
    this.name,
    this.role,
    this.id,
  });

  // Result? result;
  // String? token;
  String? message;
  String? email;
  String? role;
  String? name;
  String? id;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    // result: json.containsKey("result") ? Result.fromJson(json["result"]) : null, token: json["token"],
    message: json["message"],
    email: json["email"],
    role: json["role"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    // "result": result?.toJson(),
    // "token": token,
    "message": message,
    "email": email,
    "role": role,
    "name": name,
    "id": id,
  };

  // UserDto copyWith({ Result? result, String? token, String? message }) {
  //   return UserDto(
  //     result: result ?? this.result,
  //     token: token ?? this.token,
  //     message: message ?? this.message,
  //   );
  // }

}

// class Result {
//   Result(
//       {this.id,
//         this.name,
//         this.fullName,
//         this.avatar,
//         this.aiAvatar,
//         this.aiName,
//         this.userType,
//         this.email,
//         this.countryCode,
//         this.mobileNumber,
//         this.userName,
//         this.socialType,
//         this.bio,
//         this.kolVerification,
//         this.isPrivate,
//         this.totalPosts,
//         this.followers,
//         this.following,
//         this.token,
//         this.kolInfo,
//         this. cryptoNotification,
//         this. chatNotification,
//         this. reactionFromPeopleiFollow,
//         this. reactionFromEveryone,
//         this. commentFromPeopleiFollow,
//         this. commentFromEveryone,
//         this. notificationStatus,
//         this. allowComment,
//         this. showPostFollower,
//       });
//
//   dynamic id;
//   String? name;
//   dynamic fullName;
//   String? avatar;
//   String? aiAvatar;
//   dynamic aiName;
//   String? userType;
//   String? email;
//   String? countryCode;
//   dynamic mobileNumber;
//   String? userName;
//   String? socialType;
//   String? bio;
//   String? kolVerification;
//   String? token;
//   int? isPrivate;
//   int? totalPosts;
//   int? followers;
//   int? following;
//   KolInfo? kolInfo;
//   int? cryptoNotification;
//   int? chatNotification;
//   int? reactionFromPeopleiFollow;
//   int? reactionFromEveryone;
//   int? commentFromPeopleiFollow;
//   int? commentFromEveryone;
//   int? notificationStatus;
//   String? allowComment;
//   String? showPostFollower;
//
//   factory Result.fromJson(Map<String?, dynamic> json) => Result(
//     id: json["id"],
//     name: json["name"],
//     fullName: json["fullName"],
//     avatar: json["avatar"],
//     aiAvatar: json["aiAvatar"],
//     aiName: json["aiName"],
//     userType: json["userType"],
//     email: json["email"],
//     countryCode: json["countryCode"],
//     mobileNumber: json["mobileNumber"],
//     userName: json["userName"],
//     socialType: json["socialType"],
//     bio: json["bio"],
//     token: json["token"],
//     kolVerification: json["kolVerification"],
//     isPrivate: json["isPrivate"],
//     totalPosts: json["totalPosts"],
//     followers: json["followers"],
//     following: json["following"],
//     kolInfo: json["kolInfo"] == null ? null : KolInfo.fromJson(json["kolInfo"]),
//     cryptoNotification: json["cryptoNotification"],
//     chatNotification: json["chatNotification"],
//     reactionFromPeopleiFollow: json["reactionFromPeopleiFollow"],
//     reactionFromEveryone: json["reactionFromEveryone"],
//     commentFromPeopleiFollow: json["commentFromPeopleiFollow"],
//     commentFromEveryone: json["commentFromEveryone"],
//     notificationStatus: json["notificationStatus"],
//     allowComment: json["allowComment"],
//     showPostFollower: json["showPostFollower"],
//
//
//   );
//
//   Map<String?, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "fullName": fullName,
//     "avatar": avatar,
//     "aiAvatar": aiAvatar,
//     "aiName": aiName,
//     "userType": userType,
//     "email": email,
//     "countryCode": countryCode,
//     "mobileNumber": mobileNumber,
//     "userName": userName,
//     "socialType": socialType,
//     "bio": bio,
//     "token": token,
//     "kolVerification": kolVerification,
//     "isPrivate": isPrivate,
//     "totalPosts": totalPosts,
//     "followers": followers,
//     "following": following,
//     "kolInfo": kolInfo == null ? null : kolInfo?.toJson(),
//     "cryptoNotification": cryptoNotification,
//     "chatNotification": chatNotification,
//     "reactionFromPeopleiFollow": reactionFromPeopleiFollow,
//     "reactionFromEveryone": reactionFromEveryone,
//     "commentFromPeopleiFollow": commentFromPeopleiFollow,
//     "commentFromEveryone": commentFromEveryone,
//     "notificationStatus": notificationStatus,
//     "allowComment": allowComment,
//     "showPostFollower": showPostFollower,
//   };
//
//   Result copyWith({ int? id,
//     String? name,
//     dynamic fullName,
//     String? avatar,
//     String? aiAvatar,
//     dynamic aiName,
//     String? userType,
//     String? email,
//     String? countryCode,
//     dynamic mobileNumber,
//     String? userName,
//     String? socialType,
//     String? bio,
//     String? kolVerification,
//     String? token,
//     int? isPrivate,
//     int? totalPosts,
//     int? followers,
//     int? following,
//     KolInfo? kolInfo ,
//     int? cryptoNotification,
//     int? chatNotification,
//     int? reactionFromPeopleiFollow,
//     int? reactionFromEveryone,
//     int? commentFromPeopleiFollow,
//     int? commentFromEveryone,
//     int? notificationStatus,
//     String? allowComment,
//     String? showPostFollower,
//   }) {
//     return Result(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       fullName: fullName ?? this.fullName,
//       avatar: avatar ?? this.avatar,
//       aiAvatar: aiAvatar ?? this.aiAvatar,
//       aiName: aiName ?? this.aiName,
//       userType: userType ?? this.userType,
//       email: email ?? this.email,
//       countryCode: countryCode ?? this.countryCode,
//       mobileNumber: mobileNumber ?? this.mobileNumber,
//       userName: userName ?? this.userName,
//       socialType: socialType ?? this.socialType,
//       bio: bio ?? this.bio,
//       kolVerification: kolVerification ?? this.kolVerification,
//       token: token ?? this.token,
//       isPrivate: isPrivate ?? this.isPrivate,
//       totalPosts: totalPosts ?? this.totalPosts,
//       followers: followers ?? this.followers,
//       following: following ?? this.following,
//       kolInfo: kolInfo ?? this.kolInfo,
//       cryptoNotification: cryptoNotification ?? this.cryptoNotification,
//       chatNotification: chatNotification ?? this.chatNotification,
//       reactionFromPeopleiFollow: reactionFromPeopleiFollow ?? this.reactionFromPeopleiFollow,
//       reactionFromEveryone: reactionFromEveryone ?? this.reactionFromEveryone,
//       commentFromPeopleiFollow: commentFromPeopleiFollow ?? this.commentFromPeopleiFollow,
//       commentFromEveryone: commentFromEveryone ?? this.commentFromEveryone,
//       notificationStatus: notificationStatus ?? this.notificationStatus,
//       allowComment: allowComment ?? this.allowComment,
//       showPostFollower: showPostFollower ?? this.showPostFollower,
//     );
//   }
// }
//
// class KolInfo {
//   KolInfo({
//     this.id,
//     this.publicId,
//     this.userId,
//     this.fullName,
//     this.documentType,
//     this.document,
//     this.categoryId,
//     this.link,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   int? id;
//   String? publicId;
//   int? userId;
//   String? fullName;
//   String? documentType;
//   String? document;
//   int? categoryId;
//   List<Link>? link;
//   String? createdAt;
//   String? updatedAt;
//
//   factory KolInfo.fromRawJson(String str) => KolInfo.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory KolInfo.fromJson(Map<String, dynamic> json) => KolInfo(
//     id: json["id"] == null ? null : json["id"],
//     publicId: json["publicId"] == null ? null : json["publicId"],
//     userId: json["userId"] == null ? null : json["userId"],
//     fullName: json["fullName"] == null ? null : json["fullName"],
//     documentType: json["documentType"] == null ? null : json["documentType"],
//     document: json["document"] == null ? null : json["document"],
//     categoryId: json["categoryId"] == null ? null : json["categoryId"],
//     link: json["link"] == null ? null : List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
//     createdAt: json["createdAt"] == null ? null : json["createdAt"],
//     updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "publicId": publicId == null ? null : publicId,
//     "userId": userId == null ? null : userId,
//     "fullName": fullName == null ? null : fullName,
//     "documentType": documentType == null ? null : documentType,
//     "document": document == null ? null : document,
//     "categoryId": categoryId == null ? null : categoryId,
//     "link": link == null ? null : List<dynamic>.from(link!.map((x) => x.toJson())),
//     "createdAt": createdAt == null ? null : createdAt,
//     "updatedAt": updatedAt == null ? null : updatedAt,
//   };
// }
//
// class Link {
//   Link({
//     this.url,
//     this.type,
//     this.linkUrl,
//   });
//
//   String? url;
//   String? type;
//   String? linkUrl;
//
//   factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"] == null ? null : json["url"],
//     type: json["type"] == null ? null : json["type"],
//     linkUrl: json["url "] == null ? null : json["url "],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url == null ? null : url,
//     "type": type == null ? null : type,
//     "url ": linkUrl == null ? null : linkUrl,
//   };
// }


