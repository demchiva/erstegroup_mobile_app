// Flutter imports:
import 'package:flutter/material.dart';

/// The singleton utils class for work with modals.
class ModalUtils {
  /// The instance of the utils class.
  static final ModalUtils me = ModalUtils._();

  ModalUtils._();

  /// The method shows the alert with message and WAITS for the user action.
  Future<void> showSimpleAlertAsync(
      final String? message,
      final BuildContext context,
      ) =>
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              message!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  /// The method shows text field and wait
  Future<void> showSimpleTextField(
    final TextEditingController controller,
    final BuildContext context,
  ) =>
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
          ),
        ),
      );
}
