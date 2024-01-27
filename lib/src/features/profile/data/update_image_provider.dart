


import 'package:catering_user_app/src/features/profile/data/profile_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final updateImageProvider = FutureProvider.family((ref, XFile image) => ProfileDataSource().uploadImage(image: image));