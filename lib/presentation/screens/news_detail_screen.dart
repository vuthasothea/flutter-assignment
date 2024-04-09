import 'package:final_project_with_firebase/core/constants/app_variable.dart';
import 'package:final_project_with_firebase/core/constants/string_util.dart';
import 'package:final_project_with_firebase/data/models/comment_model.dart';
import 'package:final_project_with_firebase/data/models/news_model.dart';
import 'package:final_project_with_firebase/presentation/blocs/comment/comment_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetailScreen extends StatefulWidget {

  final NewsModel newsModel;
  const NewsDetailScreen({required this.newsModel});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  final TextEditingController _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc()..add(GetCommentByNewsEvent(newsUrl: widget.newsModel.urlNews!)),
      child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            appBar: AppBar(
              title: Text("News Detail"),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: AppVariable.STANDARD_PADDING),
              children: [          
                Hero(
                  tag: widget.newsModel.urlNews!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppVariable.STANDARD_PADDING),
                    child: Image(
                      image: NetworkImage(widget.newsModel.urlImage ?? ""),
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
                SizedBox(height: AppVariable.STANDARD_PADDING),
                Text(widget.newsModel.title ?? "", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).colorScheme.primary)),
                SizedBox(height: AppVariable.STANDARD_PADDING/2),
                Row(
                  children: [
                    Icon(Icons.calendar_month, size: 18, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(widget.newsModel.datetime ?? "", style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                SizedBox(height: AppVariable.STANDARD_PADDING/2),
                Text(widget.newsModel.content ?? widget.newsModel.description ?? ""),
                SizedBox(height: AppVariable.STANDARD_PADDING),
                Text("Comments", style: TextStyle(fontSize: 20)),
                SizedBox(height: AppVariable.STANDARD_PADDING),

                BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: EdgeInsets.only(left: AppVariable.STANDARD_PADDING, right: AppVariable.STANDARD_PADDING, bottom: AppVariable.STANDARD_PADDING),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  leading: CircleAvatar(
                                    child: Text(FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase()),
                                  ),
                                  title: Text(FirebaseAuth.instance.currentUser!.displayName!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                  subtitle: Text(StringUtil.getFormatDateTime(DateTime.now())),
                                ),
                                SizedBox(height: AppVariable.STANDARD_PADDING/2),
                                TextFormField(
                                  controller: _controller,
                                  focusNode: _focusNode,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),                        
                                    ),
                                    hintText: "Write a comment",
                                    suffixIcon: IconButton(
                                      onPressed: (){
                                        if(_controller.text.isEmpty) {
                                          _focusNode.requestFocus();
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.warning, color: Colors.orange),
                                                SizedBox(width: 4),
                                                Text("Comment is required")
                                              ],
                                            ),
                                          ));
                                        } else {                                          
                                          final commentModel = CommentModel(newsUrl: widget.newsModel.urlNews, comment: _controller.text);
                                          BlocProvider.of<CommentBloc>(context).add(InsertNewsCommentEvent(commentModel: commentModel));
                                          _controller.clear();
                                          _focusNode.unfocus();
                                        }
                                      },
                                      icon: Icon(Icons.send)
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: AppVariable.STANDARD_PADDING),
                        ((){
                          if(state is CommentLoadedState) {
                            final listComment = state.commentList ?? [];
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  isThreeLine: true,
                                  leading: CircleAvatar(
                                    child: Text(listComment[index].username![0].toUpperCase()),
                                  ),
                                  title: Wrap(
                                    children: [
                                      Text(listComment[index].username!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      SizedBox(width: AppVariable.STANDARD_PADDING/2),
                                      Text(listComment[index].timeAgo ?? "now")
                                    ],
                                  ),
                                  subtitle: Text(listComment[index].comment ?? "", style: TextStyle(fontSize: 14)),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(indent: 55);
                              },
                              itemCount: listComment.length
                            );                            
                          }

                          return Container();
                        }()),                        
                        SizedBox(height: AppVariable.STANDARD_PADDING),
                      ],
                    );
                  }
                )
              ],
            ),
          ),
        ),
    );
  }
}