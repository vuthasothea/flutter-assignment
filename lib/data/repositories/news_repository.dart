import 'dart:convert';

import 'package:final_project_with_firebase/data/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {

  final String _BASEURL = "https://newsapi.org/v2/";
  final String _APIKEY = "64d0606212fc4fecb86fe8f2caf15f33";

  Future<List<NewsModel>> getNewsList(String category) async {

    if(category == "home") {
      category = "top-headlines?sources=techcrunch&apiKey=$_APIKEY";
    } else {
      category = "top-headlines?country=us&category=$category&apiKey=$_APIKEY";
    }

    var url = Uri.parse("$_BASEURL/$category");
    var response = await http.get(url);
    var listJson = (jsonDecode(response.body)["articles"] as List);
    var listNews = listJson.where((element) => element["title"] != "[Removed]").map((json) => NewsModel.fromJson(json)).toList();

    return listNews;
  }

}