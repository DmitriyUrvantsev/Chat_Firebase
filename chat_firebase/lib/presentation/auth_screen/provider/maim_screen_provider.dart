import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

import '../../../core/app_export.dart';

class MainScreenProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController yourNameController = TextEditingController();
  TextEditingController yourSurNameController = TextEditingController();
  String? uid;

//---------------------------------------------------------------------------
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService; // Поле для хранения DatabaseService
  final FirebaseApi _firebaseApi = FirebaseApi();
  UserApp? _userData;
  UserApp? get userData => _userData;

  MainScreenProvider({required DatabaseService databaseService})
      : _databaseService = databaseService;

//!=======AUTH============================================================

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> isChekAuth() async {
    final accountId = await _sessionDataProvider.getAccountId();
    print('AuthScreenProvider Id из секюрити стораж - $accountId');
    _isAuth = accountId != null;
    print('_isAuth - $_isAuth');
  }

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

  UserAppData? userAppData;
  AsyncSnapshot<UserAppData>? snapShot;

  void saveAccuontData() {
    if (formKey.currentState?.validate() ?? false) {
      currentName = yourNameController.text.substring(0, 1).toUpperCase() +
          yourNameController.text.substring(1).toLowerCase();

      currentSurName =
          yourSurNameController.text.substring(0, 1).toUpperCase() +
              yourSurNameController.text.substring(1).toLowerCase();
      print(yourNameController.text);
      print(yourSurNameController.text);
      saveChangesData();
    }
  }

//-------------Сохраненеи имени фамилии на сервере---------------------------------
  Future<void> saveChangesData() async {
    try {
      User? user = await _authService.signInAnon();
      if (user != null) {
        _userData = UserApp(uid: user.uid);
        uid = user.uid;


// Загрузка изображения и получение URL
        if (photo != null) {
          
          final avatarUrl = await _firebaseApi.uploadAvatar(uid!, photo!);
          currentAvatar = avatarUrl; // Сохраняем ссылку на аватар
        }
//-----------------------


        await _databaseService.updateUserData(
            currentName, currentSurName, currentAvatar, uid);
        print('Данные успешно обновлены для пользователя с uid: ${user.uid}');
        notifyListeners();
      } else {
        print('Ошибка: пользователь не зарегистрирован');
      }
    } catch (e) {
      print('Ошибка при сохранении данных: $e');
    }
  }

//---------------- Авторизация на сервере ------------------------------------
  Future singIn() async {
    AuthService().signInAnon();
  }
//
 Future singOut() async {
    AuthService().signOut();
    
  }

//==============================================================================

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
