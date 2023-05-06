class UserModel {
  String? uid;
  String? username;
  String? email;
  String? phone;
  String? photoUrl;
  String? aboutMe;
  UserModel({
    this.uid,
    this.phone,
    this.username,
    this.email,
    this.aboutMe,
    this.photoUrl,
  });

//data from Server

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      phone: map['phone'],
      email: map['email'],
      aboutMe: map['aboutMe'],
      photoUrl: map['photoUrl'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'aboutMe': aboutMe,
    };
  }
}
