import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_chat_demo/modules/sign_up/model/sign_up_model.dart';
import 'package:flutter_chat_demo/modules/otp_verification/model/otp_model.dart';

class OtpApiService {
  otpVerified(OtpModel data) async {
    // log(data.userOtp.toString());
    try {
      Response response = await Dio().post(
          'https://chat-app-server-qvr3.onrender.com/api/verify-otp/',
          data: data.toJson());
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        // log(response.data.toString());
        return SignUpResponse.fromJson(response.data);
      } else {
        log('2executed');
        return SignUpResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      // log('message');
      return SignUpResponse.fromJson(e.response!.data);
    } catch (e) {
      log(e.toString());
      return SignUpResponse(success: e.toString());
    }
  }

  Future<SignUpResponse?> signUp(SignUpModel data) async {
    log('reached on sign up');
    try {
      Response response = await Dio().post(
          'https://chat-app-server-qvr3.onrender.com/api/send-email/',
          data: {
            "email": "pranavpv773@gmail.com",
          });
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return SignUpResponse.fromJson(response.data);
      } else {
        return SignUpResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      log(e.message!);
      return SignUpResponse.fromJson(e.response!.data);
    } catch (e) {
      log(e.toString());
      return SignUpResponse(success: e.toString());
    }
  }
}
