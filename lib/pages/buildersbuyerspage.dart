import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/pages/DealerDetailPage.dart';
import 'package:stefomobileapp/pages/DistributorDetailPage.dart';
import 'package:stefomobileapp/pages/HomePage.dart';
import 'package:stefomobileapp/pages/InventoryPage.dart';
import 'package:stefomobileapp/pages/EditableProfilePage.dart';
import 'package:stefomobileapp/ui/cards.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:http/http.dart' as http;
import '../Models/user.dart';
import '../ui/common.dart';
import 'ProfilePage.dart';

class DealerPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DealerContent1();
  }
}

class DealerContent1 extends StatefulWidget {
  const DealerContent1({super.key});
  @override
  State<DealerContent1> createState() => _DealerPageState();
}

class _DealerPageState extends State<DealerContent1> {
  var _selected = 2;
  @override
  void initState() {
    // TODO: implement initState
    loadChildData();
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
          appBar: appbar("Builders", () {
            Navigator.pop(context);
          }),
          body: DealerPageBody(),
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
                  icon: const Icon(Icons.inventory_2_rounded),
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
                  selectedIcon:
                      const Icon(Icons.warehouse_rounded, color: Colors.black)),
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

  bool isDataReady = false;
  var userType;
  List<User> child = [];
  loadChildData() async {
    child = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    userType = await prefs.getString('userType');
    String uri;
    uri = "http://urbanwebmobile.in/steffo/getchildren.php";

    var res = await http.post(Uri.parse(uri), body: {
      "id": id,
    });

    var responseData = json.decode(res.body);
    print(responseData['data'].length);
    for (int i = 0; i < responseData['data'].length; i++) {
      User u = User();
      u.id = responseData["data"][i]["id"];
      u.userType = responseData["data"][i]["userType"];
      u.orgName = responseData["data"][i]["orgName"];
      u.address = responseData["data"][i]["address"];
      u.email = responseData["data"][i]["email"];
      u.mobileNumber = responseData["data"][i]["mobileNumber"];
      u.gstNumber = responseData["data"][i]["gstNumber"];
      u.panNumber = responseData["data"][i]["panNumber"];
      u.adhNumber = responseData["data"][i]["adhNumber"];
      print(u);
      child.add(u);
    }

    isDataReady = true;
    setState(() {});
  }

  Widget DealerPageBody() {
    //loadChildData();
    return LayoutBuilder(builder: (context, constraints) {
      if (isDataReady) {
        return LayoutBuilder(builder: (context, constraints) {
          if (userType == "Manufacturer") {
            return ListView.builder(
                //  physics: BouncingScrollPhysics(),
                itemCount: child.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DistributorDetailPage(
                                        user: child[index])));
                          },
                          child: BuilderCard(child[index], context)),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                });
          } else if (userType == "Distributor") {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: child.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                          overlayColor: MaterialStatePropertyAll(Colors.white),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DealerDetailPage(user: child[index])));
                          },
                          child: DealerCard(child[index], context)),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                });
          } else {
            return Container();
          }
        });
      } else {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.grey,
        ));
      }
    });
  }
}
