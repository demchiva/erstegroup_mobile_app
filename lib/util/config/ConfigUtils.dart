// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import 'package:erstegroup_api_consumer/constant/AssetConstants.dart';

/// The singleton utils class for work with configuration.
class ConfigUtils {
  /// The instance of the utils class.
  static final ConfigUtils me = ConfigUtils._();

  /// The version of the current backend API.
  static const int API_VERSION = 1;

  bool _isProduction = false;

  late Map<String, dynamic> _cfg;

  ConfigUtils._();

  /// The init method read all config files and fill properties.
  Future<void> init() async {
    _isProduction = const bool.fromEnvironment('dart.vm.product');
    final String configFile =
        _isProduction ? JSON_CONFIG_RELEASE_ASSET : JSON_CONFIG_DEBUG_ASSET;
    final String loadString = await rootBundle.loadString(configFile);
    _cfg = json.decode(loadString);
  }

  /// The config properties.
  Map<String, dynamic> get cfg => _cfg;

  /// The properties decides if it is a release or debug mode.
  bool get isProduction => _isProduction;
}
