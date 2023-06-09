import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stefomobileapp/Models/challan.dart';
import 'package:stefomobileapp/pages/HomePage.dart';
//import '../Models/gen_item_list.dart';
import '../Models/order.dart';
import '../ui/common.dart';

// void main(){
//   runApp(MaterialApp(
//     home: GeneratedChallan(),
//   ));
//
// }

class GeneratedChallan extends StatelessWidget {
  final String challan_id;
  const GeneratedChallan({super.key, required this.challan_id});

  @override
  Widget build(BuildContext context) {
    print(challan_id);
    return ChallanPage(challan_id: challan_id);
  }
}

class ChallanPage extends StatefulWidget {
  final String challan_id;

  const ChallanPage({super.key, required this.challan_id});

  @override
  State<ChallanPage> createState() => _ChallanPageState();
}

class _ChallanPageState extends State<ChallanPage> {
  int flag = 0;
  Order or = Order();
  Challan ch = Challan();
  bool isDataAvailable = false;

  var responseData, listOfColumns;
  loadChallanData() async {
    if (flag == 0) {
      final res = await http.post(
        Uri.parse("http://urbanwebmobile.in/steffo/getchallandetails.php"),
        body: {
          "challan_id": widget.challan_id.toString(),
        },
      );

      responseData = jsonDecode(res.body);
      print(responseData);
      ch.transporter_name = responseData["data"][0]["transporter_name"];
      ch.lr_number = responseData["data"][0]["lr_number"];
      ch.vehicle_number = responseData["data"][0]["vehicle_number"];
      ch.challan_id = responseData["data"][0]["challan_id"];
      or.party_address = responseData["data"][0]["shippingAddress"];
      or.party_mob_num = responseData["data"][0]["partyMobileNumber"];
      or.loading_type = responseData["data"][0]["loadingType"];
      or.order_date = responseData["data"][0]["updatedAt"];

      final resp = await http.post(
        Uri.parse("http://urbanwebmobile.in/steffo/getchallanitemdetails.php"),
        body: {
          "challan_id": widget.challan_id.toString(),
        },
      );

      var itemlist = jsonDecode(resp.body);

      listOfColumns = [];
      for (int i = 0; i < itemlist["data"].length; i++) {
        listOfColumns.add({
          "Sr_no": (i + 1).toString(),
          "Name": itemlist["data"][i]["name"],
          "Qty": itemlist["data"][i]["qty"],
        });
      }
      isDataAvailable = true;
      flag = 1;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadChallanData();
    return Scaffold(
        appBar: appbar("Challan", () {
          Navigator.pop(context);
        }),
        body: LayoutBuilder(builder: (context, constraints) {
          if (isDataAvailable) {
            return ChallanBody();
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }
        }));
  }

  Widget ChallanBody() {
    return Container(
      decoration: const BoxDecoration(
          //     gradient:
          //         LinearGradient(transform: GradientRotation(1.57), colors: [
          //   Color.fromRGBO(75, 100, 160, 1.0),
          //   Color.fromRGBO(19, 59, 78, 1.0),
          // ]
          //         )
          ),
      child: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width - 20,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                      child: Image.asset("assets/images/stefo_logo.png")),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.centerRight,
                    //          alignment: Alignment.centerLeft,
                    child: Column(
                      //            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            'Survey NO 311, Tajpur Road Vill- Bhat, Changodar, Ahmedabad, Gujarat- 382210',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                            maxLines: 3,
                            softWrap: true),
                        RichText(
                            text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Contact No: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            TextSpan(
                              text: "9879365399/9558622200",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            )
                          ],
                        )),
                        RichText(
                            text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Gst Number: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            TextSpan(
                              text: "24ADTFS5560M1ZB",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            )
                          ],
                        )),
                        RichText(
                            text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Pan Number: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            TextSpan(
                              text: "ADTFS5560M",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            )
                          ],
                        )),
                        // Text("Contact No: 9879365399/9558622200",
                        //     style: TextStyle(fontSize: 10),
                        //     textAlign: TextAlign.left),
                        // Text("Gst Number: 24ADTFS5560M1ZB",
                        //                     //     style: TextStyle(fontSize: 10)),
                        //                     // Text("Pan Number:ADTFS5560M",
                        //                     //     style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Card(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.withOpacity(0.20),
                    ),
                    child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Card(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                color: Colors.white.withOpacity(0.50),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping Address",
                                    style: TextStyle(
                                      fontFamily: "Poppins_Bold",
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    or.party_address!,
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: "Poppins"),
                                    // textAlign: TextAlign.right,
                                    maxLines: 4,
                                    softWrap: true,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Shipping Address :",
                                  //       style: TextStyle(
                                  //         fontSize: 10,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       // padding: EdgeInsets.only(bottom: 25, top: 10),
                                  //       child: Text(or.party_address!,
                                  //         style: TextStyle(fontSize: 10,),
                                  //         textAlign: TextAlign.right,
                                  //         maxLines: 4,
                                  //         softWrap: true,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),

                                  const Text("Contact",
                                      style: TextStyle(
                                        fontFamily: "Poppins_Bold",
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      )),
                                  Text(or.party_mob_num!,
                                      style: const TextStyle(
                                          fontSize: 15, fontFamily: "Poppins")),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.85),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Loading Type:",
                                        style: TextStyle(
                                          fontFamily: "Poppins_Bold",
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold
                                        )),
                                    Text(or.loading_type!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins"))
                                  ],
                                )),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.85),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Challan no:",
                                        style: TextStyle(
                                          fontFamily: "Poppins_Bold",
                                          fontSize: 15,
                                          // fontWeight: FontWeight.bold
                                        )),
                                    Text(ch.challan_id!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins"))
                                  ],
                                )),
                          ),
                        ])),
              ),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.20),
                  ),
                  child: Column(children: [
                    Card(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transporter name:",
                                  style: TextStyle(
                                    fontFamily: "Poppins_Bold",
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold
                                  )),
                              Text(ch.transporter_name!,
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: "Poppins"))
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Column(children: [
                      Card(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("LR no:",
                                    style: TextStyle(
                                      fontFamily: "Poppins_Bold",
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    )),
                                Text(ch.lr_number!,
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: "Poppins"))
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Vehicle no",
                                    style: TextStyle(
                                      fontFamily: "Poppins_Bold",
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    )),
                                Text(ch.vehicle_number!,
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: "Poppins"))
                              ],
                            )),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Date :",
                                    style: TextStyle(
                                      fontFamily: "Poppins_Bold",
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold
                                    )),
                                Text(
                                  or.order_date!,
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: "Poppins"),
                                )
                              ],
                            )),
                      ),
                    ])
                  ]),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.withOpacity(0.20),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Items:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 20,
                          // padding: EdgeInsets.only(
                          //     top: 10, bottom: 10, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(20.0)
                          ),
                          // alignment: Alignment.center,
                          // padding: const EdgeInsets.only(top: 20),
                          // child: SingleChildScrollView(
                          //   padding: EdgeInsets.only(
                          //       top: 10, bottom: 10, left: 10, right: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Center(
                              child: DataTable(
                                columnSpacing: 60,
                                horizontalMargin: 2,
                                headingTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                columns: const [
                                  DataColumn(label: Text("Sr\nNo")),
                                  DataColumn(label: Text("Item name")),
                                  DataColumn(label: Text("Quantity\n(Tons)"))
                                ],
                                rows: listOfColumns
                                    .map<DataRow>(
                                      ((element) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(element[
                                                  "Sr_no"]!)), //Extracting from Map element the value
                                              DataCell(Text(element["Name"]!)),
                                              DataCell(Text(element["Qty"]!)),
                                            ],
                                          )),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(HomePage());
                        //   },
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       'Back To Homepage',
                        //       style:
                        //           TextStyle(fontSize: 25, color: Colors.white),
                        //       textAlign: TextAlign.center,
                        //     ),
                        //     decoration: BoxDecoration(
                        //         color: Colors.blueGrey,
                        //         borderRadius: BorderRadius.circular(10)),
                        //     height: 40,
                        //     width: double.infinity,
                        //   ),
                        // )
                      ],
                    )),
              )
            ])),
      ),
    );
  }
}
