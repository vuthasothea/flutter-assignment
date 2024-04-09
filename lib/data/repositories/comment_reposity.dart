import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_with_firebase/data/models/comment_model.dart';

class CommentRepository {

  final db = FirebaseFirestore.instance;

  Future<List<CommentModel>> getCommentByNews(String newsUrl) async {
    List<CommentModel> commentList = [];

    final querySnapshot = await db.collection("comments")
                                  .where("NewsUrl", isEqualTo: newsUrl)
                                  .get();

    for(var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      CommentModel commentModel = CommentModel.fromJson(data);

      commentList.add(commentModel);
    }

    return commentList;
  }

  Future<List<CommentModel>> insertNewsComment(CommentModel model) async {
    await db.collection("comments").add(model.toJson());
    return await getCommentByNews(model.newsUrl!);
  }

}