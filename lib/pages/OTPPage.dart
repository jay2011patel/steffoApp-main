import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:pinput/pinput.dart';
import 'package:stefomobileapp/pages/newPassPage.dart';

import '../UI/common.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OTPContent();
  }
}

class OTPContent extends StatefulWidget {
  @override
  State<OTPContent> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPContent> {
  bool submitValid = false;
  final TextEditingController otp = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  EmailOTP myAuth = EmailOTP();

  // late EmailAuth emailAuth;
  // EmailAuth emailAuth =EmailAuth(sessionName: "sessionName");
  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the package
  //   emailAuth = new EmailAuth(
  //     sessionName: "Sample session",
  //   );
  //   /// Configuring the remote server
  //   // emailAuth.config(remoteServerConfiguration);
  // }
  // void verify() {
  //   print(emailAuth.validateOtp(
  //       recipientMail: email.toString(),
  //       userOtp: otp.text));
  // }

  // final _pinPutController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ))
        ],
        title: Center(
          child: Text(
            "Verify Your Email",
            style: TextStyle(
                color: Color.fromRGBO(19, 59, 78, 1.0),
                fontFamily: "Poppins-bold",
                fontSize: 24),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Center(
        // padding: EdgeInsets.only(top: 60),
        // color: Colors.white,
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Padding(padding: EdgeInsets.only(top: 60)),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 60)),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.asset("assets/images/otp.png"),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        // Text(
                        //   "Forget Password",
                        //   style: TextStyle(
                        //     fontSize: 32,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          maxLength: 4,
                          controller: otp,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // suffixIcon: TextButton(
                            //   child: Text("Send OTP"),
                            //   onPressed: ()=>sendOTP(),
                            // ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            labelText: "Enter OTP",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          // validator: EmailValidator(errorText: "Not Valid"),
                          style: TextStyle(fontSize: 20),
                        ),

                        SizedBox(
                          height: 40,
                        ),
                        // ElevatedButton(
                        //     onPressed: () async {
                        //       if (await myAuth.verifyOTP(otp: otp.text) == true) {
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(const SnackBar(
                        //                content: Text("OTP is verified"),
                        //         ));
                        //       } else {
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(const SnackBar(
                        //                content: Text("Invalid OTP"),
                        //         ));
                        //       }
                        //     },
                        //     child: const Text("Verify")),

                        Container(
                            width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.only(bottom: 20),
                            // padding: EdgeInsets.only(top: 50),
                            // alignment: FractionalOffset.bottomCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // height: 60,
                            child: buttonStyle(
                              "Verify",
                              () async {
                                print(otp.text);
                                if (await myAuth.verifyOTP(
                                        otp: otp.toString()) ==
                                    true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP is verified"),
                                  ));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewPassPage()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Invalid OTP"),
                                  ));
                                }
                                // Navigator.of(context).pushNamed("/OTP");
                              },
                            )),

                        // Container(
                        //   child: darkRoundedPinPut(),
                        // ),
                        // Container(
                        //   width: 250,
                        //   height: 50,
                        //   child: ElevatedButton(onPressed: () async {
                        //         if (await myauth.verifyOTP(otp: _otpController.text) == true) {
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(const SnackBar(
                        //               content: Text("OTP is verified"),
                        //               ));
                        //               } else {
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(const SnackBar(
                        //                   content: Text("Invalid OTP"),
                        //     ));
                        //         }
                        //         },
                        //         child: const Text("Verify"),
                        //
                        //     // verifyOTP();
                        //     // Navigator.of(context).pushNamed("/newPass");
                        //       // child: Text("Verify",style: TextStyle(fontSize: 20),)
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
