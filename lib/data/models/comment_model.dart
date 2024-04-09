import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentModel {

  final String? username;
  final DateTime? dateTime;
  final String? newsUrl;
  final String? comment;
  final String? timeAgo;

  CommentModel({this.username, this.dateTime, this.newsUrl, this.comment, this.timeAgo});

  Map<String, dynamic> toJson() => {
    "Username": FirebaseAuth.instance.currentUser!.displayName,
    "CommentDate": DateTime.now(),
    "NewsUrl": newsUrl,
    "Comment": comment
  };

  factory CommentModel.fromJson(Map<String, dynamic> json) {

    DateTime commentDate;    
    try {
      commentDate = json["CommentDate"].toDate();
    } catch(_) {
      commentDate = DateTime.now();
    }

    return CommentModel(
      username: json["Username"],
      dateTime: commentDate,
      newsUrl: json["NewsUrl"],
      comment: json["Comment"],
      timeAgo: timeago.format(commentDate)
    );
  }

}