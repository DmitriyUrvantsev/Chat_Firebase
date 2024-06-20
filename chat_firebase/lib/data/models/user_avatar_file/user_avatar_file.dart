import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageFile {
  final Reference ref;
  final String name;
  final String url;

  const FirebaseStorageFile({
    required this.ref,
    required this.name,
    required this.url,
  });
}
