// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final bool showCenterIcons;

  const BaseAppBar({
    super.key,
    this.leading,
    this.actions,
    this.showCenterIcons = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkPrimary,
      leading: leading,
      actions: actions,
      flexibleSpace: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: AppColors.darkPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: showCenterIcons
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.asset(
                  'assets/images/tatu_head.png',
                  width: MediaQuery.sizeOf(context).width * 0.45,
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
