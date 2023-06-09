import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/services/apppref.dart';
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
  bool loading = false;
  onTabLoginFunction(
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        loading = true;
        await auth
            .signInWithEmailAndPassword(
                email: email.text, password: password.text)
            .then(
          (value) async {
            return {
              AppPref.userToken =
                  await FirebaseAuth.instance.currentUser!.getIdToken(),
              AppPref.useruid = FirebaseAuth.instance.currentUser!.uid,
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              )
            };
          },
        );
        notifyListeners();
        email.clear();
        password.clear();
      } on FirebaseAuthException catch (e) {
        loading = false;
        Fluttertoast.showToast(msg: e.message.toString());
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    loading = true;
    AppPref().clear();
    await auth.signOut();
    loading = false;
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
