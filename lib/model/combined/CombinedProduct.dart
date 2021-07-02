// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:erstegroup_api_consumer/constant/BackendParamConstants.dart';

/// The model class for result product.
@immutable
class CombinedProduct {
  final double _amount;
  final String _description;
  final String _place;

  /// Creates instance from json.
  /// Json must contain [PARAM_PRODUCT_AMOUNT], [PARAM_PRODUCT_DESCRIPTION]
  /// and [PARAM_PRODUCT_PLACE] keys.
  CombinedProduct.fromJson(final Map<String, dynamic> newProduct)
    : _amount = newProduct[PARAM_PRODUCT_AMOUNT],
      _description = newProduct[PARAM_PRODUCT_DESCRIPTION],
      _place = newProduct[PARAM_PRODUCT_PLACE];

  /// The method get the product amount.
  double get amount => _amount;

  /// The method get the product description.
  String get description => _description;

  /// The method get the product place (country or region).
  String get place => _place;
}
