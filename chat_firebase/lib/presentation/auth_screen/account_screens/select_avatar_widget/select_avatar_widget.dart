// lib/presentation/auth_screen/account_screens/select_avatar_widget/select_avatar_widget.dart

import 'package:flutter/material.dart';
import 'package:chat_firebase/core/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../provider/maim_screen_provider.dart';
import 'avatar_icon_widget.dart';

class SelectAvatarWidget extends StatelessWidget {
  const SelectAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    return Column(
      children: [
        SizedBox(
          height: 80.adaptSize,
          width: 80.adaptSize,
          child: Stack(children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 2.h, top: 5),
                  height: 70.adaptSize,
                  width: 70.adaptSize,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                SvgPicture.asset(
                  ImageConstant.imgGroup1,
                  height: 76.adaptSize,
                  width: 76.adaptSize,
                ),
                const AvatarIconWidget()
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => read.showImageSource(context),
                child: SvgPicture.asset(
                  ImageConstant.imgCloseGray100,
                  width: 31.0,
                  height: 31.0,
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
