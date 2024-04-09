import 'package:bloc/bloc.dart';
import 'package:final_project_with_firebase/data/models/comment_model.dart';
import 'package:final_project_with_firebase/data/repositories/comment_reposity.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitialState()) {

    on<GetCommentByNewsEvent>((event, emit) async {
      CommentRepository repository = CommentRepository();
      final commentList = await repository.getCommentByNews(event.newsUrl);

      emit(CommentLoadedState(commentList: commentList));
    });

    on<InsertNewsCommentEvent>((event, emit) async {
      final currentState = state;
      if(currentState is CommentLoadedState) {
        CommentRepository repository = CommentRepository();
        final commentList = await repository.insertNewsComment(event.commentModel);

        emit(CommentLoadedState(commentList: commentList));
      }
    });

  }
}
