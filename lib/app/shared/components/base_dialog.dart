import 'package:flutter/material.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class BaseDialog {
  static void show(
    BuildContext context,
    String title,
    String message,
    List<Widget>? actions,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title.toUpperCase(),
            style: AppTextStyle.titleStyle,
            textAlign: TextAlign.center,
          ),
          content: SelectableText(
            message,
            style: AppTextStyle.subtitleStyle,
            textAlign: TextAlign.center,
          ),
          actions: actions,
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
