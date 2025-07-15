import 'package:flutter/material.dart';

class AppTheme {
  static const successColor = Colors.green;
  static const warningColor = Colors.orange;

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[50],
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      surface: Colors.white,
      error: Colors.red,
      onSurfaceVariant: Colors.grey,
      onError: Colors.white,
    ),
    textTheme: Typography.blackCupertino,
  );
}
