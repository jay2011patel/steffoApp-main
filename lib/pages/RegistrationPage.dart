import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stefomobileapp/ui/common.dart';
import 'package:stefomobileapp/validator/validations.dart';
// import '../UI/common.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: SingleChildScrollView(child: RegistrationForm()),
    ));
    throw UnimplementedError();
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode focusNode0;
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  final field0Key = GlobalKey<FormFieldState>();
  final field1Key = GlobalKey<FormFieldState>();
  final field2Key = GlobalKey<FormFieldState>();
  final field3Key = GlobalKey<FormFieldState>();
  final field4Key = GlobalKey<FormFieldState>();
  final field5Key = GlobalKey<FormFieldState>();

  String? selectedValue;
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mob_num = TextEditingController();
  TextEditingController user_type = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController companyname = TextEditingController();

  bool _isPWVisible = true;

  @override
  void initState() {
    super.initState();
    focusNode0 = FocusNode();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode0.addListener(() {
      if (!focusNode0.hasFocus) {
        field0Key.currentState?.validate();
      }
    });
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
    focusNode3.addListener(() {
      if (!focusNode3.hasFocus) {
        field3Key.currentState?.validate();
      }
    });
    focusNode4.addListener(() {
      if (!focusNode4.hasFocus) {
        field4Key.currentState?.validate();
      }
    });
    focusNode5.addListener(() {
      if (!focusNode5.hasFocus) {
        field5Key.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    focusNode0.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    super.dispose();
  }

  onRegister() async {
    print(selectedValue);
    var test = await http.post(
      Uri.parse('http://urbanwebmobile.in/steffo/register.php'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        "firstName": first_name.text,
        "lastName": last_name.text,
        "email": email.text,
        "password": password.text,
        "mobileNumber": mob_num.text,
        "userType": selectedValue!,
        "company": companyname.text,
      },
    );
    Fluttertoast.showToast(
        msg: 'Registered Successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
    validateLoginDetails(AutofillHints.email, AutofillHints.password);
    Navigator.of(context).pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: CustomPaint(
        painter: BluePainter(),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel))),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 30,
          // ),

          Container(
            child: logo(context),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 30,
          // ),

          //-----------------------FormDetails--------------------------

          Container(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
            child: Column(
              children: [
                FormDetails(),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    // padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: buttonWhite("Submit", () {
                      if (_formKey.currentState!.validate()) {
                        onRegister();
                      }
                    })),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget FormDetails() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    List items = ["Distributor", "Dealer", "Builder"];
    List<DropdownMenuItem<String>> getItems() {
      for (int i = 0; i < items.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: items[i],
          child: Text(items[i]),
        );
        dropdownItems.add(it);
      }

      return dropdownItems;
    }

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              //margin: EdgeInsets.fromLTRB(20, 20,20,0),

              width: width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: TextFormField(
                  key: field0Key,
                  focusNode: focusNode0,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your company name.';
                    }
                    return null;
                  },
                  controller: companyname,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                    labelText: "Company Name",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // label: const Text("Last Name",style: TextStyle(fontFamily: "Poppins"),),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      // borderRadius: BorderRadius.circular(20.0)
                    ),
                  )),
            ),

            //--------------------------First Name---------------------------------
            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: TextFormField(
                controller: first_name,
                textAlign: TextAlign.left,
                key: field1Key,
                focusNode: focusNode1,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return 'Please enter a First Name.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  labelText: "First Name",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  // label: Text("First Name",style: TextStyle(fontFamily: "Poppins"),),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    //borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
              ),
            ),

            //-----------------------LASTNAME-------------------------------

            Container(
              //margin: EdgeInsets.fromLTRB(20, 20,20,0),

              width: width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: TextFormField(
                  key: field2Key,
                  focusNode: focusNode2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Last Name.';
                    }
                    return null;
                  },
                  controller: last_name,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                    labelText: "Last Name",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // label: const Text("Last Name",style: TextStyle(fontFamily: "Poppins"),),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      // borderRadius: BorderRadius.circular(20.0)
                    ),
                  )),
            ),

            //-------------------------Email------------------------------------

            Container(
              //margin: EdgeInsets.fromLTRB(20, 20,20,0),
              width: width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: email,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  // label: Text("Email",style: TextStyle(fontFamily: "Poppins"),),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    // borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                validator: EmailValidator(errorText: "Not Valid"),
              ),
            ),
            //--------------------------------Password------------------------------

            Container(
              //margin: EdgeInsets.fromLTRB(20, 20,20,0),

              width: width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: TextFormField(
                  key: field3Key,
                  focusNode: focusNode3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Password.';
                    }
                    if (value.length < 8) {
                      return 'Minimum length for password is 8';
                    }
                    return null;
                  },
                  obscureText: _isPWVisible,
                  controller: password,
                  textAlign: TextAlign.left,
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

            //--------------------------------MobNum----------------------------

            Container(
              //margin: EdgeInsets.fromLTRB(20, 20,20,0),
              width: width,
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: TextFormField(
                key: field4Key,
                focusNode: focusNode4,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Mobile Number.';
                  }
                  if (value.length != 10) {
                    return 'Mobile number should contain 10 digits';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                maxLength: 10,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: mob_num,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  counterText: "",
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Mobile Number",
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  // label: Text("Mobile Number",style: TextStyle(fontFamily: "Poppins"),),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    // borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                // validator: MaxLengthValidator(10, errorText: "No more"),
                // validator: MultiValidator([
                //   MaxLengthValidator(10, errorText: "No More"),
                //   RequiredValidator(errorText: "Required"),
                //
                // ]),
              ),
            ),

            //----------------------------UserType------------------------------

            Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: DropdownButtonFormField(
                  key: field5Key,
                  focusNode: focusNode5,
                  decoration: const InputDecoration(
                      hintText: "User Type",
                      filled: true,
                      fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        // borderRadius: BorderRadius.circular(20)
                      )),
                  value: selectedValue,
                  items: getItems(),
                  onChanged: (String? newValue) {
                    selectedValue = newValue;
                  },
                  validator: (selectedValue) {
                    if (selectedValue == null) {
                      return 'Please select a value.';
                    }
                    return null;
                  },
                )),
          ],
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
    ovalPath.moveTo(0, height * 0.42);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.48, height * 0.36, width * 0.52, height * 0.43);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(
        width * 0.6, height * 0.49, width * 1, height * 0.4);

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
