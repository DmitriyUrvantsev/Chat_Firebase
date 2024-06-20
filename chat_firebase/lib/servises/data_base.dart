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

  //! ---------userFromFireBase list from snapshot ---------
  //! List<UserFromFirebase> _taskListFromSnapshot(QuerySnapshot snapshot) {
  //!   return snapshot.docs.map((doc) {
  //!     return UserFromFirebase(
  //!       name: doc.get('name') ?? '0',
  //!       surName: doc.get('surName') ?? '0',
  //!     );
  //!   }).toList();
  //! }

// ---------user data from snapshots ---------
  UserAppData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserAppData(
      uid: uid,
      name: snapshot.get('name'),
      surName: snapshot.get('surName'),
     currentAvatar: snapshot.get('currentAvatar'),
    );
  }

  //! ---------получение tasks stream ---------//!=============
  //! Stream<List<UserFromFirebase>> get tasks {
  //!   return taskCollection.snapshots().map(_taskListFromSnapshot);
  //! }

  // --------- получение user doc stream ---------//!============
  Stream<UserAppData> get userData {
    return userCollection
        .doc(uid)
        .snapshots()
        .map((e) => _userDataFromSnapshot(e));
  }

  // ---------получение всех пользователей stream ---------
  Stream<List<UserAppData>> get allUsers {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => _userDataFromSnapshot(doc)).toList();
    });
  }

}
