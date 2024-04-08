class NewsModel {

  final String? title;
  final String? datetime;
  final String? description;
  final String? content;
  final String? urlImage;

  NewsModel({this.title, this.datetime, this.description, this.content, this.urlImage});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    title: json["title"],
    datetime: json["publishedAt"],
    description: json["description"],
    content: json["content"],
    urlImage: json["urlToImage"]
  );

}