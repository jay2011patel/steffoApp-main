import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/pages/HomePage.dart';

import '../Models/order.dart';
import '../ui/common.dart';
import '../ui/cards.dart';
import '../ui/custom_tabbar.dart';
import 'OrderPage.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrdersContent();
    //  throw UnimplementedError();
  }
}

class OrdersContent extends StatefulWidget {
  const OrdersContent({super.key});
  final selected = 0;
  @override
  State<OrdersContent> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar("Orders", () {
        Get.to(HomePage());
      }),
      body: OrdersPageBody(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //
      //     Navigator.of(context).popAndPushNamed('/challanlist');
      //
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: StylishBottomBar(
      //   option: AnimatedBarOptions(
      //     iconSize: 30,
      //     // barAnimation: BarAnimation.liquid,
      //     iconStyle: IconStyle.simple,
      //     opacity: 0.3,
      //   ),
      //   items: [
      //     BottomBarItem(
      //       icon: const Icon(
      //         Icons.home_filled,
      //       ),
      //       title: const Text('Abc'),
      //       backgroundColor: Colors.red,
      //       selectedIcon:
      //           const Icon(Icons.home_filled, color: Colors.blueAccent),
      //     ),
      //     BottomBarItem(
      //         icon: const Icon(
      //           Icons.inventory_2_rounded,
      //         ),
      //         title: const Text('Safety'),
      //         backgroundColor: Colors.orange,
      //         selectedIcon: const Icon(Icons.inventory_2_rounded,
      //             color: Colors.blueAccent)),
      //     BottomBarItem(
      //         icon: const Icon(
      //           Icons.warehouse_rounded,
      //         ),
      //         title: const Text('Safety'),
      //         backgroundColor: Colors.orange,
      //         selectedIcon: const Icon(Icons.warehouse_rounded,
      //             color: Colors.blueAccent)),
      //     BottomBarItem(
      //         icon: const Icon(
      //           Icons.person_pin,
      //         ),
      //         title: const Text('Cabin'),
      //         backgroundColor: Colors.purple,
      //         selectedIcon:
      //             const Icon(Icons.person_pin, color: Colors.blueAccent)),
      //   ],
      //   fabLocation: StylishBarFabLocation.center,
      //   hasNotch: false,
      //   currentIndex: _selected,
      //   onTap: (index) {
      //     setState(() {
      //       if (index == 0) {
      //         Navigator.of(context).popAndPushNamed('/home');
      //       }
      //
      //       if (index == 1) {
      //         Navigator.of(context).popAndPushNamed('/inventory');
      //       }
      //
      //       if (index == 2) {
      //         Navigator.of(context).popAndPushNamed('/dealer');
      //       }
      //     });
      //   },
      // )
    );
  }

  String? id = "";

  List<Order> salesOrderList = [];
  List<Order> purchaseOrderList = [];

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var m = id;
    id = await prefs.getString('id');
    print("sss" + "${id}");

    if (m != id) {
      final res = await http.post(
        Uri.parse("http://urbanwebmobile.in/steffo/vieworder.php"),
        body: {"id": id!},
      );
      var responseData = jsonDecode(res.body);
      //print(responseData);

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
        req.orderType = responseData["data"][i]["orderType"];
        req.order_id = responseData["data"][i]["order_id"].toString();
        //print(req);
        if (req.status != "Rejected") {
          if (id == req.user_id) {
            purchaseOrderList.add(req);
          }
          if (id == req.reciever_id) {
            salesOrderList.add(req);
          }
        }
      }
      print(salesOrderList);
      setState(() {});
    }
  }

  Widget OrdersPageBody() {
    loadData();
    return Container(
      // height: 700,
      // height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //     transform: GradientRotation(1.07),
          //     colors: [
          //       Color.fromRGBO(75, 100, 160, 1.0),
          //       Color.fromRGBO(19, 59, 78, 1.0),
          //     ]
          // )
          ),
      child: OrderList(),
      // child: SingleChildScrollView(
      //   child: Container(
      //     //margin: EdgeInsets.symmetric(horizontal: 5),
      //     padding: EdgeInsets.symmetric(vertical: 20),

      //     width: MediaQuery.of(context).size.width,
      //     child: CustomTabBar(
      //       titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      //       selectedCardColor: Color(0xFF14C38E),
      //       selectedTitleColor: Colors.white,
      //       unSelectedCardColor: Colors.white,
      //       unSelectedTitleColor: Color.fromRGBO(12, 53, 68, 1),
      //       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //       tabBarItemExtend: ((MediaQuery.of(context).size.width) / 2),
      //       tabBarItems: [
      //         "Sales",
      //       ],
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //       tabViewItems: [
      //         Container(child: OrderList()),
      //         // Container(child: PurchaseOrderList())
      //       ],
      //       tabViewItemHeight: MediaQuery.of(context).size.height * 0.7,
      //     ),
      //   ),
      // ),
    );
  }

  //----------------------------------OrderList---------------------------------//

  Widget OrderList() {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          // borderRadius: BorderRadius.circular(8)
        ),
        //  height: 50,
        //  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  itemCount: salesOrderList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetails(
                                      order: salesOrderList[index])));
                        },
                        child: orderCard(
                          context,
                          salesOrderList[index],
                          id,
                        ));
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }

//------------------------------PurchaseOrderList--------------------------------

//   Widget PurchaseOrderList() {
//     return Container(
//         decoration: const BoxDecoration(
//           color: Color.fromRGBO(255, 255, 255, 0.5),
//           // borderRadius: BorderRadius.circular(5)
//         ),
//         height: 50,
//         margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Container(
//                 child: ListView.builder(
//                   itemCount: purchaseOrderList.length,
//                   physics: const NeverScrollableScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => OrderDetails(
//                                       order: purchaseOrderList[index])));
//                         },
//                         child:
//                             orderCard(context, purchaseOrderList[index], id));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
}

//---------------------------------SingleOrderRequestWidget---------------------

//-------------------------------SingleRegistrationRequest----------------------

Widget RegistrationRequestCard(context, index) {
  String org_name = " Bhuyangdev Steel Corporation";
  var region = ['Ahmedabad', 'Mehsana', 'Anand'];

  return Container(
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("PlaceHolder"),
        Row(
          children: [
            Container(
                child: Text(
              "Entity Details",
              textAlign: TextAlign.left,
              style: TextStyle(fontFamily: "Poppins_Bold"),
            )),
            Container(
                width: MediaQuery.of(context).size.width - 200,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.thumb_up_alt_rounded,
                      color: Colors.green,
                    ))),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.thumb_down_alt_rounded,
                  color: Colors.red,
                ))
          ],
        ),
        Container(
          child: Row(
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
                org_name,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ))
            ],
          ),
        ),
        Container(
          child: Row(
            children: [Text("Region:"), Text(region[index])],
          ),
        ),
      ],
    ),
  );
}
