import 'package:final_project_with_firebase/core/constants/string_util.dart';

class NewsModel {

  final String? title;
  final String? datetime;
  final String? description;
  final String? content;
  final String? urlImage;
  final String? urlNews;

  NewsModel({this.title, this.datetime, this.description, this.content, this.urlImage, this.urlNews});

  factory NewsModel.fromJson(Map<String, dynamic> json) {

    DateTime publishedAt;    
    try {
      publishedAt = DateTime.parse(json["publishedAt"]);
    } catch(_) {
      publishedAt = DateTime.now();
    }

    return NewsModel(
      title: json["title"],
      datetime: StringUtil.getFormatDateTime(publishedAt),
      description: json["description"],
      content: json["content"],
      urlImage: json["urlToImage"],
      urlNews: json["url"]
    );
  }

}