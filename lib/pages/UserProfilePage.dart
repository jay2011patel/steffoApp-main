// import 'dart:html';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/validator/validations.dart';
import '../UI/common.dart';

// import 'package:editable_image/editable_image.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar("Create Profile", () {
          print("Back Pressed");
          Navigator.pop(context);
        }),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(child: ProfileForm()),
        ));
    //  throw UnimplementedError();
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  late FocusNode focusNode6;
  late FocusNode focusNode7;
  late FocusNode focusNode8;
  late FocusNode focusNode9;
  late FocusNode focusNode10;
  final field1Key = GlobalKey<FormFieldState>();
  final field2Key = GlobalKey<FormFieldState>();
  final field3Key = GlobalKey<FormFieldState>();
  final field4Key = GlobalKey<FormFieldState>();
  final field5Key = GlobalKey<FormFieldState>();
  final field6Key = GlobalKey<FormFieldState>();
  final field7Key = GlobalKey<FormFieldState>();
  final field8Key = GlobalKey<FormFieldState>();
  final field9Key = GlobalKey<FormFieldState>();
  final field10Key = GlobalKey<FormFieldState>();

  late File file;

  String? selectedValue;
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mob_num = TextEditingController();
  TextEditingController user_type = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _isPWVisible = true;

  String? userType, firstName, lastName;
  loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = await prefs.getString('userType');
    firstName = await prefs.getString('firstName');
    lastName = await prefs.getString('lastName');
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
    focusNode7 = FocusNode();
    focusNode8 = FocusNode();
    focusNode9 = FocusNode();
    focusNode10 = FocusNode();
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
    focusNode6.addListener(() {
      if (!focusNode6.hasFocus) {
        field6Key.currentState?.validate();
      }
    });
    focusNode7.addListener(() {
      if (!focusNode7.hasFocus) {
        field7Key.currentState?.validate();
      }
    });
    focusNode8.addListener(() {
      if (!focusNode8.hasFocus) {
        field8Key.currentState?.validate();
      }
    });
    focusNode9.addListener(() {
      if (!focusNode9.hasFocus) {
        field9Key.currentState?.validate();
      }
    });
    focusNode10.addListener(() {
      if (!focusNode10.hasFocus) {
        field10Key.currentState?.validate();
      }
    });
  }

  // void _directUpdateImage(File? file) async {
  //   if (file == null) return;
  //
  //   setState(() {
  //     _profilePicFile = file;
  //   });
  // }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    super.dispose();
  }

  onRegister() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    print(selectedValue);
    var test = await http.post(
      Uri.parse('http://urbanwebmobile.in/steffo/updateuser.php'),
      body: {
        "id": id,
        "orgName": orgName.text,
        "gstNumber": gstNumber.text,
        "panNumber": panNumber.text,
        "adhNumber": adhNumber.text,
        "address": address.text,
      },
    );
    validateLoginDetails(AutofillHints.email, AutofillHints.password);
    Navigator.of(context).pushNamed("/login");
  }

  TextEditingController orgName = TextEditingController();
  TextEditingController gstNumber = TextEditingController();
  TextEditingController panNumber = TextEditingController();
  TextEditingController adhNumber = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // logo(context),

      //-----------------------FormDetails--------------------------

      SingleChildScrollView(
          child: Container(
        child: FormDetails(),
      )),

      //----------------------------Submit--------------------------------

      Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          width: MediaQuery.of(context).size.width,
          child: buttonStyle("Submit", () {
            if (_formKey.currentState!.validate()) {
              onRegister();
            }
          })),
    ]));
  }

  Widget FormDetails() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
