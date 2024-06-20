import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_firebase/core/utils/image_constant.dart';
import 'package:chat_firebase/data/data_providers/session_data_provider.dart';
import 'package:chat_firebase/data/models/user/user_app.dart';
import 'package:chat_firebase/routes/app_routes.dart';
import 'package:chat_firebase/servises/auth_servises.dart';
import 'package:chat_firebase/servises/data_base.dart';
import 'package:chat_firebase/widgets/custom_bottom_bar.dart';
import 'package:image_picker/image_picker.dart';

class MainScreenProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController yourNameController = TextEditingController();
  TextEditingController yourSurNameController = TextEditingController();
  String? uid;

  //---------------------------------------------------------------------------
  // int _currentMainScreenIndex = 0;
  // int get currentMainScreenIndex => _currentMainScreenIndex;

  // List<BottomMenuModel> bottomMenuList = [
  //   BottomMenuModel(
  //     icon: ImageConstant.imgNav,
  //     activeIcon: ImageConstant.imgNav,
  //     title: 'Мои проекты',
  //     type: BottomBarEnum.tf,
  //   ),
  //   BottomMenuModel(
  //     icon: ImageConstant.imgNavLightBlueA700,
  //     activeIcon: ImageConstant.imgNavLightBlueA700,
  //     title: 'Мой аккаунт',
  //     type: BottomBarEnum.tf,
  //   )
  // ];

//!=======AUTH============================================================

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> isChekAuth() async {
    final accountId = await _sessionDataProvider.getAccountId();
    print('AuthScreenProvider Id из секюрити стораж - $accountId');
    _isAuth = accountId != null;
    print('_isAuth - $_isAuth');
  }

//!=======MainScreenModel==================================================
  // void toglleIndex(int index) {
  //   _currentMainScreenIndex = index;
  //   notifyListeners();
  // }

  // void backProjectScreen() {
  //   _currentMainScreenIndex = 0;
  //   notifyListeners();
  // }
  ///============== проверка заполнености текстФилдов ============================
 bool _isFormValid = false;

  bool get isFormValid => _isFormValid;

  void validateForm() {
    _isFormValid = yourNameController.text.isNotEmpty &&
        yourSurNameController.text.isNotEmpty;
    notifyListeners();
  }
//!=======AccountScreenModel==================================================

  String? currentName;
  String? currentSurName;
  String? currentAvatar;

  UserAppData? userData;
  AsyncSnapshot<UserAppData>? snapShot;

  void saveAccuontData() {
    if (formKey.currentState?.validate() ?? false) {
      currentName = yourNameController.text;
      currentSurName = yourSurNameController.text;
      print(yourNameController.text);
      print(yourSurNameController.text);
      //saveChangesData();
    }
  }

//-------------Сохраненеи имени фамилии на сервере---------------------------------
  Future saveChangesData() async {
    await DatabaseService(uid: userData?.uid ?? uid ?? '').updateUserData(
      //! разберись с id
      currentName ?? snapShot?.data?.name,
      currentSurName ?? snapShot?.data?.surName,
      // currentAvatar ?? snapShot?.data?.avatar,
    );
    notifyListeners();
  }

//!=======Form Name Model==================================================
  void inputName(context) async {
    if (formKey.currentState?.validate() ?? false) {
      currentName = yourNameController.text.substring(0, 1).toUpperCase() +
          yourNameController.text.substring(1).toLowerCase();
      saveChangesData();
      yourNameController.text = '';
      notifyListeners();
      Navigator.pop(context);
    }
  }
//==============================================================================

//!=======Form SurName Model==================================================
  Future inputSurName(context) async {
    if (formKey.currentState?.validate() ?? false) {
      currentSurName =
          yourSurNameController.text.substring(0, 1).toUpperCase() +
              yourSurNameController.text
                  .substring(
                    1,
                  )
                  .toLowerCase();
      saveChangesData();
      yourSurNameController.text = '';
      notifyListeners();
      Navigator.pop(context);
    }
  }

//!=========Avatar Model========================================================
//!=========Avatar Model========================================================
//!=========Avatar Model========================================================

  final imagePicer = ImagePicker();
  File? photo;
  UploadTask? uploadTask;

//=====================функция загрузки фото на сервер==========================
  Future pickImage(ImageSource source) async {
    // final read = context.read<MainScreenProvider>();
    try {
      final myImage = await imagePicer.pickImage(source: source);
      if (myImage == null) {
        return;
      }
      photo = await File(myImage.path);

      //! final path = 'files/avatar$uid.jpg';
      //! final ref = FirebaseStorage.instance.ref().child(path);
      //! uploadTask = ref.putFile(photo!);

      //! final snapshot = await uploadTask!.whenComplete(() {});
      //! final urlDownload = await snapshot.ref.getDownloadURL();
      //! currentAvatar = urlDownload;
      notifyListeners();
      print(photo);
      //}
    } on PlatformException catch (e) {
      print('проблемы с $e');
    }
  }

//==============================================================================
  final _sessionDataProvider = SessionDataProvider();

  void backPop(context) {
//_sessionDataProvider.setAccountId(null);
    AuthService().signOut();
    Navigator.of(context)
        .pushReplacementNamed(AppNavigationRoutes.selectorLoading);

    notifyListeners();
  }
  //==============================================================================
//

  @override
  void dispose() {
    super.dispose();
    yourNameController.dispose();
    yourSurNameController.dispose();
  }
}
