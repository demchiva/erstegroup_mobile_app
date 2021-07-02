// Dart imports:
import 'dart:async';

// Package imports:
import 'package:http/http.dart';

// Project imports:
import 'package:erstegroup_api_consumer/constant/BackendParamConstants.dart';
import 'package:erstegroup_api_consumer/util/config/ConfigUtils.dart';

/// The class for accessing remote repository endpoints (backend).
class Remote {
  Remote._();

  static const String _URL_BASE = "erste_backend_url";
  static const Duration _MAX_DURATION = Duration(seconds: 30);


  /// The remote endpoint for combined results.
  static Future<Response> uploadCombinedResults() async =>
      _get(
        '/combinedResults',
      );

  /// The remote endpoint for combined results greater then given amount.
  static Future<Response> uploadCombinedResultsWithAmount(final String amount) async =>
      _get(
        '/combinedProductsMoreThanAmount',
          {
            PARAM_PRODUCT_AMOUNT: amount,
          }
      );

  static Future<Response> _get(
    String route, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final Map<String, String> headers = await _createHeaders();

    final Request request = Request(
      'GET',
      Uri.https(ConfigUtils.me.cfg[_URL_BASE], route, queryParameters),
    )..followRedirects = false;

    request.headers.addAll(headers);

    return Response.fromStream(
      await request.send().timeout(_MAX_DURATION),
    );
  }

  static Future<Map<String, String>> _createHeaders() async {
    final Map<String, String> newHeaders = {
      HEADER_CONTENT_TYPE: 'application/json',
      HEADER_ACCEPT: 'application/json',
    };

    return newHeaders;
  }
}
