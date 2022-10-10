import 'dart:convert';

import 'package:image/model/image_model.dart';

class TopicsModel {
  String? slug;
  String? title;
  CoverPhoto? coverPhoto;

  TopicsModel({this.slug, this.title, this.coverPhoto});

  TopicsModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
    coverPhoto = json['cover_photo'] != null
        ? new CoverPhoto.fromJson(json['cover_photo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['title'] = this.title;
    if (this.coverPhoto != null) {
      data['cover_photo'] = this.coverPhoto!.toJson();
    }
    return data;
  }
}

class CoverPhoto {
  String? id;
  Urls? urls;

  CoverPhoto({this.id, this.urls});

  CoverPhoto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.urls != null) {
      data['urls'] = this.urls!.toJson();
    }
    return data;
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    return data;
  }
}