//             Column(
//               children: [
//                 Padding(padding: EdgeInsets.all(10.0)),
//                 Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                           width: 4,
//                           color: Theme.of(context).scaffoldBackgroundColor),
//                       boxShadow: [
//                         BoxShadow(
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             color: Colors.black.withOpacity(0.1),
//                             offset: const Offset(0, 10))
//                       ],
//                       shape: BoxShape.circle,
//                       image: const DecorationImage(
//                           fit: BoxFit.cover,
//
//                           image: AssetImage("assets/images/stefo_logo.png")
//                       )
//                   ),
//                 ),
// //                 EditableImage(
// // // Define the method that will run on the change process of the image.
// //                   onChange: (file) => _directUpdateImage(file),
// //
// // // Define the source of the image.
// //                   image: _profilePicFile != null
// //                       ? Image.file(_profilePicFile!, fit: BoxFit.cover)
// //                       : null,
// //
// // // Define the size of EditableImage.
// //                   size: 150.0,
// //
// // // Define the Theme of image picker.
// //                   imagePickerTheme: ThemeData(
// //                     // Define the default brightness and colors.
// //                     primaryColor: Colors.white,
// //                     shadowColor: Colors.transparent,
// //                     backgroundColor: Colors.white70,
// //                     iconTheme: const IconThemeData(color: Colors.black87),
// //
// //                     // Define the default font family.
// //                     fontFamily: 'Georgia',
// //                   ),
// //
// // // Define the border of the image if needed.
// //                   imageBorder: Border.all(color: Colors.black87, width: 2.0),
// //
// // // Define the border of the icon if needed.
// //                   editIconBorder: Border.all(color: Colors.black87, width: 2.0),
// //                 ),
//
//                 Column(
//                   children: [
//                     Padding(padding: EdgeInsets.only(top: 20,left: 150),),
//                     Container(
//                       padding: EdgeInsets.only(bottom: 10),
//                       child: Text(
//                         "User Name", style: TextStyle(fontSize: 20,fontFamily: "Poppins_Bold"),
//
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ],
//             ),

            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userType!,
                          style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1),
                          )),
                      Text(
                        firstName! + " " + lastName!,
                        style: TextStyle(
                          fontFamily: "Poppins_Bold",
                          fontSize: 25,
                          color: Color.fromRGBO(19, 59, 78, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.1,
                  // width: 160,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: [
                      TextFormField(
                        key: field1Key,
                        focusNode: focusNode1,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a Mobile Number.';
                          }
                          if (value.length != 10) {
                            return 'Number should contain 10 digits';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          counterText: "",
                          // prefixIcon: Icon(Icons.location_on),
                          labelText: "Contact Number",
                          filled: true,
                          fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.1,
                  // width: 160,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: [
                      TextFormField(
                        key: field2Key,
                        focusNode: focusNode2,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a Date';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          counterText: "",
                          // prefixIcon: Icon(Icons.location_on),
                          labelText: "Registered at",
                          filled: true,
                          fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                controller: orgName,
                key: field3Key,
                focusNode: focusNode3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Organization Name';
                  }
                  return null;
                },
                // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  counterText: "",
                  // prefixIcon: Icon(Icons.location_on),
                  labelText: "Organization Name",
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                key: field7Key,
                focusNode: focusNode7,
                controller: gstNumber,
                maxLength: 15,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a GST Number.';
                  } else if (value.length < 15) {
                    return 'Please Enter Valid Number';
                  }
                  if (value.length > 15) {
                    return 'Please Enter Valid Number';
                  }
                  return null;
                },
                // controller: mob_num,
                // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  // counterText: ""
                  // prefixIcon: Icon(Icons.location_on),
                  labelText: "GST Number",
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            //----------------------------PAN Number------------------------------

            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                key: field8Key,
                focusNode: focusNode8,
                maxLength: 10,
                controller: panNumber,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a PAN Number.';
                  } else if (value.length < 10) {
                    return 'Please Enter Valid Number';
                  }
                  if (value.length > 10) {
                    return 'Please Enter Valid Number';
                  }
                  return null;
                },
                // controller: mob_num,
                // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  // counterText: "",
                  // prefixIcon: Icon(Icons.location_on),
                  labelText: "PAN Number",
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

//----------------------------Aadhaar Number------------------------------

            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                key: field9Key,
                controller: adhNumber,
                focusNode: focusNode9,
                maxLength: 12,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Aadhar Number.';
                  } else if (value.length < 12) {
                    return 'Please Enter Valid Number';
                  }
                  if (value.length > 12) {
                    return 'Please Enter Valid Number';
                  }
                  return null;
                },
                // controller: mob_num,
                // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  // counterText: "",
                  // prefixIcon: Icon(Icons.location_on),
                  labelText: "Aadhar Number",
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            //----------------------------Address------------------------------

            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextFormField(
                style: TextStyle(fontFamily: "Poppins"),
                key: field6Key,
                controller: address,
                focusNode: focusNode6,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Address.';
                  }
                  return null;
                },
                minLines: 1,
                maxLines: 4,
                // controller: mob_num,
                // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  counterText: "",
                  // prefixIcon: Icon(Icons.location_on),
                  labelText: "Address",
                  filled: true,
                  fillColor: Color.fromRGBO(233, 236, 239, 1.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    print(result.files.single.path);
                    file = File(result.files.single.path!);
                  } else {
                    // User canceled the picker
                  }
                },
                child: Text("Upload"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
