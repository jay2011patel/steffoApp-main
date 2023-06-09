import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/ui/common.dart';

import '../Models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const LoginContent();
    throw UnimplementedError();
  }
}

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _loginPageState();
}

class _loginPageState extends State<LoginContent> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  final field1Key = GlobalKey<FormFieldState>();
  final field2Key = GlobalKey<FormFieldState>();

  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  bool userValid = true;
  bool _isPWVisible = true;

  @override
  void initState() {
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();

    focusNode1.addListener(() {
      if (!focusNode1.hasFocus) {
        field1Key.currentState?.validate();
      }
    });
    focusNode2.addListener(() {
      if (!focusNode2.hasFocus) {
        field2Key.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }

  bool rememberMe = true;
  onLogin(String email, String pw) async {
    var test = await http.post(
      Uri.parse('http://urbanwebmobile.in/steffo/login.php'),
      body: {
        "email": email,
        "password": pw,
      },
    );
    //Navigator.of(context).pushNamed("/home");

    var responseData = json.decode(test.body);

    print(responseData);
    if (responseData["status"] == "200") {
      userValid = true;
      print(responseData);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', responseData["id"]);
      prefs.setString('firstName', responseData["firstName"]);
      prefs.setString('lastName', responseData["lastName"]);
      prefs.setString('email', responseData["email"]);
      prefs.setString('mobileNumber', responseData["mobileNumber"]);
      prefs.setString('parentId', responseData["parentId"]);
      prefs.setString('userType', responseData["userType"]);
      prefs.setString('orgName', responseData["orgName"]);
      prefs.setString('gstNumber', responseData["gstNumber"]);
      prefs.setString('panNumber', responseData["panNumber"]);
      prefs.setString('adhNumber', responseData["adhNumber"]);
      prefs.setString('address', responseData["address"]);
      if (rememberMe) {
        prefs.setString('isLoggedIn', 'true');
      }
      if (responseData['userStatus'] == 'Approved') {
        Navigator.of(context).pushNamed("/home");
        Fluttertoast.showToast(
            msg: 'Logged In Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white);
      } else if (responseData['userStatus'] == 'Pending') {
        Navigator.of(context).pushNamed('/profile');
        Fluttertoast.showToast(
            msg: 'Logged In Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.white);
      } else if (responseData['userStatus'] == 'Registered') {
        Fluttertoast.showToast(
            msg: 'Your Request Is In Review',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: 'Your Request Has Been Rejected.\n Please Register Again',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
        Navigator.of(context).pushNamed('/profile');
      }
    } else {
      userValid = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: SingleChildScrollView(child: LoginForm()),
    ));
  }

  Widget LoginForm() {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                  painter: BluePainter(),
                  child:
                      //--------------------------StartOfChildren---------------------------

                      Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),

                    Container(
                      child:
                          // Image.asset("assets/images/userlogin1.png",height: 300,)
                          logo(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                    ),
                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: TextFormField(
                          key: field1Key,
                          focusNode: focusNode1,
                          validator: (value) {
                            if (value!.isEmpty || value == null) {
                              return 'Please enter an email.';
                            }
                            return null;
                          },
                          controller: email,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Email",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                            // hintText: "Email",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          )),
                    ),

                    //------------------------------Password-----------------------------

                    Container(
                      width: width,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: TextFormField(
                          key: field2Key,
                          focusNode: focusNode2,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password.';
                            }
                            // if (value.length < 8) {
                            //   return 'Incorrect Password';
                            // }
                            return null;
                          },
                          controller: pw,
                          textAlign: TextAlign.left,
                          obscureText: _isPWVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline_rounded),

                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPWVisible = !_isPWVisible;
                                });
                              },
                              icon: Icon(_isPWVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),

                            filled: true,

                            fillColor: const Color.fromRGBO(233, 236, 239, 1.0),
                            hintText:
                                "Password", //Text("Password",style: TextStyle(fontFamily: "Poppins"),),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none, //<-- SEE HERE
                              //borderRadius: BorderRadius.circular(20.0)
                            ),
                          )),
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      if (!userValid) {
                        return const Text(
                          "Incorrect Username or Password",
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        return const Text("");
                      }
                    }),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (bool? value) {
                            rememberMe = value!;
                            setState(() {});
                          },
                        ),
                        Text(
                          "Remember Me ?",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),

                    //------------------------------LoginButton-----------------------------

                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            child: buttonWhite(
                                "Login",
                                () => {
                                      if (_formKey.currentState!.validate())
                                        {onLogin(email.text, pw.text)}
                                    }))),

                    //-----------------------------Register Now-------------------------
                    Container(
                      //margin: EdgeInsets.fromLTRB(20, 0,20,0),

                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed("/forgetPass");
                                  },
                                  child: const Text(
                                    "Forgot Password ?",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                          Container(
                            child: const Text(
                              "|",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                  child: Text(
                                    "Register Now",
                                    style: TextStyle(color: Colors.white),
                                  )))
                        ],
                      ),
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.52);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.48, height * 0.46, width * 0.52, height * 0.53);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(
        width * 0.6, height * 0.59, width * 1, height * 0.5);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height * 1000);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Color.fromRGBO(13, 53, 69, 0.99);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
