import '../persistence_interface.dart';

class VolatilePersistence extends IPersistence {
  final _data = {};

  @override
  Future<void> remove(String key) async => _data.remove(key);

  @override
  Future<bool> containsKey(String key) async => _data.containsKey(key);

  @override
  Future<dynamic> get(String key) async => _data[key];

  @override
  Future<bool?> getBool(String key) async => _data[key];

  @override
  Future<double?> getDouble(String key) async => _data[key];

  @override
  Future<int?> getInt(String key) async => _data[key];

  @override
  Future<Map?> getMap(String key) async => _data[key];

  @override
  Future<String?> getString(String key) async => _data[key];

  @override
  Future<void> set(String key, dynamic value) async => _data[key] = value;

  @override
  Future<void> setBool(String key, bool value) async => _data[key] = value;

  @override
  Future<void> setDouble(String key, double value) async => _data[key] = value;

  @override
  Future<void> setInt(String key, int value) async => _data[key] = value;

  @override
  Future<void> setMap(String key, Map value) async => _data[key] = value;

  @override
  Future<void> setString(String key, String value) async => _data[key] = value;

  @override
  Future<void> clear() async => _data.clear();
}
