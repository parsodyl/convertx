// Copyright (c) 2019, Daniele Paradiso.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

extension StringConvertExtension<T extends String> on T {
  /// Converts this string into a list of ASCII bytes.
  ///
  /// The codec used is compliant with the standard "us-ascii" (ISO-IR-006).
  Uint8List asciiEncode() => ascii.encode(this);

  /// Converts this [base64](https://tools.ietf.org/html/rfc4648)-encoded
  /// string into a list of bytes.
  ///
  /// It decodes using both the base64 and base64url alphabets,
  /// does not allow invalid characters and requires padding.
  Uint8List base64Decode() => base64.decode(this);

  /// Converts this [base64url](https://tools.ietf.org/html/rfc4648)-encoded
  /// string into a list of bytes.
  ///
  /// It decodes using both the base64 and base64url alphabets,
  /// does not allow invalid characters and requires padding.
  Uint8List base64UrlDecode() => base64Url.decode(this);

  /// Converts this string into something equivalent escaping all characters
  /// with special meaning in HTML.
  ///
  /// This is intended to sanitize text before inserting the text into an HTML
  /// document. Characters that are meaningful in HTML are converted to
  /// HTML entities (like `&amp;` for `&`).
  String htmlEscapeConvert() => htmlEscape.convert(this);

  /// Parses this string and returns the resulting JSON object.
  ///
  /// The optional [reviver] function is called once for each object or list
  /// property that has been parsed during decoding. The `key` argument is either
  /// the integer list index for a list property, the string map key for object
  /// properties, or `null` for the final result.
  ///
  /// The default [reviver] (when not provided) is the identity function.
  dynamic jsonDecode({dynamic Function(Object key, Object value) reviver}) =>
      json.decode(this, reviver: reviver);

  /// Coverts this string into a list of Latin 1 bytes.
  ///
  /// The codec used is compliant with the standard "ISO-8859-1" (ISO-IR-100).
  Uint8List latin1Encode() => latin1.encode(this);

  /// Converts this string into a list of UTF-8 code units (bytes).
  Uint8List utf8Encode() => utf8.encode(this) as Uint8List;

  // SHORTHANDS

  /// Converts this string into a list of ASCII bytes.
  ///
  /// Shorthand for [asciiEncode].
  Uint8List toAsciiByteList() => asciiEncode();

  /// Converts this [base64](https://tools.ietf.org/html/rfc4648)-encoded
  /// string into a list of bytes.
  ///
  /// Shorthand for [base64Decode].
  Uint8List toBase64ByteList() => base64Decode();

  /// Converts this [base64url](https://tools.ietf.org/html/rfc4648)-encoded
  /// string into a list of bytes.
  ///
  /// Shorthand for [base64UrlDecode].
  Uint8List toBase64UrlByteList() => base64UrlDecode();

  /// Converts this string into something equivalent escaping all characters
  /// with special meaning in HTML.
  ///
  /// Shorthand for [htmlEscapeConvert].
  String escapeHtml() => htmlEscapeConvert();

  /// Parses this string and returns the resulting JSON object.
  ///
  /// Shorthand for [jsonDecode].
  dynamic toDecodedJson({dynamic Function(Object key, Object value) reviver}) =>
      jsonDecode(reviver: reviver);

  /// Coverts this string into a list of Latin 1 bytes.
  ///
  /// Shorthand for [latin1Encode].
  Uint8List toLatin1ByteList() => latin1Encode();

  /// Converts this string into a list of UTF-8 code units (bytes).
  ///
  /// Shorthand for [utf8Encode].
  Uint8List toUtf8ByteList() => utf8Encode();
}

extension Uint8ListConvertExtension on Uint8List {
  /// Decodes this list of ASCII bytes to the corresponding string.
  ///
  /// If [allowInvalid] is `true`, the converter will default to allowing invalid
  /// values, which will be decoded into the Unicode Replacement character
  /// `U+FFFD` (�). If not, an exception will be thrown.
  String asciiDecode({bool allowInvalid = false}) =>
      ascii.decode(this, allowInvalid: allowInvalid);

  /// Encodes this list of bytes using
  /// [base64](https://tools.ietf.org/html/rfc4648) encoding.
  String base64Encode() => base64.encode(this);

  /// Encodes this list of bytes using
  /// [base64url](https://tools.ietf.org/html/rfc4648) encoding.
  String base64UrlEncode() => base64Url.encode(this);

  /// Decodes this list of Latin 1 bytes to the corresponding string.
  String latin1Decode() => latin1.decode(this);

  /// Decodes this list of UTF-8 code units (bytes) to the corresponding string.
  ///
  /// If [allowMalformed] is `true` the decoder replaces invalid (or
  /// unterminated) character sequences with the Unicode Replacement character
  /// `U+FFFD` (�). Otherwise it throws a [FormatException].
  String uft8Decode({bool allowMalformed = false}) =>
      utf8.decode(this, allowMalformed: allowMalformed);

  // SHORTHANDS

  /// Decodes this list of ASCII bytes to the corresponding string.
  ///
  /// Shorthand for [asciiDecode].
  String toAsciiString({bool allowInvalid = false}) =>
      asciiDecode(allowInvalid: allowInvalid);

  /// Encodes this list of bytes using
  /// [base64](https://tools.ietf.org/html/rfc4648) encoding.
  ///
  /// Shorthand for [base64Encode].
  String toBase64String() => base64Encode();

  /// Encodes this list of bytes using
  /// [base64url](https://tools.ietf.org/html/rfc4648) encoding.
  ///
  /// Shorthand for [base64UrlEncode].
  String toBase64UrlString() => base64UrlEncode();

  /// Decodes this list of Latin 1 bytes to the corresponding string.
  ///
  /// Shorthand for [latin1Decode].
  String toLatin1String({bool allowInvalid = false}) => latin1Decode();

  /// Decodes this list of UTF-8 code units (bytes) to the corresponding string.
  ///
  /// Shorthand for [uft8Decode].
  String toUtf8String({bool allowMalformed = false}) =>
      uft8Decode(allowMalformed: allowMalformed);
}

extension JsonConvertExtension<T> on T {
  /// Converts this object to a JSON string.
  ///
  /// If this objects contains other objects that are not directly encodable to
  /// a JSON string (a value that is not a number, boolean, string, null, list
  /// or a map with string keys), the [toEncodable] function is used to convert
  /// it to an object that must be directly encodable.
  ///
  /// If [toEncodable] is omitted, it defaults to a function that returns the
  /// result of calling `.toJson()` on the unencodable object.
  String jsonEncode({dynamic Function(dynamic object) toEncodable}) {
    return json.encode(this, toEncodable: toEncodable);
  }

  // SHORTHANDS

  /// Converts this object to a JSON string.
  ///
  /// Shorthand for [jsonEncode].
  String toJsonString({dynamic Function(dynamic object) toEncodable}) =>
      jsonEncode(toEncodable: toEncodable);
}
