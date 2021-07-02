// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:erstegroup_api_consumer/constant/BackendParamConstants.dart';
import 'package:erstegroup_api_consumer/model/combined/CombinedProduct.dart';

/// The model class for combined result.
@immutable
class CombinedResult {
  final String _accountNumber;
  final List<CombinedProduct> _combinedProducts = [];

  /// Create instance from json.
  /// Json must contain [PARAM_ACCOUNT_NUMBER] and [PARAM_PRODUCTS] keys.
  CombinedResult.fromJson(final Map<String, dynamic> newCombinedResult)
  : _accountNumber = newCombinedResult[PARAM_ACCOUNT_NUMBER] {
    newCombinedResult[PARAM_PRODUCTS].forEach((dynamic value) {
      _combinedProducts.add(CombinedProduct.fromJson(value));
    });
  }

  /// The method get the account number bind to products amount.
  String get accountNumber => _accountNumber;

  /// The method get the products list.
  List<CombinedProduct> get combinedProducts => _combinedProducts;
}
