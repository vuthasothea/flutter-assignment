part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitialState extends CommentState {}

final class CommentLoadedState extends CommentState {

  final List<CommentModel>? commentList;
  CommentLoadedState({this.commentList});

}
