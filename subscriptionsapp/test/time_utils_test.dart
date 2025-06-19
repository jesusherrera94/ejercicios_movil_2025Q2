// dart
import 'package:flutter_test/flutter_test.dart';
import 'package:subscriptionsapp/utils/time_utils.dart';

void main() {
  group('timestampToDatestring', () {
    test('formats known timestamp correctly', () {
      // 1 Jan 2023, 00:00:00 UTC
      final timestamp = 1672531200;
      final result = timestampToDatestring(timestamp);
      expect(result, '01-01-2023');
    });

    test('formats epoch timestamp', () {
      final result = timestampToDatestring(0);
      expect(result, '01-01-1970');
    });

    test('formats leap year date', () {
      // 29 Feb 2020, 00:00:00 UTC
      final timestamp = 1582934400;
      final result = timestampToDatestring(timestamp);
      expect(result, '29-02-2020');
    });

    test('formats future date', () {
      // 31 Dec 2050, 00:00:00 UTC
      final timestamp = 2556057600;
      final result = timestampToDatestring(timestamp);
      expect(result, '31-12-2050');
    });
  });
}