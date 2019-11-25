import 'package:convertx/convertx.dart';

void main() {
  // base64
  final base64String = 'Hello World!'.toUtf8ByteList().toBase64String();
  print(base64String); // SGVsbG8gV29ybGQh
  final originalString = base64String.toBase64ByteList().toUtf8String();
  print(originalString); // Hello World!

  // JSON
  final jsonString = {'answer': 42}.toJsonString();
  print(jsonString); // {"answer":42}
  final originalMap = jsonString.toDecodedJson() as Map;
  print(originalMap); // {answer: 42}

  // escape HTML
  final html = '<strong>Romeo & Juliet</strong>'.escapeHtml();
  print(html); // &lt;strong&gt;Romeo &amp; Juliet&lt;&#47;strong&gt;

  // ASCII codec
  print('Hello World!'.toAsciiByteList().toAsciiString()); // Hello World!

  // Latin1 codec
  print('¡Hola Mundo!'.toLatin1ByteList().toLatin1String()); // ¡Hola Mundo!

  // UTF-8 codec
  print('你好，世界！'.toUtf8ByteList().toUtf8String()); // 你好，世界！
}
