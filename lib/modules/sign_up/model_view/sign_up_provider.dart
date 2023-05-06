// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/models/user_modal.dart';
import 'package:flutter_chat_demo/modules/pages.dart';
import 'package:flutter_chat_demo/services/apppref.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        // final data = EmailOtp(
        //   email: email.text,
        // );

        // SignUpResponse? resp = await OtpApiService().signUp(data);
        // if (resp!.status) {
        //   context.read<OtpVerifyProvider>().otpToken = resp.id!;
        // }
        // Fluttertoast.showToast(
        //   msg: resp.message,
        //   toastLength: Toast.LENGTH_LONG,
        // );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => OtpVerificationScreen(),
        //   ),
        // );
        podtDetailsToFirebase(context);
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
    await auth
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then(
      (value) async {
        AppPref.userToken =
            await FirebaseAuth.instance.currentUser!.getIdToken();
        AppPref.useruid = FirebaseAuth.instance.currentUser!.uid;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
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
}
