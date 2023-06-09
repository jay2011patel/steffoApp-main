import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/Models/lumpsum.dart';
import 'package:stefomobileapp/pages/Buyers.dart';
import 'package:stefomobileapp/pages/DistBuyerspage.dart';
import 'package:stefomobileapp/pages/HomePage.dart';
import 'package:stefomobileapp/pages/ProfilePage.dart';
import 'package:stefomobileapp/ui/cards.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../Models/grade.dart';
import '../ui/common.dart';

class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InventoryContent();
  }
}

class InventoryContent extends StatefulWidget {
  InventoryContent({super.key});
  final selected = 0;
  @override
  State<InventoryContent> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryContent> {
  var _selected = 1;
  bool isDataLoaded = false;
  List<Lumpsum> lumpsums = [];
  List<Grade> gradeList = [];
  List<Grade>  gradeList1 = [];
  List<Grade> gradeList2 = [];
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user_id = await prefs.getString('id');

    var res1 = await http
        .post(Uri.parse("http://urbanwebmobile.in/steffo/getgrade.php"));
    var responseData1 = jsonDecode(res1.body);
    for (int i = 0; i < responseData1['data'].length; i++) {
      print(responseData1['data'][i]);
      Grade g = Grade();
      g.value = responseData1['data'][i]['gradeName'];
      g.qty = 0;
      gradeList.add(g);

      int middleIndex = (gradeList.length / 2).round();
      gradeList1.clear();
      gradeList2.clear();
      for (int i = 0; i < gradeList.length; i++) {
        if (i < middleIndex) {
          print("Add");
          gradeList1.add(gradeList[i]);
        } else {
          gradeList2.add(gradeList[i]);
        }
      }
    }

    var res = await http.post(
        Uri.parse("http://urbanwebmobile.in/steffo/getinventory.php"),
        body: {
          "user_id": user_id,
        });

    var responseData = jsonDecode(res.body);
    var orders = [];

    print(responseData);
    for (int i = 0; i < responseData["data"].length; i++) {
      print(responseData['data'][i]['name']);
      try {
        var ind = gradeList.indexWhere((element) =>
            element.value?.trim() == responseData['data'][i]['name'].trim());
        gradeList[ind].qty = gradeList[ind].qty! +
            int.parse(responseData['data'][i]['qty_left']);
      } catch (e) {
        print(e);
      }
      //print(gradeList[ind].value! + " " + gradeList[ind].qty.toString());
      Lumpsum l = Lumpsum();
      l.orderId = responseData["data"][i]["order_id"];
      l.name = responseData["data"][i]["name"];
      l.qty = responseData["data"][i]["qty_left"];
      l.price = responseData["data"][i]["price"];
      l.status = responseData["data"][i]["status"];
      l.date = responseData["data"][i]["createdAt"];
      lumpsums.add(l);
    }

    isDataLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selected == 0) {
          return true;
        }
        setState(() {
          _selected = 0;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomePage(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        });
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbar("Inventory", () {
            Get.to(HomePage());
          }),
          body: LayoutBuilder(builder: (context, constraints) {
            if (isDataLoaded) {
              return InventoryPageBody();
            } else {
              return Center(
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      CircularProgressIndicator(color: Colors.grey),
                      Text("Loading Inventory")
                ],
              ));
            }
          }),
          bottomNavigationBar: StylishBottomBar(
            option: AnimatedBarOptions(
              iconSize: 30,
              barAnimation: BarAnimation.fade,
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
                selectedIcon:
                    const Icon(Icons.home_filled, color: Colors.blueAccent),
              ),
              BottomBarItem(
                  icon: const Icon(
                    Icons.inventory_2_rounded,
                  ),
                  title: const Text('Safety'),
                  backgroundColor: Colors.orange,
                  selectedIcon:
                      const Icon(Icons.inventory, color: Colors.black)),
              BottomBarItem(
                  icon: const Icon(
                    Icons.warehouse_rounded,
                  ),
                  title: const Text('Safety'),
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
            currentIndex: _selected,
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }

                if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          buyerspage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }

                if (index == 3) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ProfilePage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                }
              });
            },
          )),
    );
  }

  Widget InventoryPageBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // color: Colors.white,
                // color : Color(0xffEB6440),
                // color : Color(0xff497174),
                color: Color.fromARGB(255, 216, 229, 248),
                boxShadow: []),
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width / 2.5,
                  child: Flexible(
                    child: ListView.builder(
                      itemCount: gradeList1.length,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, ind) {
                        return Container(
                            child: Column(
                              children: [
                                LumpSumTotal(context, gradeList1[ind]),
                          ],
                          )
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 110,
                  child: Row(
                    children: [
                      VerticalDivider(
                        color: Colors.grey,
                        thickness: 2.0,
                        width: 15,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: Container(
                    child: ListView.builder(
                      itemCount: gradeList2.length,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, ind) {
                        return Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                LumpSumTotal(context, gradeList2[ind]),
                              ],
                            )
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              //   color: Colors.black,
              margin: EdgeInsets.only(left: 10),
              height: 60,
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Purchase History ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),




          Container(
            //color: Colors.amber,
            child: Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  ListView.builder(
                    itemCount: lumpsums.length,
                    physics: const NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(
                            //         builder: (context) => OrderDetails(order: salesOrderList[index]))
                            // );
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
                              // width: 200,
                              child:
                              InventoryCard(context, lumpsums[index]
                              )
                          )
                      );
                    },
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
