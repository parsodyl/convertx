// Copyright (c) 2019, Daniele Paradiso.
// Use of this source code is governed by a BSD-style license that can be found
// in the LICENSE file.

/// Basically a wrapper around [dart:convert], which allows you to use Dart
/// static extension methods (sdk >= 2.6.0) with [String] and [Uint8List].
///
/// You can also call `.toJsonString()` on any Dart object.
library convertx;

export 'src/extensions.dart';
