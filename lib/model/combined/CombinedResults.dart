// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:erstegroup_api_consumer/constant/BackendParamConstants.dart';
import 'package:erstegroup_api_consumer/model/combined/CombinedResult.dart';
import 'package:erstegroup_api_consumer/model/combined/wrapper/CombinedResultWrapper.dart';

/// The wrapper for combined results.
@immutable
class CombinedResults {
  final List<CombinedResultWrapper> _combinedResultsWrappers = [];

  /// Creates instance from Json.
  /// Json must contain the [PARAM_COMBINED_RESULTS] key.
  CombinedResults.fromJson(final Map<String, dynamic> newCombinedResults) {
    newCombinedResults[PARAM_COMBINED_RESULTS].forEach((dynamic value) {
      _combinedResultsWrappers.add(CombinedResultWrapper(CombinedResult.fromJson(value)));
    });
  }

  /// The method get the wrapped [CombinedResult]`s.
  List<CombinedResultWrapper> get combinedResultsWrappers => _combinedResultsWrappers;
}
