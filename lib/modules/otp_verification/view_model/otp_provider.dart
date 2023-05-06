// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/modules/home/view/home_page.dart';
import 'package:flutter_chat_demo/modules/otp_verification/api_services/api_services.dart';
import 'package:flutter_chat_demo/modules/otp_verification/model/otp_model.dart';
import 'package:flutter_chat_demo/modules/sign_up/model/sign_up_model.dart';
import 'package:flutter_chat_demo/modules/sign_up/model_view/sign_up_provider.dart';
import 'package:flutter_chat_demo/services/apppref.dart';
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
      otp: otp,
    );

    SignUpResponse resp = await OtpApiService().otpVerified(
      data,
    );

    if (resp.success == "otp verified") {
      try {
        await auth
            .createUserWithEmailAndPassword(
                email: context.read<SignUpProvider>().email.text,
                password: context.read<SignUpProvider>().password.text)
            .then((value) async {
          context.read<SignUpProvider>().podtDetailsToFirebase(context);
          AppPref.userToken =
              await FirebaseAuth.instance.currentUser!.getIdToken();
          AppPref.useruid = FirebaseAuth.instance.currentUser!.uid;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
      }
      Fluttertoast.showToast(
        msg: "otp verified",
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      Fluttertoast.showToast(
        msg: "opps something went wrong",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
