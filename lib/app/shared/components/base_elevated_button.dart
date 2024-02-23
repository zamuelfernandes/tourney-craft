import 'package:flutter/material.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class BaseElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Widget? labelWidget;
  final Color? color;

  const BaseElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelWidget,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    return SizedBox(
      width: sizeOf.width * .55,
      height: sizeOf.height * .1,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: labelWidget ??
              Text(
                label.toUpperCase(),
                style: AppTextStyle.titleStyle.copyWith(
                  fontSize: 19,
                ),
                textAlign: TextAlign.center,
              ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            color ?? AppColors.black,
          ),
        ),
      ),
    );
  }
}
