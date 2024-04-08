part of 'news_bloc.dart';

@immutable
sealed class NewsEvent {}

class GetNewsEvent extends NewsEvent {

  final String newsCategory;
  GetNewsEvent({required this.newsCategory});

}
