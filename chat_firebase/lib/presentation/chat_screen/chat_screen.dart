import 'package:flutter/material.dart';
import 'package:chat_firebase/core/app_export.dart';
import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';
import 'package:chat_firebase/presentation/auth_screen/account_screens/select_avatar_widget/select_avatar_widget.dart';
import 'package:chat_firebase/widgets/app_bar/appbar_leading_image.dart';
import 'package:chat_firebase/widgets/app_bar/appbar_subtitle.dart';
import 'package:chat_firebase/widgets/app_bar/appbar_title.dart';
import 'package:chat_firebase/widgets/app_bar/custom_app_bar.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';
import 'provider/chat_provider.dart';

// ignore: must_be_immutable
class ChatScreenWidget extends StatelessWidget {
  const ChatScreenWidget({
    super.key,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final read = context.read<ChatScreenProvider>();
    final watch = context.watch<ChatScreenProvider>();
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        appBar: _sectionAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 24.v),
            child: Column(children: [
              //----------------------------------------
              const Spacer(),
              CustomElevatedButton(
                //isDisabled: false,
                // decoration: BoxDecoration(color: Colors.amber),
                onPressed: () {
                  read.singIn();
                },
                text: 'Выйти',
                // buttonStyle:
                //     watch.isFormValid ? CustomButtonStyles.fillAmber : null,
              )
            ])),
      ),
    );
  }

  /// ======================AppBar==============================================
  PreferredSizeWidget _sectionAppBar(BuildContext context) {
    final read = context.read<ChatScreenProvider>();
    return CustomAppBar(
      backgroundColor: PrimaryColors().white, //!=================
      //height: 43.v,
      // leadingWidth: 28.h,
      // leading: AppbarLeadingImage(
      //     onTap: () => read.backProjectScreen(),
      //     color: PrimaryColors().lightBlueA700,
      //     imagePath: ImageConstant.imgArrowRight,
      //     margin: EdgeInsets.only(left: 8.h, top: 9.v, bottom: 12.v)),
      title: Padding(
          padding: EdgeInsets.only(right: 30.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            // AppbarSubtitle(
            //     onTap: () => read.backProjectScreen(),
            //     text: 'Мой аккаунт',
            //     margin: EdgeInsets.only(bottom: 1.v)),
            AppbarTitle(
                onTap: () => (),
                text: 'Чат',
                margin: EdgeInsets.only(left: 26.h))
          ])),
      // styleType: Style.bgShadow,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: PrimaryColors().gray600,
          height: 1.0,
        ),
      ),
    );
  }

  /// Common widget
  // Widget _sectionRowNameSurNameChous(
  //   BuildContext context, {
  //   required String action,
  //   required String action1,
  //   Function? onTapRow,
  // }) {
  //   return GestureDetector(
  //       onTap: () {
  //         onTapRow!.call();
  //       },
  //       child: Container(
  //           padding: EdgeInsets.fromLTRB(16.h, 12.v, 16.h, 11.v),
  //           decoration: AppDecoration.outlineGray,
  //           child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //             Text(action,
  //                 style: CustomTextStyles.bodyLargeOnPrimary
  //                     .copyWith(color: theme.colorScheme.onPrimary)),
  //             const Spacer(),
  //             Padding(
  //                 padding: EdgeInsets.only(top: 2.v),
  //                 child: Text(action1,
  //                     style: theme.textTheme.bodyLarge!
  //                         .copyWith(color: appTheme.gray600))),
  //             CustomImageView(
  //                 color: PrimaryColors().gray400,
  //                 imagePath: ImageConstant.imgArrowRightGray400,
  //                 height: 21.v,
  //                 width: 20.h,
  //                 margin: EdgeInsets.only(left: 10.h))
  //           ])));
  // }
}
