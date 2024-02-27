


import 'package:catering_user_app/src/features/review/data/review_datasource.dart';
import 'package:catering_user_app/src/features/review/domain/review_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewProvider = StreamProvider.family<List<ReviewModel>, String>(
        (ref, String menuId) => ReviewDataSource().getReviewsStream(menuId)
);