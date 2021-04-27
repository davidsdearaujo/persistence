import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../persistence_interface.dart';

class HivePersistence extends IPersistence {
  final boxCompleter = Completer<Box>();

  HivePersistence(String boxName) {
    Hive.initFlutter().whenComplete(() => boxCompleter.complete(Hive.openBox(boxName)));
  }

  @override
  Future<void> remove(String key) async {
    final box = await boxCompleter.future;
    return box.delete(key);
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await boxCompleter.future;
    return box.containsKey(key);
  }

  @override
  Future<Object?> get(String key) async {
    final box = await boxCompleter.future;
    return box.get(key);
  }

  @override
  Future<void> set(String key, dynamic value) async {
    final box = await boxCompleter.future;
    return box.put(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    final box = await boxCompleter.future;
    return box.get(key);
  }

  @override
  Future<int?> getInt(String key) async {
    final box = await boxCompleter.future;
    return box.get(key);
  }

  @override
  Future<String?> getString(String key) async {
    final box = await boxCompleter.future;
    return box.get(key);
  }

  @override
  Future<void> setDouble(String key, double value) async {
    final box = await boxCompleter.future;
    await box.put(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    final box = await boxCompleter.future;
    await box.put(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    final box = await boxCompleter.future;
    await box.put(key, value);
  }

  @override
  Future<Map?> getMap(String key) async {
    final box = await boxCompleter.future;
    return box.get(key);
  }

  @override
  Future<void> setMap(String key, Map value) async {
    final box = await boxCompleter.future;
    await box.put(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    final box = await boxCompleter.future;
    return box.get(key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    final box = await boxCompleter.future;
    await box.put(key, value);
  }

  @override
  Future<void> clear() async {
    final box = await boxCompleter.future;
    await box.clear();
  }
}
