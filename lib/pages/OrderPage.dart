import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:stefomobileapp/pages/ChallanListPage.dart';
import 'package:stefomobileapp/pages/OrdersPage.dart';

import '../Models/order.dart';
import '../ui/common.dart';

// ignore: must_be_immutable
class OrderDetails extends StatelessWidget {
  Order order;
  OrderDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return OrderPage(order: order);
  }
}

class OrderPage extends StatefulWidget {
  OrderPage({Key? key, this.order}) : super(key: key);
  final Order? order;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int flag = 0;
  var listOfColumns = [];
  var id;
  num tot_price = 0;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    print(widget.order!.orderType);
    print(widget.order!.loading_type);
    if (flag == 0) {
      if (widget.order!.orderType != "Lump-sum") {
        final res = await http.post(
          Uri.parse("http://urbanwebmobile.in/steffo/getorderdetails.php"),
          body: {
            "order_id": widget.order!.order_id,
          },
        );
        var responseData = jsonDecode(res.body);
        //print(responseData);
        listOfColumns = [];

        for (int i = 0; i < responseData["data"].length; i++) {
          listOfColumns.add({
            "Sr_no": (i + 1).toString(),
            "Name": responseData["data"][i]["name"],
            "Qty": responseData["data"][i]["qty"],
            "Price": responseData["data"][i]["price"]
          });
          tot_price = tot_price + int.parse(responseData["data"][i]["price"]);
        }
      } else {
        final res = await http.post(
          Uri.parse("http://urbanwebmobile.in/steffo/getlumpsumorder.php"),
          body: {
            "order_id": widget.order!.order_id,
          },
        );
        var responseData = jsonDecode(res.body);
        //print(responseData);
        listOfColumns = [];
        for (int i = 0; i < responseData["data"].length; i++) {
          listOfColumns.add({
            "Sr_no": (i + 1).toString(),
            "Name": responseData["data"][i]["name"],
            "Qty": responseData["data"][i]["qty"],
            "Price": responseData["data"][i]["price"]
          });
          tot_price = tot_price + int.parse(responseData["data"][i]["price"]);
        }

        listOfColumns.add({
          "Sr_no": " ",
          "Name": " ",
          "Qty": "Total:",
          "Price": tot_price.toString()
        });
      }
      print(tot_price);
      flag = 1;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    //List<GeneratedItems> items;

    @override
    void initState() {
      // items = GeneratedItems.getItems();
      // print(widget.order.orderType);
      super.initState();
    }

    //status.text = widget.order.status!;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar("Order", () {
          Navigator.pop(context);
        }),
        body: Container(
          // decoration: const BoxDecoration(),
          child: Center(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 10,
                      child: Column(children: [
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.lightBlueAccent,
                          ),
                          child: Text(widget.order!.user_name!.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins_bold",
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: const [
                                    Text("Shipping Address",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins_Bold")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(widget.order!.party_address!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins",
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: const [
                                    Text("Contact",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins_Bold")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(widget.order!.party_mob_num!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Poppins"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          elevation: 2,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Loading Type:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Poppins_Bold")),
                                  Text(widget.order!.loading_type.toString(),
                                      style: const TextStyle(
                                          fontSize: 15, fontFamily: "Poppins"))
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          elevation: 2,
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Base Price:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Poppins_Bold")),
                                  Text(widget.order!.base_price!,
                                      style: const TextStyle(
                                          fontSize: 15, fontFamily: "Poppins"))
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          elevation: 2,
                          shadowColor: Colors.grey,
                          child: Container(
                              // margin: EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Status: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Poppins_Bold")),
                                  Text(widget.order!.status!,
                                      style: const TextStyle(
                                          fontSize: 15, fontFamily: "Poppins"))
                                ],
                              )),
                        ),
                      ])),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Card(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      elevation: 2,
                      child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width - 20,
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                              // color: Colors.grey.withOpacity(0.20),
                              // borderRadius: BorderRadius.circular(20.0)
                              ),
                          // alignment: Alignment.center,
                          // padding: const EdgeInsets.only(top: 20),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: DataTable(
                              horizontalMargin: 2,
                              headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              columnSpacing: 10,
                              columns: const [
                                DataColumn(label: Text("Sr\nNo")),
                                DataColumn(label: Text("Item name")),
                                DataColumn(label: Text("Quantity\n(Tons)")),
                                DataColumn(label: Text("Price"))
                              ],
                              rows:
                                  listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                                      .map(
                                        ((element) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(Text(element[
                                                    "Sr_no"]!)), //Extracting from Map element the value
                                                DataCell(
                                                    Text(element["Name"]!)),
                                                DataCell(Text(element["Qty"]!)),
                                                DataCell(
                                                    Text(element["Price"]!)),
                                              ],
                                            )),
                                      )
                                      .toList(),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    if (widget.order!.status == "Pending" &&
                        id == widget.order!.reciever_id) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 40,
                                child: TextButton(
                                    onPressed: () async {
                                      await http.post(
                                        Uri.parse(
                                            "http://urbanwebmobile.in/steffo/approveorder.php"),
                                        body: {
                                          "decision": "Approved",
                                          "order_id": widget.order!.order_id!
                                        },
                                      );
                                      widget.order!.status = "Confirmed";
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    child: GradientText(
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      colors: [Colors.greenAccent, Colors.grey],
                                      "Accept",
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 40,
                                child: TextButton(
                                  onPressed: () async {
                                    await http.post(
                                      Uri.parse(
                                          "http://urbanwebmobile.in/steffo/approveorder.php"),
                                      body: {
                                        "decision": "Denied",
                                        "order_id": widget.order!.order_id!
                                      },
                                    );
                                    widget.order!.status = "Denied";
                                    setState(() {});
                                  },
                                  child: GradientText(
                                    "Decline",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    colors: [Colors.redAccent, Colors.grey],
                                  ),
                                )),
                          ],
                        ),
                      );
                    } else {
                      if (widget.order!.status == "Confirmed") {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: buttonStyle("View Challan", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChallanListPage(
                                          order: widget.order!,
                                        )));
                          }),
                        );
                      } else {
                        return (Container());
                      }
                    }
                  })
                ])),
          ),
        ));
  }
}
