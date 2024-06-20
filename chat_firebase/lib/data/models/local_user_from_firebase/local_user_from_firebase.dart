// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserFromFirebase {
  final String? uid;
  final String? name;
  final String? surName;
  final String? avatar; //URL
  //так как  urlDownload = await snapshot.ref.getDownloadURL();

  UserFromFirebase({
    this.uid,
    this.name,
    this.surName,
    this.avatar,
  });
}

//! надо добить  будет
