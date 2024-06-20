// ignore_for_file: public_member_api_docs, sort_constructors_first

// класс данных нашего User для aвторизации и получения uid
class UserApp {
  final String uid;

  UserApp({
    required this.uid,
  });
}

// класс данных нашего User для сохраниения и получения name // surName;
class UserAppData {
  final String uid;
  final String? name;
  final String? surName;
  final String? currentAvatar;

  UserAppData({
    required this.uid,
    required this.name,
    this.surName,
     this.currentAvatar,
  });
}
