import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:stefomobileapp/Models/user.dart';
import 'package:stefomobileapp/pages/UserRequestPage.dart';
import 'package:stefomobileapp/ui/custom_tabbar.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../Models/order.dart';
import '../ui/common.dart';
import 'OrderPage.dart';

class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RequestContent();
  }
}

class RequestContent extends StatefulWidget {
  const RequestContent({super.key});
  final selected = 0;
  @override
  State<RequestContent> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestContent> {
  @override
  void initState() {
    super.initState();
    loadData();
    getRegReqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar("Requests", () {
          Navigator.pop(context);
        }),
        extendBodyBehindAppBar: false,
        body: RequestPageBody(),
        bottomNavigationBar: StylishBottomBar(
          option: AnimatedBarOptions(
            iconSize: 30,
            //barAnimation: BarAnimation.liquid,
            iconStyle: IconStyle.simple,
            opacity: 0.3,
          ),

          items: [
            BottomBarItem(
              icon: const Icon(
                Icons.home_filled,
              ),
              title: const Text('Abc'),
              backgroundColor: Colors.red,
              selectedIcon: const Icon(Icons.home_filled, color: Colors.black),
            ),
            BottomBarItem(
                icon: const Icon(
                  Icons.inventory_2_rounded,
                ),
                title: const Text('Safety'),
                backgroundColor: Colors.orange,
                selectedIcon: const Icon(Icons.inventory_2_rounded,
                    color: Colors.blueAccent)),
            BottomBarItem(
                icon: const Icon(
                  Icons.warehouse_rounded,
                ),
                title: const Text('Safety'),
                backgroundColor: Colors.orange,
                selectedIcon: const Icon(Icons.warehouse_rounded,
                    color: Colors.blueAccent)),
            BottomBarItem(
                icon: const Icon(
                  Icons.person_pin,
                ),
                title: const Text('Cabin'),
                backgroundColor: Colors.purple,
                selectedIcon:
                    const Icon(Icons.person_pin, color: Colors.blueAccent)),
          ],
          //fabLocation: StylishBarFabLocation.center,
          hasNotch: false,
          onTap: (index) {
            setState(() {
              if (index == 0) {
                Navigator.of(context).popAndPushNamed('/home');
              }

              if (index == 1) {
                Navigator.of(context).popAndPushNamed('/inventory');
              }

              if (index == 2) {
                Navigator.of(context).popAndPushNamed('/dealer');
              }
            });
          },
        ));
  }

  //----------------------------------PageBody----------------------------------

  String? id = "";
  String? userType;

  List<Order> requestList = [];

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var m = id;
    id = await prefs.getString('id');
    userType = await prefs.getString('userType');

