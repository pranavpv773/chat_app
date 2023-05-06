// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/models/user_modal.dart';
import 'package:flutter_chat_demo/modules/otp_verification/api_services/api_services.dart';
import 'package:flutter_chat_demo/modules/otp_verification/view/otp_screen.dart';
import 'package:flutter_chat_demo/modules/pages.dart';
import 'package:flutter_chat_demo/modules/sign_up/model/sign_up_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpProvider with ChangeNotifier {
  final signUpKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel loggedUserModelH = UserModel();
  bool obsecurePass = false;
  bool obsecureConfirm = false;
  void signUp(
    BuildContext context,
  ) async {
    if (signUpKey.currentState!.validate()) {
      if (password.text != confirmPassword.text) {
        Fluttertoast.showToast(msg: "password not matching!");
      } else {
        final data = SignUpModel(
          userMail: email.text,
          userPassword: password.text,
          userName: userName.text,
          phoneNumber: int.parse(phoneNumber.text),
        );

        SignUpResponse? resp = await OtpApiService().signUp(data);
        if (resp!.success == "otp send successfully") {
          Fluttertoast.showToast(
            msg: "otp send successfully",
            toastLength: Toast.LENGTH_LONG,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(),
            ),
          );
          // );  context.read<OtpVerifyProvider>().otpToken = resp.id!;
        }
      }
    }
  }

  void podtDetailsToFirebase(BuildContext context) async {
    // calling our fireStore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    //calling our userModel

    loggedUserModelH.email = user!.email;
    loggedUserModelH.uid = user.uid;
    loggedUserModelH.username = userName.text;
    loggedUserModelH.phone = phoneNumber.text;
    loggedUserModelH.aboutMe = "";
    loggedUserModelH.photoUrl = "";

    //sending details to fireStore
    await firebaseFirestore.collection('users').doc(user.uid).set(
          loggedUserModelH.toMap(),
        );
    disposeControll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
    // context.read<SnackTProvider>().successSnack(context);
  }

  obSecurePassFn() {
    if (obsecurePass == false) {
      obsecurePass = true;
      notifyListeners();
    } else {
      obsecurePass = false;
      notifyListeners();
    }
  }

  obSecureConfirmFn() {
    if (obsecureConfirm == false) {
      obsecureConfirm = true;
      notifyListeners();
    } else {
      obsecureConfirm = false;
      notifyListeners();
    }
  }

  disposeControll() {
    userName.clear();
    phoneNumber.clear();
    email.clear();
    confirmPassword.clear();
    password.clear();
  }

  void googleLogIn(BuildContext context) async {
    try {
      notifyListeners();
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        print(e.message);
        throw e;
      }
      // await auth
      //     .signInWithCredential(GoogleAuthProvider.credential(
      //         accessToken: cred.accessToken, idToken: cred.idToken))
      //     .then((value) {
      //result.displayName;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      //  });

      notifyListeners();
      Fluttertoast.showToast(
        msg: "Succesfully Logged in",
        toastLength: Toast.LENGTH_LONG,
      );
    } on FirebaseAuthException catch (exe) {
      Fluttertoast.showToast(
        msg: exe.message.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
      notifyListeners();
    }
  }
}
