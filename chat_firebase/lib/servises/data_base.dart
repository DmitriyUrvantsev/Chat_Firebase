import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_firebase/data/models/user/user_app.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService({required this.uid});

  // ---------ссылка на коллекцию ---------
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('chat_firebase');

  Future<void> updateUserData( String? name, String? surName, String? currentAvatar, String? uid) async {
    Map<String, dynamic> data = {
      'name': name,
      'surName': surName,
      'currentAvatar': currentAvatar,
    };
    return await userCollection.doc(uid).set(data);
  }




  // --------- получение user doc stream ---------//!============
  Stream<UserAppData> get userData {
    return userCollection
        .doc(uid)
        .snapshots()
        .map((e) => _userDataFromSnapshot(e));
  }

// ---------user data from snapshots ---------
  UserAppData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserAppData(
      uid: uid,
      name: snapshot.get('name'),
      surName: snapshot.get('surName'),
     currentAvatar: snapshot.get('currentAvatar'),
    );
  }








  // ---------получение всех пользователей stream ---------
  Stream<List<UserAppData>> get allUsers {
    return userCollection.snapshots().map((snapshot) => _userListFromSnapshot(snapshot));
  }
//
//
  List<UserAppData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => UserAppData(
              uid: doc.id,
              name: doc['name'] ?? '',
              surName: doc['surName'] ?? '',
              currentAvatar: doc['currentAvatar'],
            ))
        .where((user) => user.uid != uid) // Фильтрация текущего пользователя
        .toList();
  }


}
