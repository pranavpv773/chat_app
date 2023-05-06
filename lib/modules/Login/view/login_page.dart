import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/constants/app_constants.dart';
import 'package:flutter_chat_demo/constants/color_constants.dart';
import 'package:flutter_chat_demo/modules/sign_up/view/sign_up.dart';
import 'package:flutter_chat_demo/providers/auth_provider.dart';
import 'package:flutter_chat_demo/modules/Login/model_view/login_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.loginTitle,
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Consumer<LoginProvider>(builder: (_, a, child) {
        return Column(
          children: <Widget>[
            Form(
              key: context.read<LoginProvider>().formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 40, left: 40),
                    child: TextFormField(
                      validator: (input) {
                        return null;

                        // return input!.isEmpty
                        //     ? "email is empty"
                        //     : context.read<LoginProvider>().isValidEmail(input)
                        //         ? null
                        //         : "Check your email";
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: context.read<LoginProvider>().email,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.mail,
                            color: Colors.amber,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 2.0,
                          ),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 40, left: 40),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " Please fill this field";
                        } else if (value.length < 6) {
                          return " Password is less than six";
                        }
                        return null;
                      },
                      controller: context.read<LoginProvider>().password,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      obscuringCharacter: '*',
                      obscureText: context.watch<LoginProvider>().obsecure,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.key, color: Colors.amber),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.teal,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              context.read<LoginProvider>().obSecureFn();
                            },
                            icon: Icon(context.watch<LoginProvider>().obsecure
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded)),
                        hintText: "password",
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
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
                          onPressed: context.watch<LoginProvider>().loading
                              ? () {}
                              : (() async {
                                  context
                                      .read<LoginProvider>()
                                      .onTabLoginFunction(
                                        context,
                                      );
                                }),
                          child: Text(
                            a.loading ? "Loading..." : "LOGIN",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Center(
                  child: TextButton(
                    onPressed: () async {
                      context.read<AuthProvider>().handleSignIn();
                    },
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Color(0xffdd4b39).withOpacity(0.8);
                          return Color(0xffdd4b39);
                        },
                      ),
                      splashFactory: NoSplash.splashFactory,
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.fromLTRB(30, 15, 30, 15),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: authProvider.status == Status.authenticating
                      ? LoadingView()
                      : SizedBox.shrink(),
                ),
              ],
            ),
            // Loading
            const SizedBox(
              height: 20,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpScreen(),
                    ),
                  );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color(0xffdd4b39).withOpacity(0.8);
                      return Color(0xffdd4b39);
                    },
                  ),
                  splashFactory: NoSplash.splashFactory,
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(30, 15, 30, 15),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
