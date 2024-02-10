import 'package:flutter/material.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class BaseBottomMessage {
  static void showMessage(
    BuildContext context,
    String message,
    Color backgroundColor,
  ) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message.toUpperCase(),
          style: AppTextStyle.subtitleStyle.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      margin: EdgeInsets.all(12),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
