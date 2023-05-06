// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_demo/modules/otp_verification/api_services/api_services.dart';
import 'package:flutter_chat_demo/modules/otp_verification/model/otp_model.dart';
import 'package:flutter_chat_demo/modules/sign_up/model_view/sign_up_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

final otpController = TextEditingController();

class OtpVerifyProvider with ChangeNotifier {
  String otpToken = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  otpVerifing(
    BuildContext context,
  ) async {
    log('Reached');
    log(otpToken);
    final otp = otpController.text;
    log(otpController.text);

    final data = OtpModel(
      id: otpToken,
      userOtp: otp,
    );
    log(data.id);
    OtpVerifyResponse resp = await OtpApiService().otpVerified(
      data,
    );

    if (resp.status) {
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: context.read<SignUpProvider>().email.text,
                password: context.read<SignUpProvider>().password.text)
            .then((value) => {
                  context.read<SignUpProvider>().podtDetailsToFirebase(context)
                });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
      }
      Fluttertoast.showToast(
        msg: resp.message,
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      Fluttertoast.showToast(
        msg: resp.message,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
