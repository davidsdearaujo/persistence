import 'package:flutter/cupertino.dart';

abstract class Persistence {
  @protected
  Future<dynamic> get(String key);

  @protected
  Future<void> remove(String key);

  @protected
  Future<void> set(String key, dynamic value);

  @protected
  Future<bool> containsKey(String key);

  @protected
  Future<String> getString(String key);

  @protected
  Future<void> setString(String key, String value);

  @protected
  Future<int> getInt(String key);

  @protected
  Future<void> setInt(String key, int value);

  @protected
  Future<double> getDouble(String key);

  @protected
  Future<void> setDouble(String key, double value);

  @protected
  Future<bool> getBool(String key);

  @protected
  Future<void> setBool(String key, bool value);

  @protected
  Future<Map> getMap(String key);

  @protected
  Future<void> setMap(String key, Map value);

  @protected
  Future<List<Map>> getMapList(String key) async {
    var response = <Map>[];
    final map = await getMap(key);
    if (map != null) response = (map["values"] as List).cast<Map>();
    return response;
  }

  @protected
  Future<void> setMapList(String key, Iterable<Map> values) async {
    await setMap(key, {"values": values?.toList()});
  }

  Future<void> clear();

  void dispose();
}
