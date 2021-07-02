// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

/// Thrown when backend response.statusCode == [HttpStatus.serviceUnavailable]
/// for Combined results loading.
@immutable
class CombineResultsServerException implements Exception {}
