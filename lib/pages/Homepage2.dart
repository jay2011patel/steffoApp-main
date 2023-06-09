import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/pages/DistBuyerspage.dart';
import 'package:stefomobileapp/pages/InventoryPage.dart';
import 'package:stefomobileapp/pages/OrderPage.dart';
import 'package:stefomobileapp/pages/ProfilePage.dart';
import 'package:stefomobileapp/ui/common.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:http/http.dart' as http;
import '../Models/order.dart';
import '../ui/cards.dart';
import 'LoginPage.dart';
import 'RequestPage.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:image_picker/image_picker.dart';
import 'addItem.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const HomeContent();
    // throw UnimplementedError();
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});
  final selected = 0;
  @override
  State<HomeContent> createState() => _HomePageState(selected);
}

class _HomePageState extends State<HomeContent> {
  var _selected = 0;
  String? _id;
  var fabLoc;
  bool editPrice = false;
  TextEditingController newBasePrice = TextEditingController();

  var homeTab;

  _HomePageState(int val) {
    _selected = val;
  }
  File? pickedImage;
  List<File>? imagesFiles = [];

  var user_type;
  void loadusertype() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user_type = await prefs.getString('userType');
  }

  @override
  Widget build(BuildContext context) {
    loadusertype();
    return WillPopScope(
      onWillPop: () async {
        if (_selected == 0) {
          // LogoutAlert();
        }
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          appBar: appbar("Home", () {
            print("Back Pressed");
            Navigator.pop(context);
          }, alert: LogoutAlert),
          body: HomePageBody(),
          floatingActionButton: LayoutBuilder(builder: (context, constraints) {
            if (user_type != "Manufacturer" && isSalesEnabled == "true") {
              //fabLoc = FloatingActionButtonLocation.centerDocked;
              return FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/placeorder');
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.red,
              );
            } else {
              return Container();
            }
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                selectedIcon:
                    const Icon(Icons.home_filled, color: Colors.blueAccent),
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
                  //  backgroundColor: Colors.orange,
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
                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          InventoryPage(),
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
                          DealerPage(),
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
    //  throw UnimplementedError();
  }

  String? id = "";
  int currentIndex = 0;
  bool isRes1Loaded = false;
  final List<String> imageList = [];
  var responseData1;
  List<Order> requestList = [];
  List<Order> orderList = [];
  String? isSalesEnabled = "false", basePrice = "0";
  var m;
  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    m = id;
    id = await prefs.getString('id');

    if (m != id) {
      requestList = [];
      orderList = [];
      final res1 = await http
          .post(Uri.parse("http://urbanwebmobile.in/steffo/getsystemdata.php"));
      isRes1Loaded = true;
      responseData1 = jsonDecode(res1.body);

      isSalesEnabled = responseData1['data'][0]['value'];
      basePrice = responseData1['data'][1]['value'];
      print(" $isSalesEnabled and $basePrice");

      final res = await http.post(
        Uri.parse("http://urbanwebmobile.in/steffo/vieworder.php"),
        body: {"id": id!},
      );
      var responseData = jsonDecode(res.body);

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
        req.party_mob_num = responseData["data"][i]["partyMobileNumber"];
        req.loading_type = responseData["data"][i]["loadingType"];
        req.order_date = responseData["data"][i]["createdAt"];
        req.base_price = responseData["data"][i]["basePrice"];
        req.orderType = responseData["data"][i]["orderType"];
        req.order_id = responseData["data"][i]["order_id"].toString();
        //print(req);
        if (req.status != "Denied" && req.status != "Pending") {
          orderList.add(req);
        }
        if (req.status?.trim() == "Pending" && id == req.reciever_id) {
          requestList.add(req);
          print("Added to req list");
        }
      }
      setState(() {});
    }
  }

  var price = 999;
  bool light = true;
  Widget HomePageBody() {
    loadData();

    return Container(
        //  height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //carousel slider start////////////////////////////////////
              LayoutBuilder(builder: (context, constraints) {
                if (isRes1Loaded) {
                  print(responseData1['images'].length);
                  if (responseData1['images'].length > 0) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: CarouselSlider.builder(
                        itemCount: responseData1['images'].length,
                        options: CarouselOptions(
                          scrollPhysics: BouncingScrollPhysics(),
                          height: 180.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          //  aspectRatio: 18 / 11,
                          autoPlayCurve: Curves.bounceIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 300),
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        itemBuilder: (context, i, id) {
                          //for onTap to redirect to another screen
                          return GestureDetector(
                            // onLongPress: () {
                            //   imagePickerOption();
                            // },
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                  //  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                //ClipRRect for image border radius
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Center(
                                      child: Image.network(
                                          fit: BoxFit.cover,
                                          "http://urbanwebmobile.in/steffo/carousel/" +
                                              responseData1['images'][i]
                                                  ['name']),
                                    )),
                              ),
                              LayoutBuilder(builder: (context, constraints) {
                                if (user_type == "Manufacturer") {
                                  return Align(
                                    child: Container(
                                      height: 40,
                                      child: IconButton(
                                          onPressed: () async {
                                            var res1 = await http.post(
                                                Uri.parse(
                                                    "http://urbanwebmobile.in/steffo/delcar.php"),
                                                body: {
                                                  "id": responseData1['images']
                                                          [i]['id']
                                                      .toString(),
                                                  "name":
                                                      responseData1['images'][i]
                                                          ['name'],
                                                });

                                            responseData1['images'].removeAt(i);

                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 25,
                                          ),
                                          color: Colors.black),
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    alignment: Alignment.bottomLeft,
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                              LayoutBuilder(builder: (context, constraints) {
                                if (user_type == "Manufacturer") {
                                  return Align(
                                    child: Container(
                                      height: 40,
                                      //color: Colors.amber,
                                      child: IconButton(
                                          onPressed: () async {
                                            await pickMultipleImage(
                                                ImageSource.gallery);

                                            setState(() {
                                              m = id;
                                            });
                                          },
                                          icon: Icon(
                                            size: 25,
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                          color: Colors.white),
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    alignment: Alignment.bottomRight,
                                  );
                                } else {
                                  return Container();
                                }
                              })
                            ]),
                          );
                        },
                      ),
                    );
                  } else if (responseData1['images'].length == 0 &&
                      user_type == "Manufacturer") {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 150,
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: IconButton(
                        onPressed: () {
                          pickMultipleImage(ImageSource.gallery);
                          setState(() {});
                        },
                        icon: Icon(Icons.add_circle_outline_rounded),
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
              SizedBox(
                height: 20,
              ),
              // LayoutBuilder(builder: (context, constraints) {
              //   if (imagesFiles!.length > 0) {
              //     print(responseData1);
              //     return DotsIndicator(
              //       dotsCount: responseData1['images'].length== 0
              //           ? 1
              //           : responseData1['images'].length,
              //       position: currentIndex.toDouble(),
              //       decorator: DotsDecorator(
              //         activeColor: responseData1['images'].length == 0
              //             ? Colors.transparent
              //             : Colors.black,
              //         color: Colors.grey,
              //       ),
              //     );
              //   } else {
              //     return Container();
              //   }
              // }),

              //carousel end//////////////////////////////////////////////////

              LayoutBuilder(builder: (context, constraints) {
                if (user_type == "Manufacturer") {
                  return Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Enable Sales",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FlutterSwitch(
                                        borderRadius: 8,
                                        showOnOff: true,
                                        //  toggleSize: 50,
                                        onToggle: (bool value) async {
                                          light = value;
                                          setState(() {});
                                          var res = await http.post(
                                              Uri.parse(
                                                  "http://urbanwebmobile.in/steffo/setsale.php"),
                                              body: {
                                                "status": value.toString()
                                              });
                                        },

                                        // This bool value toggles the switch.
                                        value: light,
                                        activeColor: Colors.green,
                                        // onChanged: (bool value) async {
                                        //   // This is called when the user toggles the switch.
                                        //   //print(value);
                                        //   light = value;
                                        //   setState(() {});
                                        //   var res = await http.post(
                                        //       Uri.parse(
                                        //           "http://urbanwebmobile.in/steffo/setsale.php"),
                                        //       body: {"status": value.toString()});
                                        //}
                                      )
                                    ],
                                  )),

                              GestureDetector(
                                onTap: () {
                                  Get.to(AddItemPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  // height: 35,
                                  // width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueGrey,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Admin Controls',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => AddItemPage()));
                              //     },
                              //     child: Text("Admin Controls"))
                            ],
                          )),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(
                height: 10,
              ),

              ///price bar start//////////////////////////

              LayoutBuilder(builder: (context, constraint) {
                if (light == true) {
                  return Container(
                    height: 40,
                    margin: EdgeInsets.all(5.0),
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (editPrice == false) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              //width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                "Base Price : ${basePrice}/-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            LayoutBuilder(builder: (context, constraints) {
                              if (user_type == "Manufacturer") {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        editPrice = true;
                                      });
                                    },
                                    icon: Icon(Icons.mode_edit_outlined),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            })
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: TextFormField(
                                // initialValue: price.toString(),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                controller: newBasePrice,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                                // onFieldSubmitted: (value) {
                                //   print(value);
                                //   setState(() {
                                //     editPrice = false;
                                //     price = int.parse(value);
                                //   });
                                // }),
                              ),
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                            ElevatedButton(
                                // icon: Icon(Icons.done_outlined),

                                onPressed: () {
                                  // print(newBasePrice.text);
                                  setState(() {
                                    editPrice = false;
                                    final numericRegex = RegExp(r'^[0-9]*$');
                                    if (numericRegex
                                            .hasMatch(newBasePrice.text) &&
                                        newBasePrice.text.trim() != "") {
                                      price = int.parse(newBasePrice.text);
                                      http.post(
                                          Uri.parse(
                                              "http://urbanwebmobile.in/steffo/setbaseprice.php"),
                                          body: {
                                            "basePrice":
                                                newBasePrice.text.toString()
                                          });
                                      basePrice = newBasePrice.text;
                                    }
                                  });
                                },
                                child: Text("Submit"),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black))
                          ],
                        );
                      }
                    }),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(
                height: 10,
              ),

              // price bar end//////////////
              Container(
                height: 450,
                child: ContainedTabBarView(
                  tabBarProperties: TabBarProperties(
                    indicatorColor: Colors.blueGrey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    margin: EdgeInsets.only(left: 10, right: 10),
                  ),
                  tabs: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('ORDERS',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            height: 35,
                            child: Text(
                                orderList.length.toString().padLeft(2, '0'),
                                style: TextStyle(
                                    color: orderList.length > 00
                                        ? Colors.green
                                        : Colors.grey,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w100)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('REQUESTS',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Container(
                          height: 35,
                          child: Text(
                              requestList.length.toString().padLeft(2, '0'),
                              style: TextStyle(
                                  color: requestList.length > 00
                                      ? Colors.amber
                                      : Colors.grey,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                  ],
                  views: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        //  color: Colors.amber,
                        child: Column(
                          children: [
                            LayoutBuilder(builder: (context, constraints) {
                              if (user_type == "Dealer") {
                                return ListView.builder(
                                  itemCount: orderList.length > 3
                                      ? 3
                                      : orderList.length,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetails(
                                                          order: orderList[
                                                              index])));
                                        },
                                        child: orderCard(
                                            context, orderList[index], id));
                                  },
                                );
                              } else {
                                //things to do in this listvies
                                return Container(
                                  //color: Colors.blue,
                                  //  height: 300,

                                  child: ListView.builder(
                                    itemCount: orderList.length > 3
                                        ? 3
                                        : orderList.length,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderDetails(
                                                            order: orderList[
                                                                index])));
                                          },
                                          child: orderCard(
                                              context, orderList[index], id));
                                    },
                                  ),
                                );
                              }
                            }),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                width: MediaQuery.of(context).size.width / 4,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.blueGrey)),
                                  child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "View All Orders",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/orders');
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: LayoutBuilder(builder: (context, constraints) {
                        if (user_type != "Dealer") {
                          return Container(
                              //height: MediaQuery.of(context).size.height*0.36,
                              decoration: BoxDecoration(
                                  // color:
                                  //     const Color.fromRGBO(255, 255, 255, 0.5),

                                  borderRadius: BorderRadius.circular(8)),
                              margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 300,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: requestList.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrderDetails(
                                                                  order: requestList[
                                                                      index])));
                                                },
                                                child: orderRequestCard(
                                                    context, requestList[index],
                                                    () {
                                                  // orderList.add(requestList[index]);
                                                  // requestList.removeAt(index);
                                                  id = "none";
                                                  loadData();
                                                  setState(() {});
                                                }));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      // margin:
                                      //     EdgeInsets.symmetric(horizontal: 20),
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: ElevatedButton(
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text("View All request")),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed('/orderreq');
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        } else {
                          return Container();
                        }
                      }),
                    )
                  ],
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Container(
              //     // margin:
              //     //     EdgeInsets.symmetric(horizontal: 20),
              //     width: MediaQuery.of(context).size.width / 4,
              //     child: ElevatedButton(
              //       child: Align(
              //           alignment: Alignment.center, child: Text("View All")),
              //       onPressed: () {
              //         Navigator.of(context).pushNamed('/orderreq');
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }

  pickMultipleImage(ImageSource source) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      for (XFile image in images) {
        var imagesTemporary = File(image.path);
        imagesFiles!.add(imagesTemporary);
        var imgBytes = imagesTemporary.readAsBytesSync();
        String baseImage = base64Encode(imgBytes);
        var res = await http.post(
            Uri.parse("http://www.urbanwebmobile.in/steffo/setcarousel.php"),
            body: {"name": image.name, "value": baseImage});

        var picUpRes = jsonDecode(res.body);

        responseData1['images']
            .add({"id": picUpRes['data'], "name": image.name});
      }
      setState(() {});
    } catch (e) {
      print("Image Error");
    }
  }

  LogoutAlert() {
    print("object");
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        barrierDismissible: true,
        cancelBtnText: 'Cancel',
        confirmBtnText: 'Yes',
        title: 'Are you sure?',
        text: 'Logout',
        textColor: Colors.red,

        // customAsset: Icon(Icons.login_outlined),
        onConfirmBtnTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
              ModalRoute.withName(
                  '/') // Replace this with your root screen's route name (usually '/')
              );
        },
        onCancelBtnTap: () {
          Get.back();
        });
  }
}
