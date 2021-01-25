import 'dart:async';

import 'package:test/test.dart';
import 'package:persistence/src/implementations/volatile_persistence.dart';
import 'package:persistence/src/persistence_subject_interface.dart';
import 'package:persistence/src/subjects/volatile_subject.dart';

void main() {
  late VolatilePersistence persistence;
  late IPersistenceSubject<String> subject;

  group("operations", () {
    final mockInitialValue = "initial-value";
    final mockKey = "mock-key";
    tearDownAll(() => subject.close());
    setUpAll(() {
      persistence = VolatilePersistence();
      subject = VolatileSubject(persistence, initialValue: mockInitialValue, key: mockKey);
    });
    test("add", () async {
      final mockData = "mock-data";
      await subject.add(mockData);
      emitsInOrder([mockInitialValue, mockData]);
      final storageData = await persistence.get(mockKey);
      expect(storageData != null, true);
      expect(storageData["value"], mockData);
    });
    test("update", () async {
      final mockData = "mock-data2";
      await subject.add(mockData);
      emits(mockData);
      final storageData = await persistence.get(mockKey);
      expect(storageData != null, true);
      expect(storageData["value"], mockData);
    });
  });

  group("behavior subject validation", () {
    final mockInitialValue = "initial-value";
    final mockKey = "mock-key";
    final listen1 = <String>[];
    final listen2 = <String>[];
    final listen3 = <String>[];
    final listen4 = <String>[];
    tearDownAll(() {
      subject.close();
      persistence.clear();
    });
    setUpAll(() async {
      persistence = VolatilePersistence();
      subject = VolatileSubject(persistence, initialValue: mockInitialValue, key: mockKey);

      subject.listen(listen1.add);
      subject.listen(listen2.add);
      await subject.add("first-value");
      await subject.add("seccond-value");
      subject.listen(listen3.add);
      await subject.add("third-value");
      subject.listen(listen4.add);
      await Future.delayed(Duration(milliseconds: 50));
    });
    test("validate emmits", () async {
      expect(listen1, [mockInitialValue, "first-value", "seccond-value", "third-value"]);
      expect(listen2, [mockInitialValue, "first-value", "seccond-value", "third-value"]);
      expect(listen3, ["seccond-value", "third-value"]);
      expect(listen4, ["third-value"]);
    });

    test("validate storage", () async {
      final data = await persistence.get(mockKey);
      expect(data, {"value": "third-value"});
    });
  });
}
