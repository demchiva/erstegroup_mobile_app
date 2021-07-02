// Dart imports:
import 'dart:convert';
import 'dart:io';

// Flutter imports:
import 'package:erstegroup_api_consumer/constant/BackendParamConstants.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:erstegroup_api_consumer/exception/combined/CombineResultsServerException.dart';
import 'package:erstegroup_api_consumer/model/combined/CombinedResults.dart';
import 'package:erstegroup_api_consumer/remote/Remote.dart';

/// The business logic for combine results.
class CombinedResultProvider with ChangeNotifier {
  /// The singleton instance.
  static final CombinedResultProvider me = CombinedResultProvider._();

  CombinedResultProvider._();

  /// The wrapped CombinedResult list.
  CombinedResults? wrapper;

  /// The method loads the combined results.
  /// Throws exception on status code not equals [HttpStatus.ok].
  void loadCombinedResults() async {
    final Response response = await Remote.uploadCombinedResults();

    if (response.statusCode == HttpStatus.ok) {
      _resetValue();
      final Map<String, dynamic> parsedResponse =
          json.decode(utf8.decode(response.bodyBytes));
      wrapper = CombinedResults.fromJson(parsedResponse);
      notifyListeners();
    } else if (response.statusCode == HttpStatus.serviceUnavailable) {
      throw CombineResultsServerException();
    } else {
      throw Exception();
    }
  }

  /// The method loads combined results with products
  /// with amount greater than [amount].
  /// On empty amount load all products without amount check.
  /// Throws exception on status code not equals [HttpStatus.ok].
  Future<void> loadCombineResultsWithAmount(final String amount) async {
    _resetValue();

    if (amount.isEmpty) {
      return loadCombinedResults();
    }

    final Response response =
        await Remote.uploadCombinedResultsWithAmount(amount);

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> parsedResponse =
          json.decode(utf8.decode(response.bodyBytes));
      wrapper = CombinedResults.fromJson(parsedResponse);
      notifyListeners();
    } else if (response.statusCode == HttpStatus.serviceUnavailable) {
      loadCombinedResults();
      throw CombineResultsServerException();
    } else {
      loadCombinedResults();
      final Map<String, dynamic> parsedResponse =
          json.decode(utf8.decode(response.bodyBytes));
      throw Exception(parsedResponse[PARAM_ERROR_MESSAGE]);
    }
  }

  void _resetValue() {
    wrapper = null;
    notifyListeners();
  }
}
