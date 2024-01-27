import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = StateNotifierProvider.autoDispose<ImageProvider, XFile?>(
    (ref) => ImageProvider(null));

class ImageProvider extends StateNotifier<XFile?> {
  ImageProvider(super.create);
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    state = await picker.pickImage(source: ImageSource.gallery);
  }
}
