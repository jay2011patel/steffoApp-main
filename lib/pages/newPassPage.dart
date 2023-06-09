import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stefomobileapp/ui/common.dart';

class NewPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewPasscontent();
  }
}

class NewPasscontent extends StatefulWidget {
  NewPasscontent({super.key});
  final selected = 0;
  @override
  State<NewPasscontent> createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPasscontent> {
  final _formKey = GlobalKey<FormState>();
  bool _isPWVisible = false;
  bool _isPWVisible1 = false;

  late FocusNode focusNode1;
  late FocusNode focusNode2;

  final field1Key = GlobalKey<FormFieldState>();
  final field2Key = GlobalKey<FormFieldState>();

  String? selectedValue;
  TextEditingController password = TextEditingController();
  TextEditingController regpassword = TextEditingController();

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

  onClick(String password, String confirmPass) async {
    var test = await http.post(
      Uri.parse('http://urbanwebmobile.in/steffo/updatepassword.php'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        "regpassword": regpassword.text,
        // "lastName": last_name.text,
        // "email": email.text,
        // "password": password.text,
        // "mobileNumber": mob_num.text,
        // "userType": selectedValue!,
      },
    );

    Navigator.of(context).pushNamed("/login");
  }

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
            "Create New Password",
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
        // padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        // color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(right: 20)),
            SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20, top: 60, left: 30)),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/images/newPassword1.png"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 20)),
                          TextFormField(
                            key: field1Key,
                            focusNode: focusNode1,
                            // controller: password,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: _isPWVisible,
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
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
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password.';
                              }
                              if (value.length < 6) {
                                return 'Minimum length should be 6';
                              }
                              return null;
                            },
                            // validator: EmailValidator(errorText: "Not Valid"),
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            key: field2Key,
                            focusNode: focusNode2,
                            controller: regpassword,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: _isPWVisible1,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPWVisible1 = !_isPWVisible1;
                                  });
                                },
                                icon: Icon(_isPWVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a password.';
                              }
                              if (value.length < 6) {
                                return 'Minimum length should be 6';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: buttonStyle(("Save"), () {
                              if (_formKey.currentState!.validate()) {
                                {
                                  onClick(password.text, regpassword.text);
                                }
                                // onClick();
                              }
                            }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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
