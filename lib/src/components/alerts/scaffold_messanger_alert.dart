import 'package:flutter/material.dart';
import 'package:rrfx/src/components/colors/default.dart';

// Enum untuk tipe SnackBar, memudahkan kustomisasi
enum SnackBarType {
  success,
  error,
  info,
  warning,
}

class CustomScaffoldMessanger {
  static void showAppSnackBar(
      BuildContext context, {
        required String message,
        SnackBarType type = SnackBarType.info, // Default type is info
        Duration duration = const Duration(seconds: 3),
        SnackBarAction? action,
      }) {
    Color backgroundColor;
    Color textColor = Colors.white; // Default text color

    // Tentukan warna latar belakang berdasarkan tipe SnackBar
    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        break;
      case SnackBarType.info:
        backgroundColor = CustomColor.secondaryColor;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating, // Opsional: membuat SnackBar mengambang
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Opsional: sudut membulat
        ),
        margin: const EdgeInsets.all(10), // Opsional: margin dari tepi layar
      ),
    );
  }
}