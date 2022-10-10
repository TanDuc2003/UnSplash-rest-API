import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/model/image_model.dart';
import 'package:image/model/topic_model.dart';
import 'package:image/provider/api_key.dart';

class GetImages {
  Future<String> getKey() async {
    String apiKey = apiKeyClientID;
    return apiKey;
  }

//lấy ảnh ngẫu nhiên
  Future<List<ImageModel>> getRandomImage() async {
    String apiKey = await getKey();
    String s =
        'https://api.unsplash.com//photos/random/?client_id=$apiKey&count=30';
    final reponse = await http.get(Uri.parse(s));
    if (reponse.statusCode == 200) {
      List<dynamic> result = jsonDecode(reponse.body);
      // print(result);
      List<ImageModel> images =
          result.map((e) => ImageModel.fromtoJson(e)).toList();
      // trả vể ảnh đã lấy
      return images;
    } else {
      throw "Lỗi không thể tải ảnh";
    }
  }

//lấy bộ sưu tập
  Future<List<ImageModel>> getCollectionsImages(
      String id, int page, int perPage) async {
    String apiKey = await getKey();
    String s =
        'https://api.unsplash.com/collections/$id/photos?client_id=$apiKey&page=$page&per_page=$perPage';
    final reponse = await http.get(Uri.parse(s));
    // print(s);
    if (reponse.statusCode == 200) {
      List<dynamic> result = jsonDecode(reponse.body);
      // print(result);
      List<ImageModel> images =
          result.map((e) => ImageModel.fromtoJson(e)).toList();
      return images;
    } else {
      throw "Lỗi không thể tải ảnh";
    }
  }

  // lấy chủ đề
  Future<List<TopicsModel>> getTopicsList() async {
    final topicsJson = await rootBundle.loadString("assets/files/topics.json");
    final topicsData = jsonDecode(topicsJson);
    var topics = topicsData['topics'];

    List<TopicsModel> topicsList =
        List.from(topics).map((e) => TopicsModel.fromJson(e)).toList();
    return topicsList;
  }

  Future<List<ImageModel>> getTopic(
      {required String topic, required int pageNo}) async {
    String apiKey = await getKey();
    final s =
        'https://api.unsplash.com/topics/$topic/photos/?client_id=$apiKey&per_page=30&page=$pageNo';
    // print(s);
    final response = await http.get(Uri.parse(s));
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      // print(result);
      List<ImageModel> images =
          result.map((e) => ImageModel.fromtoJson(e)).toList();
      return images;
    } else {
      throw "Lỗi không thể tải ảnh";
    }
  }

  //  tìm kiếm

// https://api.unsplash.com/photos/random/?client_id=$apiKey&count=30&query=$query'
  Future<List<ImageModel>> searchImage({required String query}) async {
    String apiKey = await getKey();
    final s =
        "https://api.unsplash.com/photos/random/?client_id=$apiKey&count=30&query=$query";
    print("link tìm kiếm :${s}");
    final response = await http.get(Uri.parse(s));
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      print("data tìm kiếm :${result}");
      List<ImageModel> images =
          result.map((e) => ImageModel.fromtoJson(e)).toList();
      return images;
    } else {
      throw " Lỗi Không thể tìm kiếm được";
    }
  }
}
