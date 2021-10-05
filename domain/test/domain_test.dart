import 'package:domain/model.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = User();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome, isNotNull);
    });
  });
}
