import 'package:flutter/material.dart';
import 'package:chat_firebase/core/app_export.dart';

// ignore: must_be_immutable
class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage(
      {super.key,
      this.imagePath,
      this.margin,
      required this.onTap,
      this.color});

  String? imagePath;
  Color? color;
  EdgeInsetsGeometry? margin;

  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,

      child: InkWell(
        onTap: () => onTap(),
        child: CustomImageView(
          color: color,
          imagePath: imagePath,
          height: 20.v,
          width: 15.h,
          fit: BoxFit.contain,
        ),
      ),
      //),
    );
  }
}
