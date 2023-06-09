import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stefomobileapp/UI/common.dart';
import 'package:stefomobileapp/pages/OTPPage.dart';

class ForgetPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ForgetPasscontent();
  }
}

class ForgetPasscontent extends StatefulWidget {
  ForgetPasscontent({super.key});
  // final selected = 0;
  @override
  State<ForgetPasscontent> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPasscontent> {
  bool submitValid = true;

  final TextEditingController email = TextEditingController();
  final TextEditingController otp = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  // EmailAuth emailAuth =EmailAuth(sessionName: "sessionName");
  // void verify() {
  //   print(emailAuth.validateOtp(
  //       recipientMail: email.value.text,
  //       userOtp: otp.value.text));
  // }
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

  // void sendOtp() async {
  //   bool result = await emailAuth.sendOtp(
  //       recipientMail: email.toString(), otpLength: 4);
  //   if (result) {
  //     setState(() {
  //       submitValid = true;
  //     });
  //   }
  // }

  // final TextEditingController _otpController = TextEditingController();

  // void sendOTP()async{
  //   EmailAuth.sessionName="Test Session";
  //   var res = await EmailAuth.sendOtp(recipientMail: _emailController.text);
  //   if(res){
  //     print("OTP Sent");
  //   }else{
  //     print("We could not sent the otp");
  //   }
  //
  // }
  //
  // void verifyOTP(async){
  //   var res = EmailAuth.validate(recieverMail: _emailController.text,userOTP:_otpController.text);
  //   if(res){
  //     print("OTP verified");
  //   }else {
  //     print("Invalid OTP");
  //   }
  // }

  @override
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
            "Forgot Password",
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
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 60)),
                        SizedBox(
                          width: 200,
                          height: 200,
                          child:
                              Image.asset("assets/images/wrong-password.png"),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    // width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            // suffixIcon: TextButton(
                            //   child: Text("Send OTP"),
                            //   onPressed: ()=>sendOTP(),
                            // ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(5)
                            // ),
                            labelText: "E-mail",
                            prefixIcon: Icon(Icons.person, size: 30),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          validator: EmailValidator(errorText: "Not Valid"),
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // TextFormField(
                        //   // controller: _otpController,
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //     // border: OutlineInputBorder(
                        //     //   borderRadius: BorderRadius.circular(5)
                        //     // ),
                        //     labelText: "OTP",
                        //     labelStyle: TextStyle(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        //   validator: EmailValidator(errorText: "Not Valid"),
                        //   style: TextStyle(fontSize: 20),
                        // ),

                        SizedBox(
                          height: 40,
                        ),

                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // height: 60,
                            child: buttonStyle(
                              "Send Code",
                              () async {
                                myAuth.setConfig(
                                    appEmail: "contact@gmail.com",
                                    appName: "Email",
                                    userEmail: email.text,
                                    otpLength: 4,
                                    otpType: OTPType.digitsOnly);
                                if (await myAuth.sendOTP() == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("OTP has been sent")));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OTPPage()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Oops, OTP sent fails, Please enter an email")));
                                }
                                // Navigator.of(context).pushNamed("/OTP");
                              },
                            )),
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
