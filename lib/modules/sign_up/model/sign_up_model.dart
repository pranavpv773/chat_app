class SignUpModel {
  SignUpModel({
    this.userMail,
    this.userPassword,
    this.userName,
    this.phoneNumber,
    this.aboutMe,
    this.photoUrl,
  });

  String? userMail;
  String? userName;
  int? phoneNumber;
  String? userPassword;
  String? photoUrl;
  String? aboutMe;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
      userMail: json["user_mail"],
      userPassword: json["user_password"],
      photoUrl: json["photoUrl"],
      aboutMe: json["aboutMe"],
      phoneNumber: json['user_number'] as int,
      userName: json['user_name']);

  Map<String, dynamic> toJson() => {
        "user_mail": userMail,
        "aboutMe": aboutMe,
        "photoUrl": photoUrl,
        "user_password": userPassword,
        "user_number": phoneNumber,
        "user_name": userName,
      };
}

class SignUpResponse {
  SignUpResponse({
    required this.status,
    required this.message,
    this.id,
  });

  bool status;
  String message;
  String? id;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "id": id,
      };
}

class EmailOtp {
  EmailOtp({
    this.email,
  });

  String? email;

  factory EmailOtp.fromJson(Map<String, dynamic> json) => EmailOtp(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
