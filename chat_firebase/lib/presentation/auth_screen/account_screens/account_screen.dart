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

// ignore: must_be_immutable
class K3AccounrScreenWidget extends StatelessWidget {
  const K3AccounrScreenWidget({
    super.key,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    final watch = context.watch<MainScreenProvider>();
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: appTheme.gray100,
        appBar: _sectionAppBar(context),
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 24.v),
            child: Form(
              key: read.formKey,
              onChanged: () {
                read.validateForm();
              },
              child: Column(children: [
                //----------------------------------------
                const SelectAvatarWidget(),

                SizedBox(height: 17.v),

                SizedBox(height: 17.v),
                CustomFloatingTextField(
                    controller: read.yourNameController,
                    labelText: "Имя",
                    validator: (val) =>
                        val?.isEmpty ?? false ? 'Введите имя' : null,
                    labelStyle: CustomTextStyles.bodyLargeGray600,
                    hintText: "Иван"),
                SizedBox(height: 17.v),
                CustomFloatingTextField(
                    controller: read.yourSurNameController,
                    labelText: "Фамилия",
                    validator: (val) =>
                        val?.isEmpty ?? false ? 'Введите фамилию' : null,
                    labelStyle: CustomTextStyles.bodyLargeGray600,
                    hintText: "Иванов"),

                SizedBox(height: 40.v),
                CustomElevatedButton(
                  //isDisabled: false,
                  // decoration: BoxDecoration(color: Colors.amber),
                  onPressed: () {
                    read.saveAccuontData();
                  },
                  text: 'Сохранить и войти',
                  buttonStyle:
                      watch.isFormValid ? CustomButtonStyles.fillAmber : null,
                )
              ]),
            )),
      ),
    );
  }

  /// ======================AppBar==============================================
  PreferredSizeWidget _sectionAppBar(BuildContext context) {
    final read = context.read<MainScreenProvider>();
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
                text: 'Аккаунт',
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
}
