import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stefomobileapp/pages/DistBuyerspage.dart';
import 'package:stefomobileapp/pages/HomePage.dart';
import 'package:stefomobileapp/pages/InventoryPage.dart';
import 'package:stefomobileapp/pages/buildersbuyerspage.dart';
import 'package:stefomobileapp/ui/common.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import 'ProfilePage.dart';

class buyerspage extends StatefulWidget {
  const buyerspage({super.key});

  @override
  State<buyerspage> createState() => _buyerspageState();
}

class _buyerspageState extends State<buyerspage> {
  var _selected = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar("Buyers", () {
          Get.to(HomePage());
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
              selectedIcon: const Icon(Icons.home_filled, color: Colors.black),
            ),
            BottomBarItem(
                icon: const Icon(
                  Icons.inventory_2_rounded,
                ),
                title: const Text('Safety'),
                backgroundColor: Colors.orange,
                selectedIcon: const Icon(Icons.inventory, color: Colors.black)),
            BottomBarItem(
                icon: const Icon(
                  Icons.warehouse_rounded,
                ),
                title: const Text('Safety'),
                backgroundColor: Colors.black,
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
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Get.to(DealerPage());
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 120,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFF93C6E7),
                  ),
                  child: Text(
                    'VIEW DISTRIBUTORS',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(DealerPage1());
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 120,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFF93C6E7),
                  ),
                  child: Text(
                    'VIEW BUILDERS',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   height: 120,
              //   width: double.infinity,
              //   padding: EdgeInsets.only(
              //     left: 10,
              //     right: 24,
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: Colors.blueGrey,
              //   ),
              //   child: Text(
              //     'Distributor',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 22,
              //         fontWeight: FontWeight.w700),
              //   ),
              // )
            ])));
  }
}
