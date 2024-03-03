import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class ProfileDataSource{
  final _userDb = FirebaseFirestore.instance.collection('users');

  Future<void> uploadImage({required XFile image}) async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    try{
      final imageId = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('profileImage/$imageId');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      await _userDb.doc(uid).update({
        'imageUrl': url,
      });
    } on FirebaseException catch (err){
      throw '${err.message}';
    }
  }
}

