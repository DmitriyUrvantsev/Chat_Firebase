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
      //flexibleSpace: _getStyle(),
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
  // _getStyle() {
  //   switch (styleType) {
  //     case Style.bgShadow:
  //       return Container(
  //         height: 43.v,
  //         width: double.maxFinite,
  //         decoration: BoxDecoration(
  //           color: appTheme.gray100,
  //           boxShadow: [
  //             BoxShadow(
  //               color: appTheme.black9004c,
  //               spreadRadius: 2.h,
  //               blurRadius: 2.h,
  //               offset: const Offset(
  //                 0,
  //                 1,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     default:
  //       return null;
  //   }
  // }
}

enum Style {
  bgShadow,
}
