import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stefomobileapp/UI/common.dart';
import 'package:http/http.dart' as http;
import '../Models/user.dart';

class UserRequestPage extends StatelessWidget {
  final User user;
  UserRequestPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadDistributors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar("Requests", () {
        print("Back Pressed");
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 20)),
          Card(
            shadowColor: Colors.grey,
            elevation: 5,
            child: Container(
              // height: 100,
              width: 700,
              // alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
              // color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.userType!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins_Bold",
                        fontSize: 17,
                        color: Colors.green,
                      )),
                  SizedBox(height: 10),
                  Text(user.orgName!,
                      style: TextStyle(
                        fontFamily: "Poppins_Bold",
                        fontSize: 20,
                        color: Color.fromRGBO(19, 59, 78, 1),
                      )),
                  SizedBox(height: 10),
                  Text(user.address!,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        color: Colors.grey,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            // width: 500,
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(padding: EdgeInsets.only(top: 10,bottom: 10)),
                    Text("Person Name:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                    SizedBox(height: 20),
                    Text("Contact No.:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                    SizedBox(height: 20),
                    Text("Email:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                    SizedBox(height: 20),
                    Text("PAN Number:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                    SizedBox(height: 20),
                    Text("Aadhar No.:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                    SizedBox(height: 20),
                    Text("GST Number:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                    SizedBox(height: 20),
                    Text("Registered date:",
                        style: TextStyle(
                            fontFamily: "Poppins_Bold",
                            fontSize: 15,
                            color: Color.fromRGBO(19, 59, 78, 1))),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(padding: EdgeInsets.only(top: 10,bottom: 10)),
                    Text(user.firstName! + user.lastName!,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                    SizedBox(height: 20),
                    Text(user.mobileNumber!,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                    SizedBox(height: 20),
                    // Text("98765432",style: TextStyle(fontFamily: "Poppins", fontSize: 15, color: Colors.grey)
                    // ),
                    // SizedBox(height:20),
                    Text(user.email!,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                    SizedBox(height: 20),
                    Text(user.gstNumber!,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                    SizedBox(height: 20),
                    Text(user.panNumber!,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                    SizedBox(height: 20),
                    Text(user.adhNumber!,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                    SizedBox(height: 20),
                    Text("21/03/2023",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                child: Text("Approve"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(102, 178, 83, 1.0)),
                onPressed: () async {
                  var f = 0;
                  if (user.userType == "Dealer") {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: DistributorDialog(context),
                          );
                          // final res = await http.post(
                          //   Uri.parse(
                          //       "http://urbanwebmobile.in/steffo/approveuser.php"),
                          //   body: {"decision": "Approve", "id": user.id},
                          // );
                        });
                  } else {
                    final res = await http.post(
                      Uri.parse(
                          "http://urbanwebmobile.in/steffo/setdealerparent.php"),
                      body: {"id": user.id, "parentId": "0"},
                    );
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  }
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 113, 91)),
                onPressed: () async {
                  final res = await http.post(
                    Uri.parse(
                        "http://urbanwebmobile.in/steffo/approveuser.php"),
                    body: {"decision": "Reject", "id": user.id},
                  );
                  Navigator.of(context).popUntil((route) {
                    if (route.isFirst) {
                      return false;
                    } else {
                      return true;
                    }
                  });
                },
                child: Text("Reject")),
          )
        ],
      ),
    );
  }

  var f = 0;
  List<User> distributors = [];
  loadDistributors() async {
    if (f == 0) {
      final res = await http.post(
          Uri.parse("http://urbanwebmobile.in/steffo/getdistributors.php"));
      var responseData = jsonDecode(res.body);
      for (int i = 0; i < responseData["data"].length; i++) {
        User u = User();
        u.id = responseData['data'][i]['id'];
        u.firstName = responseData['data'][i]['firstName'];
        u.lastName = responseData['data'][i]['lastName'];
        u.email = responseData['data'][i]['email'];
        u.mobileNumber = responseData['data'][i]['mobileNumber'];
        u.parentId = responseData['data'][i]['parentId'];
        u.userType = responseData['data'][i]['userType'];
        u.userStatus = responseData['data'][i]['userStatus'];
        u.orgName = responseData['data'][i]['orgName'];
        u.gstNumber = responseData['data'][i]['gstNumber'];
        u.panNumber = responseData['data'][i]['panNumber'];
        u.adhNumber = responseData['data'][i]['adhNumber'];
        u.address = responseData['data'][i]['address'];
        distributors.add(u);
      }
      f = 1;
    }
  }

  Widget DistributorDialog(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Container(
            child: Text(
              "Dealer Address",
              style: TextStyle(fontFamily: "Poppins_Bold"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              user.address!,
              style: TextStyle(fontFamily: "Poppins"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Select Distributor",
              style: TextStyle(fontFamily: "Poppins_Bold"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                child: ListView.builder(
                  itemCount: distributors.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          var f = 0;
                          {
                            if (f == 0) {
                              final res = await http.post(
                                Uri.parse(
                                    "http://urbanwebmobile.in/steffo/setdealerparent.php"),
                                body: {
                                  "id": user.id,
                                  "parentId": distributors[index].id
                                },
                              );
                            }
                            f = 1;
                          }

                          if (f == 1) {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/home'));
                          }
                        },
                        child: Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          elevation: 4,
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  distributors[index].orgName!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 15),
                                ),
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blueAccent,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(distributors[index].address!,
                                      style: TextStyle(fontSize: 15))),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
