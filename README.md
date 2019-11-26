# convertx

Static extension methods for converting between different data representations (aka **dart:convert** superpowered).

## Getting started

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  dartx: ^[version]
```
Then import this, so you can use the extensions:

```dart
import 'package:convertx/convertx.dart';
```
## Overview

Convertx exposes the most common dart:convert functionalities.

### base64:

```dart
final base64String = 'Hello World!'.toUtf8ByteList().toBase64String();
print(base64String); // SGVsbG8gV29ybGQh

final originalString = base64String.toBase64ByteList().toUtf8String();
print(originalString); // Hello World!
```

### JSON:

```dart
final jsonString = {'answer': 42}.toJsonString();
print(jsonString); // {"answer":42}

final originalMap = jsonString.toDecodedJson() as Map;
print(originalMap); // {answer: 42}
```

### Escape HTML:

```dart
final html = '<strong>Romeo & Juliet</strong>'.escapeHtml();
print(html); // &lt;strong&gt;Romeo &amp; Juliet&lt;&#47;strong&gt;
```

### Common string codecs:

```dart
// ASCII
print('Hello World!'.toAsciiByteList().toAsciiString()); // Hello World!

// Latin1
print('¡Hola Mundo!'.toLatin1ByteList().toLatin1String()); // ¡Hola Mundo!

// UTF-8
print('你好，世界！'.toUtf8ByteList().toUtf8String()); // 你好，世界！
```