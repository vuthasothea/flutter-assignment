part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitialState extends NewsState {}

final class NewsInProccessState extends NewsState {}

final class NewsLoadedState extends NewsState {

  final List<NewsModel> newsList;
  NewsLoadedState({required this.newsList});

}
