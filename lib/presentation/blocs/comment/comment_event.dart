part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class GetCommentByNewsEvent extends CommentEvent {

  final String newsUrl;
  GetCommentByNewsEvent({required this.newsUrl});

}

class InsertNewsCommentEvent extends CommentEvent {

  final CommentModel commentModel;
  InsertNewsCommentEvent({required this.commentModel});

}
