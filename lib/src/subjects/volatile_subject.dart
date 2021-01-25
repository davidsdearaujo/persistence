import '../implementations/volatile_persistence.dart';
import '../persistence_subject_interface.dart';

class VolatileSubject extends IPersistenceSubject<String> {
  @override
  final String key;

  @override
  final VolatilePersistence persistence;
  VolatileSubject(this.persistence, {this.key = "mock-key", String initialValue = ""}) : super(initialValue);

  @override
  String fromMap(Map map) => map["value"];

  @override
  Map toMap(String data) => {"value": data};
}
