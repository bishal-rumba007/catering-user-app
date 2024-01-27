import 'package:catering_user_app/src/shared/domain/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider = FutureProvider<List<CategoryModel>>(
    (ref) => CategoryProvider().getCategories());

class CategoryProvider {
  final categoryDb = FirebaseFirestore.instance.collection('categories');
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await categoryDb.snapshots().first;
      final categories = response.docs.map((doc) {
        final json = doc.data();
        return CategoryModel.fromJson(json);
      }).toList();
      return categories;
    } on FirebaseException catch (err) {
      throw '${err.message}';
    }
  }
}
