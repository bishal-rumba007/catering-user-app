




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



class SearchMenuModel{
  final String title;
  final String caterer;
  final String menuId;
  final String imageUrl;

  SearchMenuModel({
    required this.title,
    required this.caterer,
    required this.menuId,
    required this.imageUrl,
  });

  factory SearchMenuModel.fromJson(Map<String, dynamic> json) {
   return SearchMenuModel(
     title: json['categoryName'],
     caterer: json['providerName'],
     menuId: json['menuId'],
     imageUrl: json['imageUrl'],
   );
  }
}