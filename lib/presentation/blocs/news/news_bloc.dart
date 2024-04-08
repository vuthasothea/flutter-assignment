import 'package:bloc/bloc.dart';
import 'package:final_project_with_firebase/data/models/news_model.dart';
import 'package:final_project_with_firebase/data/repositories/news_repository.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitialState()) {

    on<GetNewsEvent>((event, emit) async {
      emit(NewsInProccessState());

      NewsRepository repository = NewsRepository();
      List<NewsModel> newsList = await repository.getNewsList(event.newsCategory);

      emit(NewsLoadedState(newsList: newsList));
    });

  }
}
