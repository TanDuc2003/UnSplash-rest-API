import 'dart:convert';

class ImageModel {
  String id;
  UrlModel urls;
  User user;
  String? description;
  int? width;
  int? height;
  int? likes;
  String? location;

  ImageModel({
    required this.urls,
    required this.user,
    required this.id,
    required this.description,
    required this.likes,
    required this.width,
    required this.height,
  });

  factory ImageModel.fromtoJson(Map<String, dynamic> json) {
    return ImageModel(
      urls: UrlModel.fromJson(json['urls']),
      user: User.fromJson(json['user']),
      id: json['id'],
      description: json['description'],
      likes: json['likes'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() => {
        "urls": urls.toJson(),
        "user": user.toJson(),
        "id": id,
        "description": description,
        "likes": likes,
        "width": width,
        "height": height,
      };

  factory ImageModel.decode(String str) =>
      ImageModel.fromtoJson(json.decode(str));
}

class UrlModel {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  UrlModel(
      {this.raw,
      this.full,
      this.regular,
      this.small,
      this.thumb,
      this.smallS3});

  UrlModel.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    data['small_s3'] = this.smallS3;
    return data;
  }
}

class User {
  String? updatedAt;
  String? username;
  String? name;
  String? bio;
  String? location;
  ProfileImage? profileImage;

  User(
      {this.updatedAt,
      this.username,
      this.name,
      this.bio,
      this.location,
      this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    bio = json['bio'];
    location = json['location'];
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['location'] = this.location;
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    return data;
  }
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}
