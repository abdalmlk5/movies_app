import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<void> saveJson({
    required String key,
    required dynamic value,
  }) async {
    await _storage.write(key: key, value: jsonEncode(value));
  }

  static Future<dynamic> getJson({
    required String key,
  }) async {
    String? jsonString = await _storage.read(key: key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getData({
    required String key,
  }) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteData({
    required String key,
  }) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  static Future<bool> containsKey({
    required String key,
  }) async {
    return await _storage.containsKey(key: key);
  }
}
