//import 'dart:typed_data';

import 'package:convertx/convertx.dart';
import 'package:test/test.dart';

void main() {
  group('any String', () {
    // declare input
    String input;
    group('should be converted into', () {
      group('a list of ASCII bytes', () {
        // prepare runner
        testRunner() => input.toAsciiByteList();
        test('(success)', () {
          // prepare input
          input = 'Hello World!';
          // declare matcher
          final matcher =
              equals([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]);
          // check
          expect(testRunner(), matcher);
        });
        test('(argument error)', () {
          // prepare input
          input = '¡Hola Mundo!';
          // declare matcher
          final matcher = throwsArgumentError;
          // check
          expect(testRunner, matcher);
        });
      });
      group('a list of Latin1 bytes', () {
        // prepare runner
        testRunner() => input.toLatin1ByteList();
        test('(success)', () {
          // prepare input
          input = '¡Hola Mundo!';
          // declare matcher
          final matcher =
              equals([161, 72, 111, 108, 97, 32, 77, 117, 110, 100, 111, 33]);
          // check
          expect(testRunner(), matcher);
        });
        test('(argument error)', () {
          // prepare input
          input = '你好，世界！';
          // declare matcher
          final matcher = throwsArgumentError;
          // check
          expect(testRunner, matcher);
        });
      });
      group('a list of UTF-8 bytes', () {
        // prepare runner
        testRunner() => input.toUtf8ByteList();
        test('(success #1)', () {
          // prepare input
          input = '你好，世界！';
          // declare matcher
          final matcher = equals([228, 189, 160, 229, 165, 189, 239, 188, 140] +
              [228, 184, 150, 231, 149, 140, 239, 188, 129]);
          // check
          expect(testRunner(), matcher);
        });
        test('(success #2)', () {
          // prepare input
          input = '👋🌍!';
          // declare matcher
          final matcher = equals([240, 159, 145, 139, 240, 159, 140, 141, 33]);
          // check
          expect(testRunner(), matcher);
        });
      });
      group('an escaped html string', () {
        // prepare runner
        testRunner() => input.escapeHtml();
        test('(success #1)', () {
          // prepare input
          input = '<strong>Hello World!</strong>';
          // declare matcher
          final matcher =
              equals('&lt;strong&gt;Hello World!&lt;&#47;strong&gt;');
          // check
          expect(testRunner(), matcher);
        });
        test('(success #2)', () {
          // prepare input
          input = 'Hello World!';
          // declare matcher
          final matcher = equals(input);
          // check
          expect(testRunner(), matcher);
        });
      });
    });
  });
  group('a base64 String', () {
    // declare input
    String input;
    group('should be converted into a list of bytes', () {
      // prepare runner
      testRunner() => input.toBase64ByteList();
      test('(success #1)', () {
        // prepare input
        input = 'SGVsbG8gV29ybGQh';
        // declare matcher
        final matcher =
            equals([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]);
        // check
        expect(testRunner(), matcher);
      });
      test('(success #2)', () {
        // prepare input
        input = '+//H';
        // declare matcher
        final matcher = equals([251, 255, 199]);
        // check
        expect(testRunner(), matcher);
      });
      test('(success #3)', () {
        // prepare input
        input = '-__H';
        // declare matcher
        final matcher = equals([251, 255, 199]);
        // check
        expect(testRunner(), matcher);
      });
      test('(format exception #1)', () {
        // prepare input
        input = 'Hello World!';
        // declare matcher
        final matcher = throwsFormatException;
        // check
        expect(testRunner, matcher);
      });
      test('(format exception #2)', () {
        // prepare input
        input = 'YW5';
        // declare matcher
        final matcher = throwsFormatException;
        // check
        expect(testRunner, matcher);
      });
    });
  });
  group('a base64Url String', () {
    // declare input
    String input;
    group('should be converted into a list of bytes', () {
      // prepare runner
      testRunner() => input.toBase64UrlByteList();
      test('(success #1)', () {
        // prepare input
        input = 'SGVsbG8gV29ybGQh';
        // declare matcher
        final matcher =
            equals([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 33]);
        // check
        expect(testRunner(), matcher);
      });
      test('(success #2)', () {
        // prepare input
        input = '+//H';
        // declare matcher
        final matcher = equals([251, 255, 199]);
        // check
        expect(testRunner(), matcher);
      });
      test('(success #3)', () {
        // prepare input
        input = '-__H';
        // declare matcher
        final matcher = equals([251, 255, 199]);
        // check
        expect(testRunner(), matcher);
      });
      test('(format exception #1)', () {
        // prepare input
        input = 'Hello World!';
        // declare matcher
        final matcher = throwsFormatException;
        // check
        expect(testRunner, matcher);
      });
      test('(format exception #2)', () {
        // prepare input
        input = 'YW5';
        // declare matcher
        final matcher = throwsFormatException;
        // check
        expect(testRunner, matcher);
      });
    });
  });
  group('a JSON String', () {
    // declare input
    String input;
    group('should be converted into a Dart object', () {
      group('w/out using reviver', () {
        // prepare runner
        dynamic testRunner() => input.toDecodedJson();
        test('(success #1)', () {
          // prepare input
          input = '{"hello":"world"}';
          // declare matcher
          final matcher = equals({'hello': 'world'});
          // check
          expect(testRunner(), matcher);
        });
        test('(success #2)', () {
          // prepare input
          input = '["Athos", "Porthos", "Aramis"]';
          // declare matcher
          final matcher = equals({'Athos', 'Porthos', 'Aramis'});
          // check
          expect(testRunner(), matcher);
          // other checks
          expect(testRunner(), isNot(isA<Set>()));
        });
        test('(format exception)', () {
          // prepare input
          input = '{"hello":"world}';
          // declare matcher
          final matcher = throwsFormatException;
          // check
          expect(testRunner, matcher);
        });
      });
      group('w/ using reviver', () {
        // prepare runner
        dynamic testRunner() => input.toDecodedJson(reviver: (key, value) {
              if (value is List) {
                return Set<String>.from(value);
              }
              return value;
            });
        test('(success)', () {
          // prepare input
          input = '["Athos", "Porthos", "Aramis"]';
          // declare matcher
          final matcher = equals({'Athos', 'Porthos', 'Aramis'});
          // check
          expect(testRunner(), matcher);
          // other checks
          expect(testRunner(), isA<Set>());
        });
      });
    });
  });
}
