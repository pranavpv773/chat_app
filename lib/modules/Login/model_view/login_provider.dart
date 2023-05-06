import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../home/view/home_page.dart';

class LoginProvider with ChangeNotifier {
  final userName = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool obsecure = false;
  onTabLoginFunction(
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(
                email: email.text, password: password.text)
            .then(
              (value) => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                )
              },
            );
        notifyListeners();
        email.clear();
        password.clear();
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    await auth.signOut();
  }

  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  obSecureFn() {
    if (obsecure == false) {
      obsecure = true;
      notifyListeners();
    } else {
      obsecure = false;
      notifyListeners();
    }
  }
}