    if (m != id) {
      final res = await http.post(
        Uri.parse("http://urbanwebmobile.in/steffo/vieworder.php"),
        body: {"id": id!},
      );
      var responseData = jsonDecode(res.body);
      print(responseData);

      for (int i = 0; i < responseData["data"].length; i++) {
        Order req = Order();
        req.reciever_id = responseData["data"][i]["supplier_id"];
        req.user_id = responseData["data"][i]["user_id"];
        req.user_mob_num = responseData["data"][i]["mobileNumber"];
        req.user_name = responseData["data"][i]["firstName"] +
            " " +
            responseData["data"][i]["lastName"];
        req.status = responseData["data"][i]["orderStatus"];
        req.party_name = responseData["data"][i]["partyName"];
        req.party_address = responseData["data"][i]["shippingAddress"];
        req.billing_address = responseData["data"][i]["address"];
        req.party_mob_num = responseData["data"][i]["partyMobileNumber"];
        req.loading_type = responseData["data"][i]["loadingType"];
        req.order_date = responseData["data"][i]["createdAt"];
        req.base_price = responseData["data"][i]["basePrice"];
        req.order_id = responseData["data"][i]["order_id"].toString();
        if (req.status?.trim() == "Pending" && id == req.reciever_id) {
          print(req.loading_type);
          requestList.add(req);
        }
      }
      setState(() {});
    }
  }

  Widget RequestPageBody() {
    // loadData();
    return LayoutBuilder(builder: (context, constraints) {
      if (userType == "Manufacturer") {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   transform: GradientRotation(1.07),
              //   colors: [
              //     Color.fromRGBO(75, 100, 160, 1.0),
              //     Color.fromRGBO(19, 59, 78, 1.0),
              //   ]
              // )
              ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 20),

              width: MediaQuery.of(context).size.width,
              child: CustomTabBar(
                selectedCardColor: Color(0xFFFBC252),
                selectedTitleColor: Colors.white,
                unSelectedTitleColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                unSelectedCardColor: Colors.white,
                titleStyle:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                tabBarItemExtend: ((MediaQuery.of(context).size.width) / 2),
                tabBarItems: ["Order", "Registration"],
                tabViewItems: [
                  Container(child: OrderList()),
                  Container(child: RegistrationList())
                ],
                //  tabViewItemHeight: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
        );
      } else {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   transform: GradientRotation(1.07),
              //   colors: [
              //     Color.fromRGBO(75, 100, 160, 1.0),
              //     Color.fromRGBO(19, 59, 78, 1.0),
              //   ]
              // )
              ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 20),

              width: MediaQuery.of(context).size.width,
              child: CustomTabBar(
                selectedCardColor: Color.fromRGBO(12, 53, 68, 1),
                selectedTitleColor: Colors.white,
                unSelectedTitleColor: Colors.black,
                unSelectedCardColor: Colors.white,
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                tabBarItemExtend: ((MediaQuery.of(context).size.width)),
                tabBarItems: ["Order"],
                tabViewItems: [
                  Container(child: OrderList()),
                ],
                tabViewItemHeight: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
        );
      }
    });
  }

  //----------------------------------OrderList---------------------------------

  Widget OrderList() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          //
          Container(
            child: ListView.builder(
              itemCount: requestList.length,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetails(order: requestList[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: [
                        //   Color.fromARGB(255, 228, 245, 181),
                        //   Color.fromARGB(255, 242, 255, 64)
                        // ]),

                        borderRadius: BorderRadius.circular(10.0),
                        //  border: Border.all(color: Colors.black),
                        // border: Border.all(color: Colors.black),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            requestList[index].user_name!.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          Divider(color: Colors.orangeAccent),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Organization Name:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                                Text(
                                  requestList[index].party_name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Date:",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(requestList[index]
                                    .order_date!
                                    .substring(0, 10))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Base Price:",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                Text(requestList[index].base_price!)
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Container(
                              //     child: const Text(
                              //   "Order Details",
                              //   textAlign: TextAlign.left,
                              //   style: TextStyle(fontFamily: "Poppins_Bold"),
                              // )),
                              TextButton(
                                  onPressed: () async {
                                    await http.post(
                                      Uri.parse(
                                          "http://urbanwebmobile.in/steffo/approveorder.php"),
                                      body: {
                                        "decision": "Approved",
                                        "order_id": requestList[index].order_id!
                                      },
                                    );
                                    () {
                                      // orderList.add(requestList[index]);
                                      // requestList.removeAt(index);
                                      id = "none";

                                      setState(() {
                                        loadData();
                                      });
                                    }();
                                    // Get.to(RequestPage());
                                  },
                                  child: GradientText(
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    colors: [Colors.greenAccent, Colors.grey],
                                    "Accept",
                                  )),

                              TextButton(
                                  onPressed: () async {
                                    await http.post(
                                      Uri.parse(
                                          "http://urbanwebmobile.in/steffo/approveorder.php"),
                                      body: {
                                        "decision": "Denied",
                                        "order_id": requestList[index].order_id!
                                      },
                                    );
                                    () {
                                      // orderList.add(requestList[index]);
                                      // requestList.removeAt(index);
                                      id = "none";
                                      loadData();
                                      setState(() {});
                                      // Get.to(RequestPage());
                                    }();
                                  },
                                  child: GradientText(
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    colors: [Colors.redAccent, Colors.grey],
                                    "Decline",
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
          SizedBox(
            height: 110,
          )
        ],
      ),
    );
  }

//------------------------------RegistrationList--------------------------------
  List<User> regReqList = [];
  var flag = 0;
  getRegReqs() async {
    if (flag == 0) {
      print("enter");
      var test = await http.post(
        Uri.parse(
          'http://urbanwebmobile.in/steffo/getrequests.php',
        ),
      );
      //Navigator.of(context).pushNamed("/home");

      var responseData = jsonDecode(test.body);
      print("enter1");
      print(responseData);
      for (int i = 0; i < responseData['data'].length; i++) {
        print("enter2");
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
        regReqList.add(u);
        print("enter3");
      }
      setState(() {});
      flag = 1;
      print("registrationlist${regReqList}");
    }
  }

  Widget RegistrationList() {
    getRegReqs();
    return Card(
      child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.5),
              borderRadius: BorderRadius.circular(5)),
          height: 50,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // Center(
                //     child: Text(
                //   "Registration",
                //   style: TextStyle(fontFamily: "Poppins_Bold"),
                // )),
                Card(
                  child: Container(
                    child: ListView.builder(
                      itemCount: regReqList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserRequestPage(
                                      user: regReqList[index])));
                            },
                            child: Card(
                              elevation: 20,
                              child: RegistrationRequestCard(
                                  context, index, regReqList[index], () {
                                setState(() {});
                              }),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

//---------------------------------SingleOrderRequestWidget---------------------

Widget orderRequestCard(context, Order order, c()) {
  return Container(
    margin: EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      // gradient: LinearGradient(colors: [
      //   Color.fromARGB(255, 228, 245, 181),
      //   Color.fromARGB(255, 242, 255, 64)
      // ]),

      borderRadius: BorderRadius.circular(10.0),
      //  border: Border.all(color: Colors.black),
      // border: Border.all(color: Colors.black),
      color: Colors.grey.shade100,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          order.user_name!.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Divider(color: Colors.orangeAccent),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Organization Name:",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Text(
                order.party_name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Date:",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(order.order_date!.substring(0, 10))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Base Price:",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(order.base_price!)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //     child: const Text(
            //   "Order Details",
            //   textAlign: TextAlign.left,
            //   style: TextStyle(fontFamily: "Poppins_Bold"),
            // )),
            TextButton(
                onPressed: () async {
                  await http.post(
                    Uri.parse(
                        "http://urbanwebmobile.in/steffo/approveorder.php"),
                    body: {"decision": "Approved", "order_id": order.order_id!},
                  );
                  c();
                  Get.to(RequestPage());
                },
                child: GradientText(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  colors: [Colors.greenAccent, Colors.grey],
                  "Accept",
                )),

            TextButton(
                onPressed: () async {
                  await http.post(
                    Uri.parse(
                        "http://urbanwebmobile.in/steffo/approveorder.php"),
                    body: {"decision": "Denied", "order_id": order.order_id!},
                  );
                  c();
                },
                child: GradientText(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  colors: [Colors.redAccent, Colors.grey],
                  "Decline",
                ))
          ],
        ),
      ],
    ),
  );
}

//-------------------------------SingleRegistrationRequest----------------------

Widget RegistrationRequestCard(context, index, User user, c()) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Text(
              user.userType!,
              textAlign: TextAlign.left,
              style: TextStyle(fontFamily: "Poppins_Bold"),
            )),
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Org Name:",
                  style: TextStyle(fontFamily: "Roboto"),
                ),
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Expanded(
                  child: Text(
                user.orgName!,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.right,
              ))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Region:"),
              Expanded(
                  child: Text(
                user.address!,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.right,
              ))
            ],
          ),
        ),
      ],
    ),
  );
}
