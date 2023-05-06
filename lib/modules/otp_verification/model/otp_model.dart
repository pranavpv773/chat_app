// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  String otp;

  OtpModel({
    required this.otp,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}

class OtpVerifyResponse {
  OtpVerifyResponse({
    required this.status,
    required this.message,
    this.jwt,
  });

  bool status;
  String message;
  String? jwt;

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        jwt: json["jwt"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "jwt": jwt,
      };
}
