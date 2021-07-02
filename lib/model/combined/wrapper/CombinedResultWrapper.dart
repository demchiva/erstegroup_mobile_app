// Project imports:
import 'package:erstegroup_api_consumer/model/combined/CombinedResult.dart';
import 'package:flutter/material.dart';

/// The wrapper for CombinedResult.
/// Used for controls [ExpansionPanelList] items.
class CombinedResultWrapper {
  bool shouldShowContent = false;
  final CombinedResult _combinedResult;

  /// The basic public constructor.
  CombinedResultWrapper(this._combinedResult);

  /// The method get the wrapped object.
  CombinedResult get combinedResult => _combinedResult;
}
