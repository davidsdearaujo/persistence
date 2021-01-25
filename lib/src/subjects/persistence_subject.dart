
import '../persistence_interface.dart';
import '../persistence_subject_interface.dart';

class PersistenceSubject<T> extends IPersistenceSubject<T> {
  final T Function(Map) _fromMap;
  final Map Function(T) _toMap;
  final String key;
  final IPersistence persistence;

  PersistenceSubject(
    this.key, {
    required this.persistence,
    required T Function(Map) fromMap,
    required Map Function(T) toMap,
    required T initialValue,
    bool autoInitialize = true,
  })  : _fromMap = fromMap,
        _toMap = toMap,
        super(initialValue) {
    if (autoInitialize) initialize();
  }

  @override
  T fromMap(Map map) => _fromMap(map);

  @override
  Map toMap(T model) => _toMap(model);

}
