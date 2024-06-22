import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String> uploadImage(File image) async {
    try {
      final ref = _storage.ref().child('chat_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
