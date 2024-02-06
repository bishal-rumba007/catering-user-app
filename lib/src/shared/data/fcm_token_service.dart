import 'package:hive/hive.dart';

class FCMTokenService {
  static const String _boxName = 'fcm_token';

  FCMTokenService._internal();

  static final FCMTokenService _instance = FCMTokenService._internal();

  factory FCMTokenService() {
    return _instance;
  }

  Future<Box> _init() async {
    await Hive.openBox(_boxName);
    return Hive.box(_boxName);
  }

  Future<void> writeFCMToken(String fcmToken) async {
    final box = await _init();
    await box.put('fcmToken', fcmToken);
  }

  Future<String?> getFCMToken() async {
    final box = await _init();
    final token = await box.get('fcmToken');
    return token;
  }

  Future<void> deleteFCMToken() async {
    final box = await _init();
    box.delete('fcmToken');
    box.clear();
  }
}

