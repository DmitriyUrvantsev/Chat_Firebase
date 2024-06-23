// lib/services/image_service.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile == null) {
        return null;
      }
      return File(pickedFile.path);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return null;
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context, Function(ImageSource) onImagePicked) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          message: Text(
            'Выберете фото',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          cancelButton: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Закрыть',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ), 
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                onImagePicked(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Text(
                'Камера',
                style: TextStyle(),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                onImagePicked(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Text(
                'Галерея Фото',
                style: TextStyle(),
              ),
            ),
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
              leading: Icon(Icons.camera_alt_outlined, color: Colors.blue),
              title: Text(
                'Камерa',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                onImagePicked(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: Colors.blue),
              title: Text(
                'Галерея',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                onImagePicked(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  //! Новый метод для загрузки изображения в Firebase Storage
  Future<String> uploadImage(String chatId, File image) async {
    final storageRef = FirebaseStorage.instance.ref().child('chat_images').child(chatId).child(DateTime.now().millisecondsSinceEpoch.toString());
    final uploadTask = storageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
