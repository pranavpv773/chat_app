import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/modules/otp_verification/view_model/otp_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/card_widget.dart';
import 'widgets/lottie_img.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          const LottieImageWidget(),
          Stack(
            children: [
              Container(
                height: size.height * 0.45,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                        0.1,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      offset: const Offset(
                        2.0,
                        5.0,
                      ),
                    ),
                  ],
                ),
                child: const CardWidget(),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.40,
                  ),
                  child: SizedBox(
                    width: size.width * 0.5,
                    height: 50.0,
                    child: ElevatedButton(
                      // elevation: 10.0,
                      // color: AppColor.primary,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(
                      //     100.0,
                      //   ),
                      // ),
                      onPressed: () {
                        context.read<OtpVerifyProvider>().otpVerifing(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Continue",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                35.0,
                              ),
                            ),
                            child: SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: Icon(
                                Icons.chevron_right,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
