import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoModel {
  final String videoId;
  final String title;
  final String channelId;
  final String channelTitle;
  final String image;

  VideoModel({
    @required this.videoId,
    @required this.title,
    @required this.channelId,
    @required this.channelTitle,
    @required this.image,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      channelId: json['snippet']['channelId'],
      channelTitle: json['snippet']['channelTitle'],
      image: json['snippet']['thumbnails']['high']['url'],
    );
  }
}

class VideoProvider with ChangeNotifier {
  List<VideoModel> _items = [];

  List<VideoModel> get items {
    return [..._items];
  }

  Future<void> getVideo(String requestKeyword) async {
    final keyword = 'ustadz ' + requestKeyword;
    final apiToken = 'AIzaSyDw0zwuxlYBhkKy5dG96SGkrH0KNDh_0HQ';
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&eventType=live&relevanceLanguage=id&maxResults=25&q=$keyword&type=video&key=$apiToken';
    final response = await http.get(url);
    final extractData = json.decode(response.body)['items'];

    if (extractData == null) {
      return;
    }

    _items =
        extractData.map<VideoModel>((i) => VideoModel.fromJson(i)).toList();
    notifyListeners();
  }

  VideoModel findVideo(String videoId) {
    return _items.firstWhere((q) => q.videoId == videoId);
  }
}
