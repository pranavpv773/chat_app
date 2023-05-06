import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/modules/sign_up/model_view/sign_up_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/textforms.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SignUpProvider>().disposeControll();
    return Scaffold(
      body: ListView(
        shrinkWrap: false,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: context.read<SignUpProvider>().signUpKey,
              child: Column(
                children: [
                  SignUpTextforms(
                    icon: Icons.person_outline_outlined,
                    text: "UserName",
                    obscureText: false,
                    vertical: 20,
                    controller: context.read<SignUpProvider>().userName,
                  ),
                  SignUpTextforms(
                    icon: Icons.mail_outline_sharp,
                    text: "Email",
                    obscureText: false,
                    vertical: 15,
                    controller: context.read<SignUpProvider>().email,
                  ),
                  SignUpTextforms(
                    icon: Icons.send_to_mobile_rounded,
                    text: "Phone",
                    obscureText: false,
                    vertical: 15,
                    controller: context.read<SignUpProvider>().phoneNumber,
                  ),
                  PasswordTextforms(
                    icon: Icons.lock_outline,
                    text: "Password",
                    obscureText: context.watch<SignUpProvider>().obsecurePass,
                    vertical: 15,
                    controller: context.read<SignUpProvider>().password,
                    // suffix: IconButton(
                    //     onPressed: () {
                    //       context.read<SignUpProvider>().obSecurePassFn();
                    //     },
                    //     icon: Icon(context.watch<SignUpProvider>().obsecurePass
                    //         ? Icons.visibility_rounded
                    //         : Icons.visibility_off_rounded)),
                  ),
                  PasswordTextforms(
                    icon: Icons.lock_reset_outlined,
                    text: "Confirm Password",
                    obscureText:
                        context.watch<SignUpProvider>().obsecureConfirm,
                    vertical: 15,
                    controller: context.read<SignUpProvider>().confirmPassword,
                    // suffix: IconButton(
                    //     onPressed: () {
                    //       context.read<SignUpProvider>().obSecureConfirmFn();
                    //     },
                    //     icon: Icon(
                    //         context.watch<SignUpProvider>().obsecureConfirm
                    //             ? Icons.visibility_rounded
                    //             : Icons.visibility_off_rounded)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 120,
                          vertical: 15,
                        ),
                        backgroundColor: Colors.amber,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      onPressed: (() {
                        context.read<SignUpProvider>().signUp(
                              context,
                            );
                      }),
                      child: const Text(
                        "SIGN UP",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
