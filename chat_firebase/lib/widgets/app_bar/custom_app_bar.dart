// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chat_firebase/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.backgroundColor,
    this.actions,
    this.bottom,
  });

  final double? height;
  final Style? styleType;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      elevation: 0,
      toolbarHeight: height ?? 42.v,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 42.v,
      );
}

enum Style {
  bgShadow,
}
