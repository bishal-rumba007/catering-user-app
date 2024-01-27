import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final singleUserProvider = StreamProvider((ref) => UserProvider().userStream());
final allUserProvider = StreamProvider((ref) => UserProvider().allUserStream());

class UserProvider{
  final _userDb = FirebaseFirestore.instance.collection('users');

  Stream<types.User> userStream(){
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try{
      final data = _userDb.doc(uid).snapshots().map((event) {

        final json = event.data() as Map<String, dynamic>;
        return types.User(
          id: event.id,
          imageUrl: json['imageUrl'],
          firstName: json['firstName'],
          metadata: {
            'email': json['metadata']['email'],
            'phone': json['metadata']['phone'],
            'role': json['metadata']['role'],
          },
        );
      });
      return data;
    } on FirebaseException catch (err){
      throw '${err.message}';
    }
  }

  Stream<List<types.User>> allUserStream(){
    try{
      final data = FirebaseChatCore.instance.users();
      return data;
    } on FirebaseException catch (err){
      throw '${err.message}';
    }
  }
}