import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  AppStorage._(this._preferences, this._secureStorage);

  final SharedPreferences _preferences;
  final FlutterSecureStorage _secureStorage;

  static Future<AppStorage> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage();
    return AppStorage._(prefs, secureStorage);
  }

  Future<void> writeSecure(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecure(String key) {
    return _secureStorage.read(key: key);
  }

  Future<void> deleteSecure(String key) {
    return _secureStorage.delete(key: key);
  }

  Future<void> writeString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? readString(String key) {
    return _preferences.getString(key);
  }

  Future<void> delete(String key) async {
    await _preferences.remove(key);
  }

  Future<void> writeBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool? readBool(String key) {
    return _preferences.getBool(key);
  }

  Future<void> writeJson(String key, Object value) async {
    await _preferences.setString(key, jsonEncode(value));
  }

  T? readJson<T>(String key, T Function(Object? data) convert) {
    final raw = _preferences.getString(key);
    if (raw == null) {
      return null;
    }
    final decoded = jsonDecode(raw);
    return convert(decoded);
  }
}

final appStorageProvider = Provider<AppStorage>((ref) {
  throw UnimplementedError('Call bootstrap before reading AppStorage');
});
