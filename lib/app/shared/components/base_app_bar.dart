// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tourney_craft/app/shared/themes/themes.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final bool showCenterIcons;
  final String title;

  const BaseAppBar({
    super.key,
    this.leading,
    this.actions,
    this.showCenterIcons = true,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.white,
      title: showCenterIcons && title.isEmpty
          ? const SizedBox()
          : Text(
              title.toUpperCase(),
              style: AppTextStyle.titleSmallStyle,
            ),
      centerTitle: true,
      leading: leading,
      actions: actions,
      flexibleSpace: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: AppColors.darkPrimary,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.35),
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: showCenterIcons ? 8 : 25),
          child: showCenterIcons && title.isEmpty
              ? Image.asset(
                  'assets/images/tatu_head.png',
                  width: MediaQuery.sizeOf(context).width * 0.45,
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
