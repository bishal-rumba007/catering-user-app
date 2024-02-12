
import 'package:catering_user_app/src/features/search/domain/search_menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDataSource{
  final menuDb = FirebaseFirestore.instance.collection('menus');
  final categoryDb = FirebaseFirestore.instance.collection('categories');
  final serviceProviderDb = FirebaseFirestore.instance.collection('users').where('metadata.role', isEqualTo: 'serviceProvider');


  Future<List<SearchMenuModel>> searchMenu(String query) async{
    try{
      final result = await menuDb.where('categoryName', isEqualTo: query).get();
      final searchResult = result.docs.map((e) => SearchMenuModel.fromJson(e.data())).toList();
      return searchResult;
    }on FirebaseException catch(e){
      throw e.message.toString();
    }
  }

}