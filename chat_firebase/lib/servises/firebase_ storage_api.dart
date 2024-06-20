import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat_firebase/data/models/user_avatar_file/user_avatar_file.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseApi {
  // static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
  //     Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  // static Future<List<FirebaseStorageFile>> listAll(String path) async {
  //   final ref = FirebaseStorage.instance.ref(path);
  //   final result = await ref.listAll();

  //   final urls = await _getDownloadLinks(result.items);

  //   return urls
  //       .asMap()
  //       .map((index, url) {
  //         final ref = result.items[index];
  //         final name = ref.name;
  //         final file = FirebaseStorageFile(ref: ref, name: name, url: url);

  //         return MapEntry(index, file);
  //       })
  //       .values
  //       .toList();
  // }

  // static Future downloadFile(Reference ref) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/${ref.name}');

  //   await ref.writeToFile(file);
  // }
//!-----------------------------------------------------------------------------

 final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadAvatar(String uid, File photo) async {
    try {
      //final ref = _storage.ref().child('avatars/$uid.jpg');
      final ref = _storage.ref().child('users/$uid/avatar.jpg');

      await ref.putFile(photo);

      final url = await ref.getDownloadURL();
      print('Ссылка на загруженное изображение: $url');
      return url; // Возвращаем URL загруженного изображения
    } catch (e) {
      print('Ошибка при загрузке изображения: $e');
      rethrow; // Перебрасываем ошибку для обработки в вызывающем коде
    }
  }
}
