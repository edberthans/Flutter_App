class User {
  final String uid;

  User({
    this.uid,

  });

}

class UserData {
  final String uid;
  final String name;
  // final DateTime datebirth;
  final String datebirth;
  final String gender;
  final String phone;
  final String picture;
  final bool verifiedDocument;
  final String docUrl;

  UserData({
    this.uid,
    this.name,
    this.datebirth,
    this.gender,
    this.phone,
    this.picture,
    this.verifiedDocument,
    this.docUrl,

  });

}