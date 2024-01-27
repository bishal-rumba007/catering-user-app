



import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuDataSource{
  final menuDb = FirebaseFirestore.instance.collection('menus');
  final _userDb = FirebaseFirestore.instance.collection('users');
  final _categoryDb = FirebaseFirestore.instance.collection('categories');
  final uid = FirebaseAuth.instance.currentUser!.uid;


  Future<List<Menus>> getMenu() async {
    try {
      final response = await menuDb.get();
      final menusList = await Future.wait(response.docs.map((doc) async {
        final json = doc.data();
        final categoryImage = await getCategoryImage(json['categoryId']);
        return Menus.fromJson({...json, 'categoryImage': categoryImage, 'menuId': doc.id,});
      }));
      return menusList;
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }

  Future<String?> getCategoryImage(String categoryId) async {
    try {
      final categoriesSnapshot = await _categoryDb.where('categoryId', isEqualTo: categoryId).get();

      if (categoriesSnapshot.docs.isNotEmpty) {
        final matchingCategory = categoriesSnapshot.docs.first;
        return matchingCategory['imageUrl'];
      } else {
        return null;
      }
    } on FirebaseException catch (err) {
      throw '$err';
    }
  }


  Future<String> updateMenu({
    required String menuId,
    required String categoryId,
    required String price,
    required List<String> starterMenu,
    required List<String> mainCourseMenu,
    required List<String> dessertMenu,
    required String categoryName,
  }) async {
    try {
      final userData = await _userDb.doc(uid).get();
      await menuDb.doc(menuId).update({
        'userId': userData.id,
        'providerName': userData['firstName'],
        'price': price,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'starterMenu': starterMenu,
        'mainCourseMenu': mainCourseMenu,
        'dessertMenu': dessertMenu,
      });
      return 'Menu Updated';
    } on FirebaseException catch (err) {
      return '${err.message}';
    }
  }
}