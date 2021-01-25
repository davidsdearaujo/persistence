import 'dart:async';

import 'persistence_interface.dart';
import 'rxdart/behavior_subject.dart';

abstract class IPersistenceSubject<T> extends Stream<T> with Sink<T> {
  String get key;
  IPersistence get persistence;
  T? get value => controller.valueWrapper?.value;
  late BehaviorSubject<T> controller;

  T fromMap(Map map);
  Map toMap(T model);

  IPersistenceSubject(T initialValue) {
    controller = BehaviorSubject<T>.seeded(initialValue);
    if (initialValue != null) {
      controller.add(initialValue);
    }
  }

  Future close() => controller.close();
  Future<void> initialize() async {
    final map = await persistence.getMap(key);
    if (map != null) {
      final value = fromMap(map);
      if (value != null) controller.add(value);
    }
  }

  @override
  Future<void> add(T data) async {
    controller.add(data);
    final map = toMap(data);
    await persistence.setMap(key, map);
  }

  @override
  StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return controller.listen(onData, cancelOnError: cancelOnError, onDone: onDone, onError: onError);
  }
}
