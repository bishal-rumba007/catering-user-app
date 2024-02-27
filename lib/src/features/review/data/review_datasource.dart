



import 'package:catering_user_app/src/app.dart';
import 'package:catering_user_app/src/features/review/domain/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewDataSource{


  final _reviewDb = FirebaseFirestore.instance.collection('reviews');

  Future<String> addReview(ReviewModel reviewModel) async {
    try {
      await _reviewDb.add(reviewModel.toJson());
      return 'Review Added Successfully';
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }

  Stream<List<ReviewModel>> getReviewsStream(String menuId) {
    try {
      final data = _reviewDb.where('menuId', isEqualTo: menuId).snapshots();
      final response = data.asyncMap((event) async {
        final data = Future.wait(event.docs.map((e) async {
          final json = e.data();
          return ReviewModel.fromJson({
            ...json,
            'reviewId': e.id,
          });
        }).toList());
        return data;
      });
      return response;
    } on FirebaseException catch (error) {
      throw '$error';
    }
  }

}