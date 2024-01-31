import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final roomProvider = Provider((ref) => RoomProvider());
final roomStream = StreamProvider.autoDispose((ref) => FirebaseChatCore.instance.rooms(),);

class RoomProvider{

  Future<types.Room?> createRoom(types.User user) async {
    try {
      final response = FirebaseChatCore.instance.createRoom(user);
      return response;
    }catch (error) {
      throw '$error';
    }
  }
}



final loadingProvider = StateNotifierProvider<LoadingProvider, bool>((ref) => LoadingProvider(false));

class LoadingProvider extends StateNotifier<bool> {
  LoadingProvider(super.state);
  void toggle(){
    state = !state;
  }

}

