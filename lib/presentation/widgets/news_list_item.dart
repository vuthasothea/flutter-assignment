import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:final_project_with_firebase/data/models/news_model.dart';
import 'package:final_project_with_firebase/presentation/screens/news_detail_screen.dart';
import 'package:flutter/material.dart';

class NewListItem extends StatelessWidget {

  final NewsModel newsModel;
  NewListItem({required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(newsModel: newsModel)));
        },
        child: Padding(
          padding: EdgeInsets.all(AppVariable.STANDARD_PADDING/2),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Hero(
                  tag: newsModel.urlNews!,
                  child: Image(
                    image: NetworkImage(newsModel.urlImage ?? ""),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image(
                        image: NetworkImage("https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg"),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: AppVariable.STANDARD_PADDING),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(newsModel.title ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, size: 18, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(newsModel.datetime ?? "", style: TextStyle(color: Colors.grey[600])),
                      ],
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}