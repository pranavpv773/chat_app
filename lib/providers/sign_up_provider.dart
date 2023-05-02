// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/models/user_modal.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pages/home_page.dart';

class SignUpProvider with ChangeNotifier {
  final signUpKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel loggedUserModelH = UserModel();
  void signUp(
    BuildContext context,
    String email,
    String password,
    String name,
    String phone,
    String confirmPass,
  ) async {
    if (signUpKey.currentState!.validate()) {
      if (password != confirmPass) {
        Fluttertoast.showToast(msg: "password not matching!");
      } else {
        try {
          await auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => {podtDetailsToFirebase(context)});
        } on FirebaseAuthException {
          Fluttertoast.showToast(msg: "Something went wrong!");
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

    //sending details to fireStore
    await firebaseFirestore.collection('users').doc(user.uid).set(
          loggedUserModelH.toMap(),
        );
    disposeControll();
    // context.read<SnackTProvider>().successSnack(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  disposeControll() {
    userName.clear();
    phoneNumber.clear();
    email.clear();
    confirmPassword.clear();
    password.clear();
  }
}
