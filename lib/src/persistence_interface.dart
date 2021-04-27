import 'package:meta/meta.dart';

abstract class IPersistence {
  Future<Object?> get(String key);
  Future<void> remove(String key);
  Future<void> set(String key, Object value);
  Future<bool> containsKey(String key);
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
  Future<int?> getInt(String key);
  Future<void> setInt(String key, int value);
  Future<double?> getDouble(String key);
  Future<void> setDouble(String key, double value);
  Future<bool?> getBool(String key);
  Future<void> setBool(String key, bool value);
  Future<Map?> getMap(String key);
  Future<void> setMap(String key, Map value);
  Future<void> clear();

  Future<List<Map>> getMapList(String key) async {
    var response = <Map>[];
    final map = await getMap(key);
    if (map != null) response = (map["values"] as List).cast<Map>();
    return response;
  }

  Future<void> setMapList(String key, Iterable<Map> values) async {
    await setMap(key, {"values": values.toList()});
  }
}
