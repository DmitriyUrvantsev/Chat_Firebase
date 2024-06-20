import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_firebase/core/app_export.dart';
import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';
import 'package:chat_firebase/presentation/auth_screen/account_screens/select_avatar_widget/avatar_icon_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

                  //!=========================================================
                  SvgPicture.asset(
                    ImageConstant.imgGroup1,
                    height: 76.adaptSize,
                    width: 76.adaptSize,
                  ),

                  //!---------------Фото----------------------------------

                  const AvatarIconWidget()
                ],
              ),

              // ),
              //!=========================================================
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => showImageSource(context, read),
                  child:
                      //-------
                      SvgPicture.asset(
                    ImageConstant.imgCloseGray100,
                    width: 31.0,
                    height: 31.0,
                  ),
                  // Container(
                  //   //! иконка svg - кнопка выбора загрузки
                ),
              )
            ])),
      ],
    );
  }
}

//!==========================================================================

//!=============================================================================
//---------------------------ABATARKA-------------------------------------------
//!=============================================================================

//                                                                *
//                                                                *
//                                                                *
//              МЕНЮ ВЫБОРА ЗАГРУЗКИ ИЗОБРАЖЕНИЯ                  *
//                                                                *
//                                                                *
//                                                                *
//=========Метод диалога выбора загрузки===========================
Future<ImageSource?> showImageSource(BuildContext context, read) async {
  if (Platform.isIOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: Text(
          'Выберете фото',
          style: CustomTextStyles.bodyLargeLightblueA700.copyWith(
            color: appTheme.gray600,
          ),
        ),
        cancelButton: TextButton(
          onPressed: () {
            Navigator.of(context).pop(ImageSource.camera);
          },
          child: Text(
            'Закрыть',
            style: CustomTextStyles.bodyLargeLightblueA700PopUpBold,
          ),
        ), //!
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                read.pickImage(ImageSource.camera);
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: Text(
                'Камера',
                style: CustomTextStyles.bodyLargeLightblueA700PopUp,
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                read.pickImage(ImageSource.gallery);
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: Text(
                'Галерея Фото',
                style: CustomTextStyles.bodyLargeLightblueA700PopUp,
              )),
        ],
      ),
    );
  } else {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined,
                      color: PrimaryColors().lightBlueA700),
                  title: Text(
                    'Камерa',
                    style: CustomTextStyles.bodyLargeLightblueA700.copyWith(
                      color: appTheme.lightBlueA700,
                    ),
                  ),
                  onTap: () {
                    read.pickImage(ImageSource.camera);
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.image, color: PrimaryColors().lightBlueA700),
                  title: Text(
                    'Галерея',
                    style: CustomTextStyles.bodyLargeLightblueA700.copyWith(
                      color: appTheme.lightBlueA700,
                    ),
                  ),
                  onTap: () {
                    read.pickImage(ImageSource.gallery);
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
              ],
            ));
  }
}

//!===========================================================================

