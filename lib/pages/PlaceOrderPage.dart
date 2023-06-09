// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stefomobileapp/ui/cards.dart';
// import '../Models/grade.dart';
// import '../Models/lumpsum.dart';
// import '../Models/region.dart';
// import '../Models/size.dart';
// import '../ui/common.dart';
//
// class PlaceOrderPage extends StatelessWidget {
//   const PlaceOrderPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const PlaceOrderContent();
//   }
// }
//
// class PlaceOrderContent extends StatefulWidget {
//   const PlaceOrderContent({super.key});
//   final selected = 0;
//   @override
//   State<PlaceOrderContent> createState() => _PlaceOrderPageState();
// }
//
// class _PlaceOrderPageState extends State<PlaceOrderContent> {
//   final _formKey = GlobalKey<FormState>();
//
//   late FocusNode focusNode1;
//   late FocusNode focusNode2;
//   late FocusNode focusNode3;
//   late FocusNode focusNode4;
//   late FocusNode focusNode5;
//   late FocusNode focusNode6;
//   late FocusNode focusNode7;
//   late FocusNode focusNode8;
//   late FocusNode focusNode9;
//   final field1Key = GlobalKey<FormFieldState>();
//   final field2Key = GlobalKey<FormFieldState>();
//   final field3Key = GlobalKey<FormFieldState>();
//   final field4Key = GlobalKey<FormFieldState>();
//   final field5Key = GlobalKey<FormFieldState>();
//   final field6Key = GlobalKey<FormFieldState>();
//   final field8Key = GlobalKey<FormFieldState>();
//   final field7Key = GlobalKey<FormFieldState>();
//   final field9Key = GlobalKey<FormFieldState>();
//
//   var user_type;
//   void loadusertype() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     user_type = await prefs.getString('userType');
//   }
//
//   String isItem = " ";
//
//   @override
//   Widget build(BuildContext context) {
//     loadusertype();
//
//     return Scaffold(
//       appBar: appbar("Place Order", () {
//         Navigator.pop(context);
//       }),
//       body: PlaceOrderBody(),
//     );
//   }
//
//   String? id, supplier_id;
//   var f1 = 0;
//   Future<void> loadData() async {
//     if (f1 == 0) {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       id = await prefs.getString('id');
//       supplier_id = await prefs.getString('parentId');
//       if (user_type == "Builder") {
//         selectedOrderType = "With Size";
//         selectedTransType = "None";
//         selectedType = "None";
//       }
//       f1 = 1;
//       setState(() {});
//     }
//     //print("is setstate on loop");
//   }
//
//   String?
//       // selectedValue,
//       selectedSize,
//       selectedGrade,
//       selectedType,
//       selectedRegion,
//       selectedTransType,
//       selectedOrderType;
//   TextEditingController qty = TextEditingController();
//   TextEditingController party_name = TextEditingController();
//   TextEditingController party_address = TextEditingController();
//   TextEditingController party_pan_no = TextEditingController();
//   TextEditingController party_mob_num = TextEditingController();
//   TextEditingController loading_type = TextEditingController();
//   TextEditingController base_price = TextEditingController();
//   List<Lumpsum> lumpsumList = [];
//   bool isInventoryDataLoaded = false;
//   loadLumpsumData() async {
//     print("inLoadLumpsumData");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final user_id = await prefs.getString('id');
//
//     var res = await http.post(
//         Uri.parse("http://urbanwebmobile.in/steffo/getinventory.php"),
//         body: {
//           "user_id": user_id,
//         });
//
//     var responseData = jsonDecode(res.body);
//
//     print(responseData);
//     for (int i = 0; i < responseData["data"].length; i++) {
//       print(responseData['data'][i]['name']);
//       Lumpsum l = Lumpsum();
//       l.orderId = responseData["data"][i]["order_id"];
//       l.name = responseData["data"][i]["name"];
//       l.qty = responseData["data"][i]["qty_left"];
//       l.price = responseData["data"][i]["price"];
//       l.status = responseData["data"][i]["status"];
//       l.id = responseData['data'][i]["ls_id"];
//       l.date = responseData["data"][i]["createdAt"];
//       lumpsumList.add(l);
//     }
//     isInventoryDataLoaded = true;
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     loadLumpsumData();
//     super.initState();
//     focusNode1 = FocusNode();
//     focusNode2 = FocusNode();
//     focusNode3 = FocusNode();
//     focusNode4 = FocusNode();
//     focusNode5 = FocusNode();
//     focusNode6 = FocusNode();
//     focusNode7 = FocusNode();
//     focusNode8 = FocusNode();
//     focusNode9 = FocusNode();
//     focusNode1.addListener(() {
//       if (!focusNode1.hasFocus) {
//         field1Key.currentState?.validate();
//       }
//     });
//     focusNode2.addListener(() {
//       if (!focusNode2.hasFocus) {
//         field2Key.currentState?.validate();
//       }
//     });
//     focusNode3.addListener(() {
//       if (!focusNode3.hasFocus) {
//         field3Key.currentState?.validate();
//       }
//     });
//     focusNode4.addListener(() {
//       if (!focusNode4.hasFocus) {
//         field4Key.currentState?.validate();
//       }
//     });
//     focusNode5.addListener(() {
//       if (!focusNode5.hasFocus) {
//         field5Key.currentState?.validate();
//       }
//     });
//     focusNode6.addListener(() {
//       if (!focusNode6.hasFocus) {
//         field6Key.currentState?.validate();
//       }
//     });
//     focusNode7.addListener(() {
//       if (!focusNode7.hasFocus) {
//         field7Key.currentState?.validate();
//       }
//     });
//     focusNode8.addListener(() {
//       if (!focusNode8.hasFocus) {
//         field8Key.currentState?.validate();
//       }
//     });
//     focusNode9.addListener(() {
//       if (!focusNode9.hasFocus) {
//         field9Key.currentState?.validate();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     focusNode1.dispose();
//     focusNode2.dispose();
//     focusNode3.dispose();
//     focusNode4.dispose();
//     focusNode5.dispose();
//     focusNode6.dispose();
//     focusNode7.dispose();
//     focusNode8.dispose();
//     focusNode9.dispose();
//     super.dispose();
//   }
//
//   // List items = ["TMT"];
//   List grades = [];
//   List sizes = [];
//   List regions = [];
//   List<Grade> gradeList = [];
//   List<Region> regionList = [];
//   List<ItemSize> sizeList = [];
//   var f = 0;
//   loadItemData() async {
//     if (f == 0) {
//       f = 1;
//       var res = await http
//           .post(Uri.parse("http://urbanwebmobile.in/steffo/getsize.php"));
//       var responseData = jsonDecode(res.body);
//       for (int i = 0; i < responseData['data'].length; i++) {
//         sizes.add(responseData['data'][i]["sizeValue"].toString());
//         ItemSize s = ItemSize();
//         s.price = responseData['data'][i]["sizePrice"];
//         s.value = responseData['data'][i]["sizeValue"];
//         sizeList.add(s);
//       }
//
//       var res1 = await http
//           .post(Uri.parse("http://urbanwebmobile.in/steffo/getgrade.php"));
//       var responseData1 = jsonDecode(res1.body);
//       for (int i = 0; i < responseData1['data'].length; i++) {
//         print(responseData1['data'][i]);
//         grades.add(responseData1['data'][i]["gradeName"]);
//         Grade s = Grade();
//         s.price = responseData1['data'][i]["gradePrice"];
//         s.value = responseData1['data'][i]["gradeName"];
//         gradeList.add(s);
//       }
//
//       var res2 = await http
//           .post(Uri.parse("http://urbanwebmobile.in/steffo/getregions.php"));
//       var responseData2 = jsonDecode(res2.body);
//       for (int i = 0; i < responseData2['data'].length; i++) {
//         print(responseData2['data'][i]);
//         regions.add(responseData2['data'][i]["regionName"]);
//         Region r = Region();
//         r.name = responseData2['data'][i]["regionName"];
//         r.cost = responseData2['data'][i]["tCost"];
//         regionList.add(r);
//       }
//       setState(() {});
//     }
//   }
//
//   List type = ["Loose", "Bhari"];
//   List transType = ["FOR", "Ex work"];
//   List orderType = ["Lump-sum", "With Size", "Use Lumpsum"];
//
//   int itemNum = 1;
//   int totalQuantity = 0;
//
//   final List<Map<String, String>> listOfColumns = [];
//   onPlaceOrder() async {
//     if (selectedOrderType == "Use Lumpsum") {
//       for (int i = 0; i < reductionData.length; i++) {
//         var res = await http.post(
//             Uri.parse("http://urbanwebmobile.in/steffo/updateinventory.php"),
//             body: {
//               "id": reductionData[i]["id"],
//               "qty": reductionData[i]["qty"]
//             });
//       }
//     }
//     var res = await http.post(
//       Uri.parse("http://urbanwebmobile.in/steffo/placeorder.php"),
//       body: selectedOrderType == "Lump-sum"
//           ? {
//               "userId": id!,
//               "supplierId": supplier_id!,
//               "shippingAddress": party_address.text,
//               "partyName": party_name.text,
//               "gstNumber": party_pan_no.text,
//               "mobileNumber": party_mob_num.text,
//               "basePrice": base_price.text,
//               "status": "Pending",
//               "loadingType": selectedType,
//               "transportationType": "None",
//               "orderType": selectedOrderType,
//               //"createdAt": DateTime.now().toString(),
//
//               //....................
//             }
//           : {
//               "userId": id!,
//               "supplierId": supplier_id!,
//               "shippingAddress": party_address.text,
//               "partyName": party_name.text,
//               "gstNumber": party_pan_no.text,
//               "mobileNumber": party_mob_num.text,
//               "basePrice": base_price.text,
//               "status": "Pending",
//               "loadingType": selectedType,
//               "orderType": selectedOrderType,
//               "transportationType": selectedTransType,
//               //.......................
//             },
//     );
//     Fluttertoast.showToast(
//         msg: 'Your Order Is Placed',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.lightGreen,
//         textColor: Colors.white);
//     Navigator.of(context).pushNamed("/home");
//
//     var responseData = json.decode(res.body);
//     print(responseData["value"].toString());
//
//     if (responseData["status"] == '200' && selectedOrderType != "Lump-sum") {
//       for (int i = 0; i < listOfColumns.length; i++) {
//         http.post(
//           Uri.parse("http://urbanwebmobile.in/steffo/setorder.php"),
//           body: {
//             "order_id": responseData["value"].toString(),
//             "name": listOfColumns[i]["Name"],
//             "qty": listOfColumns[i]["Qty"],
//             "price": listOfColumns[i]["Price"]
//           },
//         );
//       }
//     } else {
//       for (int i = 0; i < listOfColumns.length; i++) {
//         http.post(
//           Uri.parse("http://urbanwebmobile.in/steffo/addlumpsum.php"),
//           body: {
//             "order_id": responseData["value"].toString(),
//             "name": listOfColumns[i]["Name"],
//             "qty": listOfColumns[i]["Qty"],
//             "price": listOfColumns[i]["Price"]
//           },
//         );
//       }
//     }
//
//     // print(listOfColumns[0]['Name']);
//   }
//
//   num tCost = 0;
//   var reductionData = [];
//   Widget PlaceOrderBody() {
//     loadItemData();
//     // List<DropdownMenuItem<String>> dropdownItems = [];
//     List<DropdownMenuItem<String>> dropdownGrades = [];
//     List<DropdownMenuItem<String>> dropdownSize = [];
//     List<DropdownMenuItem<String>> dropdownType = [];
//     List<DropdownMenuItem<String>> dropdownRegion = [];
//     List<DropdownMenuItem<String>> dropdownTransType = [];
//     List<DropdownMenuItem<String>> dropdownOrderType = [];
//     // List<DropdownMenuItem<String>> getItems() {
//     //   for (int i = 0; i < items.length; i++) {
//     //     DropdownMenuItem<String> it = DropdownMenuItem(
//     //       value: items[i],
//     //       child: Text(items[i]),
//     //     );
//     //     dropdownItems.add(it);
//     //   }
//     //   return dropdownItems;
//     // }
//
//     List<DropdownMenuItem<String>> getGrade() {
//       for (int i = 0; i < grades.length; i++) {
//         DropdownMenuItem<String> it = DropdownMenuItem(
//           value: grades[i],
//           child: Text(grades[i]),
//         );
//         dropdownGrades.add(it);
//       }
//
//       return dropdownGrades;
//     }
//
//     List<DropdownMenuItem<String>> getSize() {
//       for (int i = 0; i < sizes.length; i++) {
//         DropdownMenuItem<String> it = DropdownMenuItem(
//           value: sizes[i],
//           child: Text(sizes[i]),
//         );
//         dropdownSize.add(it);
//       }
//       return dropdownSize;
//     }
//
//     List<DropdownMenuItem<String>> getRegion() {
//       for (int i = 0; i < regions.length; i++) {
//         DropdownMenuItem<String> it = DropdownMenuItem(
//           value: regions[i],
//           child: Text(regions[i]),
//         );
//         dropdownRegion.add(it);
//       }
//       return dropdownRegion;
//     }
//
//     List<DropdownMenuItem<String>> getType() {
//       for (int i = 0; i < type.length; i++) {
//         DropdownMenuItem<String> it = DropdownMenuItem(
//           value: type[i],
//           child: Text(type[i]),
//         );
//         dropdownType.add(it);
//       }
//       return dropdownType;
//     }
//
//     List<DropdownMenuItem<String>> getTransType() {
//       for (int i = 0; i < transType.length; i++) {
//         DropdownMenuItem<String> it = DropdownMenuItem(
//           value: transType[i],
//           child: Text(transType[i]),
//         );
//         dropdownTransType.add(it);
//       }
//       return dropdownTransType;
//     }
//
//     List<DropdownMenuItem<String>> getOrderType() {
//       for (int i = 0; i < orderType.length; i++) {
//         DropdownMenuItem<String> it = DropdownMenuItem(
//           value: orderType[i],
//           child: Text(orderType[i]),
//         );
//         dropdownOrderType.add(it);
//       }
//       return dropdownOrderType;
//     }
//
//     loadData();
//
//     return Form(
//       key: _formKey,
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//             // gradient: LinearGradient(
//             //
//             //     transform: GradientRotation(1.07),
//             //     colors: [
//             //       Color.fromRGBO(75, 100, 160, 1.0),
//             //       Color.fromRGBO(19, 59, 78, 1.0),
//             //     ]
//             //
//             // )
//             color: Colors.white),
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               //-----------------------Name-------------------------------------
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//                 child: TextFormField(
//                   key: field1Key,
//                   focusNode: focusNode1,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a Name.';
//                     }
//                     return null;
//                   },
//                   controller: party_name,
//                   maxLines: 1,
//                   decoration: const InputDecoration(
//                       labelText: "Name",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       border: OutlineInputBorder(
//                           // borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                       filled: true,
//                       fillColor: Color.fromRGBO(233, 236, 239,
//                           0.792156862745098) //Color.fromRGBO(233, 236, 239, 0.792156862745098)
//
//                       ),
//                 ),
//               ),
//               //----------------------------Shipping Address--------------------
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextFormField(
//                   key: field2Key,
//                   focusNode: focusNode2,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter an Address.';
//                     }
//                     return null;
//                   },
//                   controller: party_address,
//                   maxLines: 4,
//                   decoration: const InputDecoration(
//                       labelText: "Shipping Address",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       alignLabelWithHint: true,
//                       border: OutlineInputBorder(
//                           // borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                       filled: true,
//                       fillColor: Color.fromRGBO(233, 236, 239,
//                           0.792156862745098) //Color.fromRGBO(233, 236, 239, 0.792156862745098)
//
//                       ),
//                 ),
//               ),
//               //-------------------------------Region---------------------------
//
//               Container(
//                   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: DropdownButtonFormField(
//                     decoration: const InputDecoration(
//                         hintText: "Select Region of Delivery",
//                         filled: true,
//                         fillColor:
//                             Color.fromRGBO(233, 236, 239, 0.792156862745098),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           // borderRadius: BorderRadius.circular(20)
//                         )),
//                     value: selectedRegion,
//                     items: getRegion(),
//                     onChanged: (String? newValue) {
//                       selectedRegion = newValue;
//                       var ind = regions.indexOf(selectedRegion);
//                       tCost = int.parse(regionList[ind].cost!);
//                     },
//                     validator: (selectedValue) {
//                       if (selectedValue == null) {
//                         // return 'Please select a value.';
//                       }
//                       return null;
//                     },
//                   )),
//
//               //-----------------------------Pan Number-------------------------
//
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextFormField(
//                   key: field3Key,
//                   focusNode: focusNode3,
//                   controller: party_pan_no,
//                   maxLines: 1,
//                   maxLength: 15,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a value.';
//                     } else if (value.length < 15) {
//                       return 'Please Enter Valid Number';
//                     }
//                     if (value.length > 15) {
//                       return 'Please Enter Valid Number';
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                       labelText: "GST Number",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       border: OutlineInputBorder(
//                           // borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                       filled: true,
//                       fillColor: const Color.fromRGBO(233, 236, 239,
//                           0.792156862745098) //Color.fromRGBO(233, 236, 239, 0.792156862745098)
//
//                       ),
//                 ),
//               ),
//
//               //----------------------------Contact Number----------------------
//
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextFormField(
//                   key: field4Key,
//                   focusNode: focusNode4,
//                   controller: party_mob_num,
//                   maxLines: 1,
//                   keyboardType: TextInputType.number,
//                   maxLength: 10,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please Enter a Number.';
//                     } else if (value.length < 10) {
//                       return 'Please Enter Valid Number';
//                     }
//                     if (value.length > 10) {
//                       return 'Please Enter Valid Number';
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                       labelText: "Contact Number",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       border: OutlineInputBorder(
//                           // borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                       filled: true,
//                       fillColor: Color.fromRGBO(233, 236, 239,
//                           0.792156862745098) // Color.fromRGBO(233, 236, 239, 0.792156862745098)
//                       ),
//                 ),
//               ),
//
//               LayoutBuilder(builder: (context, constraints) {
//                 if (user_type == "Distributor" || user_type == "Dealer") {
//                   return Container(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                       child: DropdownButtonFormField(
//                         decoration: const InputDecoration(
//                             hintText: "Select Order Type",
//                             filled: true,
//                             fillColor: Color.fromRGBO(
//                                 233, 236, 239, 0.792156862745098),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               // borderRadius: BorderRadius.circular(20)
//                             )),
//                         value: selectedOrderType,
//                         items: getOrderType(),
//                         onChanged: (String? newValue) {
//                           selectedOrderType = newValue;
//                           if (selectedOrderType == "Lump-sum") {
//                             selectedTransType = "None";
//                           }
//                         },
//                         // key: field5Key,
//                         // focusNode: focusNode5,
//                         validator: (selectedValue) {
//                           if (selectedValue == null) {
//                             return 'Please select a value.';
//                           }
//                           return null;
//                         },
//                       ));
//                 } else {
//                   return Container();
//                 }
//               }),
//
//               //--------------------------Loading Type--------------------------//
//
//               LayoutBuilder(builder: (context, constraints) {
//                 if (selectedOrderType != "Lump-sum" &&
//                     (user_type == "Dealer" || user_type == "Distributor")) {
//                   return Column(
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                           child: DropdownButtonFormField(
//                             decoration: const InputDecoration(
//                                 hintText: "Select Loading Type",
//                                 filled: true,
//                                 fillColor: Color.fromRGBO(
//                                     233, 236, 239, 0.792156862745098),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                   // borderRadius: BorderRadius.circular(20)
//                                 )),
//                             value: selectedType,
//                             items: getType(),
//                             onChanged: (String? newValue) {
//                               selectedType = newValue;
//                             },
//                             key: field5Key,
//                             focusNode: focusNode5,
//                             validator: (selectedValue) {
//                               if (selectedValue == null) {
//                                 //return 'Please select a value.';
//                               }
//                               return null;
//                             },
//                           )),
//                       Container(
//                           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                           child: DropdownButtonFormField(
//                             decoration: const InputDecoration(
//                                 hintText: "Select Transportation Type",
//                                 filled: true,
//                                 fillColor: Color.fromRGBO(
//                                     233, 236, 239, 0.792156862745098),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                   // borderRadius: BorderRadius.circular(20)
//                                 )),
//                             value: selectedTransType,
//                             items: getTransType(),
//                             onChanged: (String? newValue) {
//                               selectedTransType = newValue;
//                             },
//                             // key: field5Key,
//                             // focusNode: focusNode5,
//                             validator: (selectedValue) {
//                               if (selectedValue == null) {
//                                 return 'Please select a value.';
//                               }
//                               return null;
//                             },
//                           ))
//                     ],
//                   );
//                 } else {
//                   return Container();
//                 }
//               }),
//
//               // Container(
//               //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//               //   child: TextFormField(
//               //     key: field5Key,
//               //     focusNode: focusNode5,
//               //     controller: loading_type,
//               //     maxLines: 1,
//               //     validator: (value) {
//               //       if (value!.isEmpty || value == null) {
//               //         return 'Please enter a value.';
//               //       }
//               //       return null;
//               //     },
//               //     decoration: const InputDecoration(
//               //         labelText: "Loading Type",
//               //         floatingLabelBehavior: FloatingLabelBehavior.never,
//               //         border: OutlineInputBorder(
//               //             // borderRadius: BorderRadius.circular(20),
//               //             borderSide: BorderSide.none),
//               //         filled: true,
//               //         fillColor: Color.fromRGBO(233, 236, 239,
//               //             0.792156862745098) // Color.fromRGBO(233, 236, 239, 0.792156862745098)
//               //
//               //         ),
//               //   ),
//               // ),
//
//               //------------------------------BasePrice--------------------------
//
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextFormField(
//                   key: field6Key,
//                   focusNode: focusNode6,
//                   controller: base_price,
//                   maxLines: 1,
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a value.';
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                       labelText: "Base Price",
//                       floatingLabelBehavior: FloatingLabelBehavior.never,
//                       border: OutlineInputBorder(
//                           // borderRadius: BorderRadius.circular(20),
//                           borderSide: BorderSide.none),
//                       filled: true,
//                       fillColor:
//                           Color.fromRGBO(233, 236, 239, 0.792156862745098)),
//                 ),
//               ),
//
//               //-------------------Add Item Block-------------------------------
//
//               Container(
//                 margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 decoration: const BoxDecoration(
//                     // color: Colors.white, borderRadius: BorderRadius.circular(20)
//                     ),
//                 child: Column(
//                   children: [
//                     // Container(
//                     //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     //     child: DropdownButtonFormField(
//                     //       decoration: const InputDecoration(
//                     //           hintText: "Select The Product",
//                     //           filled: true,
//                     //           fillColor: Color.fromRGBO(
//                     //               233, 236, 239, 0.792156862745098),
//                     //           border: OutlineInputBorder(
//                     //             borderSide: BorderSide.none,
//                     //             // borderRadius: BorderRadius.circular(20)
//                     //           )),
//                     //       value: selectedValue,
//                     //       items: getItems(),
//                     //       onChanged: (String? newValue) {
//                     //         selectedValue = newValue;
//                     //       },
//                     //       key: field9Key,
//                     //       focusNode: focusNode9,
//                     //       validator: (selectedValue) {
//                     //         if (selectedValue == null) {
//                     //           return 'Please select a value.';
//                     //         }
//                     //         return null;
//                     //       },
//                     //     )),
//                     Container(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                         child: DropdownButtonFormField(
//                           decoration: const InputDecoration(
//                               hintText: "Select The Grade",
//                               filled: true,
//                               fillColor: Color.fromRGBO(
//                                   233, 236, 239, 0.792156862745098),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                                 // borderRadius: BorderRadius.circular(20)
//                               )),
//                           value: selectedGrade,
//                           items: getGrade(),
//                           onChanged: (String? newValue) {
//                             selectedGrade = newValue;
//                           },
//                           key: field8Key,
//                           focusNode: focusNode8,
//                           validator: (selectedValue) {
//                             if (selectedValue == null) {
//                               // return 'Please select a value.';
//                             }
//                             return null;
//                           },
//                         )),
//                     LayoutBuilder(builder: (context, constraints) {
//                       if (selectedOrderType == "With Size") {
//                         if (selectedSize == " ") {
//                           selectedSize = null;
//                         }
//                         return Container(
//                             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                             child: DropdownButtonFormField(
//                               decoration: const InputDecoration(
//                                   hintText: "Select The Size",
//                                   filled: true,
//                                   fillColor: Color.fromRGBO(
//                                       233, 236, 239, 0.792156862745098),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                     // borderRadius: BorderRadius.circular(20)
//                                   )),
//                               value: selectedSize,
//                               items: getSize(),
//                               onChanged: (String? newValue) {
//                                 selectedSize = newValue;
//                               },
//                               key: field7Key,
//                               focusNode: focusNode7,
//                               validator: (selectedValue) {
//                                 if (selectedValue == null) {
//                                   return 'Please select a value.';
//                                 }
//                                 return null;
//                               },
//                             ));
//                       } else {
//                         selectedSize = "";
//                         return Container();
//                       }
//                     }),
//                     Container(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                       child: TextFormField(
//                         maxLines: 1,
//                         controller: qty,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           labelText: "Quantity",
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           border: OutlineInputBorder(
//                               // borderRadius: BorderRadius.circular(20),
//                               borderSide: BorderSide.none),
//                           filled: true,
//                           fillColor: Color.fromRGBO(233, 236, 239,
//                               0.792156862745098), //Color.fromRGBO(233, 236, 239, 0.792156862745098)
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Text(isItem, style: TextStyle(color: Colors.red)),
//                     ),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFFBC252),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             minimumSize: const Size(190, 40)),
//                         onPressed: () {
//                           var grdpct, szpct = 0;
//                           if (selectedOrderType != "Use Lumpsum") {
//                             if (selectedGrade != null &&
//                                 selectedSize != null &&
//                                 qty.text != "" &&
//                                 base_price.text != "" &&
//                                 selectedRegion != null &&
//                                 selectedTransType != null) {
//                               for (int i = 0; i < gradeList.length; i++) {
//                                 if (gradeList[i].value == selectedGrade) {
//                                   grdpct = int.parse(gradeList[i].price!);
//                                 }
//                               }
//                               for (int i = 0; i < sizeList.length; i++) {
//                                 if (sizeList[i].value == selectedSize) {
//                                   szpct = int.parse(sizeList[i].price!);
//                                 }
//                               }
//                               setState(() {
//                                 isItem = " ";
//                                 int f = 0;
//                                 for (int i = 0; i < listOfColumns.length; i++) {
//                                   if (listOfColumns.elementAt(i)["Name"]! ==
//                                       // "$selectedValue"
//                                       "$selectedGrade $selectedSize") {
//                                     int quty = int.parse(
//                                         listOfColumns.elementAt(i)["Qty"]!);
//                                     quty = quty + int.parse(qty.text);
//                                     num p = selectedTransType == "FOR" &&
//                                             selectedOrderType != "Lump-sum"
//                                         ? (int.parse(base_price.text) +
//                                                 grdpct +
//                                                 szpct +
//                                                 tCost) *
//                                             quty
//                                         : (int.parse(base_price.text) +
//                                                 grdpct +
//                                                 szpct +
//                                                 0) *
//                                             quty;
//
//                                     listOfColumns.elementAt(i)["Qty"] =
//                                         quty.toString();
//                                     listOfColumns.elementAt(i)["Price"] =
//                                         p.toString();
//                                     f = 1;
//                                   }
//                                 }
//                                 if (f == 0) {
//                                   listOfColumns.add({
//                                     "Sr_no": itemNum.toString(),
//                                     "Name": "$selectedGrade $selectedSize",
//                                     "Qty": qty.text,
//                                     "Price": selectedTransType == "FOR" &&
//                                             selectedOrderType != "Lump-sum"
//                                         ? ((int.parse(base_price.text) +
//                                                     grdpct +
//                                                     szpct +
//                                                     tCost) *
//                                                 int.parse(qty.text))
//                                             .toString()
//                                         : ((int.parse(base_price.text) +
//                                                     grdpct +
//                                                     szpct +
//                                                     0) *
//                                                 int.parse(qty.text))
//                                             .toString()
//                                   });
//                                   itemNum = itemNum + 1;
//                                 }
//                               });
//                               totalQuantity =
//                                   totalQuantity + int.parse(qty.text);
//                               //print(totalQuantity);
//                             } else {
//                               isItem = "Please Enter All of the above fields";
//                               setState(() {});
//                             }
//                           } else {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return Dialog(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   elevation: 16,
//                                   child: Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       //height: 400,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                               child: Text("Select The Lumpsum",
//                                                   style: GoogleFonts.poppins(
//                                                       textStyle: TextStyle()))),
//                                           SingleChildScrollView(
//                                             child: Container(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height /
//                                                   2,
//                                               child: ListView.builder(
//                                                   itemCount: lumpsumList.length,
//                                                   itemBuilder:
//                                                       (context, index) {
//                                                     return LayoutBuilder(
//                                                         builder: (context,
//                                                             constraints) {
//                                                       if (lumpsumList[index]
//                                                                   .name ==
//                                                               "$selectedGrade $selectedSize" &&
//                                                           int.parse(lumpsumList[
//                                                                       index]
//                                                                   .qty!) >
//                                                               int.parse(
//                                                                   qty.text)) {
//                                                         return Container(
//                                                             margin:
//                                                                 EdgeInsets.only(
//                                                                     top: 10),
//                                                             child: InkWell(
//                                                               onTap: () {
//                                                                 listOfColumns
//                                                                     .add({
//                                                                   "Sr_no": itemNum
//                                                                       .toString(),
//                                                                   "Name": lumpsumList[
//                                                                           index]
//                                                                       .name!,
//                                                                   "Qty":
//                                                                       qty.text,
//                                                                   "Price": selectedTransType ==
//                                                                               "FOR" &&
//                                                                           selectedOrderType !=
//                                                                               "Lump-sum"
//                                                                       ? ((int.parse(lumpsumList[index].price!) + tCost) *
//                                                                               int.parse(qty
//                                                                                   .text))
//                                                                           .toString()
//                                                                       : ((int.parse(lumpsumList[index].price!)) *
//                                                                               int.parse(qty.text))
//                                                                           .toString()
//                                                                 });
//                                                                 lumpsumList[
//                                                                         index]
//                                                                     .qty = (int.parse(lumpsumList[index]
//                                                                             .qty!) -
//                                                                         int.parse(
//                                                                             qty.text))
//                                                                     .toString();
//
//                                                                 reductionData
//                                                                     .add({
//                                                                   "id": lumpsumList[
//                                                                           index]
//                                                                       .id,
//                                                                   "qty": lumpsumList[
//                                                                           index]
//                                                                       .qty
//                                                                 });
//                                                                 itemNum =
//                                                                     itemNum + 1;
//                                                                 setState(() {});
//                                                                 Navigator.pop(
//                                                                     context);
//                                                               },
//                                                               child: Card(
//                                                                 elevation: 15,
//                                                                 child: InventoryCard(
//                                                                     context,
//                                                                     lumpsumList[
//                                                                         index]),
//                                                               ),
//                                                             ));
//                                                       } else {
//                                                         return Container();
//                                                       }
//                                                     });
//                                                   }),
//                                             ),
//                                           )
//                                         ],
//                                       )),
//                                 );
//                               },
//                             );
//                           }
//                         },
//                         child: const Text(
//                           "Add Item",
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.w500),
//                         )),
//                   ],
//                 ),
//               ),
//               LayoutBuilder(builder: (context, constraints) {
//                 return Text(
//                   "*Transportaion Cost Are Included",
//                   style: TextStyle(color: Colors.red),
//                 );
//               }),
//
//               //-----------------------DataTable--------------------------------
//
//               Card(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 250,
//                         width: MediaQuery.of(context).size.width,
//                         margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           // borderRadius: BorderRadius.circular(20)
//                         ),
//                         child: SingleChildScrollView(
//                           child: DataTable(
//                             border: TableBorder.all(
//                                 width: 1, color: Colors.black26),
//                             columnSpacing:
//                                 MediaQuery.of(context).size.width / 20,
//                             //border: TableBorder.all(borderRadius: BorderRadius.circular(20)),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20)),
//
//                             columns: const [
//                               DataColumn(
//                                   label: Expanded(
//                                     child: Text(
//                                       'Sr\nNo',
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   numeric: true),
//                               DataColumn(
//                                   label: Expanded(
//                                 child: Text(
//                                   'HSN/Name',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               )),
//                               DataColumn(
//                                   label: Expanded(
//                                 child: Text(
//                                   'Quantity\n(Tons)',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               )),
//                               DataColumn(
//                                   label: Expanded(
//                                 child: Text(
//                                   'Price',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               )),
//                               DataColumn(label: Text(' '))
//                             ],
//                             rows:
//                                 listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
//                                     .map(
//                               (element) {
//                                 int i;
//
//                                 for (i = 0; i < listOfColumns.length; i++) {
//                                   if (listOfColumns.elementAt(i)["Name"] ==
//                                       element["Name"]!) {
//                                     break;
//                                   }
//                                 }
//
//                                 //listOfColumns.indexWhere((element) => false);
//                                 return DataRow(
//                                   cells: <DataCell>[
//                                     DataCell(Align(
//                                       child: Text((i + 1).toString()),
//                                       alignment: Alignment.center,
//                                     )), //Extracting from Map element the value
//                                     DataCell(Text(element["Name"]!)),
//                                     DataCell(Align(
//                                         child: Text(element["Qty"]!),
//                                         alignment: Alignment.center)),
//                                     DataCell(Align(
//                                         child: Container(
//                                           child: Text(element["Price"]!),
//                                           width: 70,
//                                         ),
//                                         alignment: Alignment.center)),
//                                     DataCell(Container(
//                                       child: IconButton(
//                                         icon: Icon(Icons.delete_rounded,
//                                             color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             listOfColumns.remove(element);
//                                             totalQuantity = totalQuantity -
//                                                 int.parse(element["Qty"]!);
//                                           });
//                                         },
//                                       ),
//                                       width: 25,
//                                     )),
//
//                                     // DataCell(Icon(element["Action"]!))
//                                   ],
//                                 );
//                               },
//                             ).toList(),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         child: Container(
//                             child: Text("Total = $totalQuantity Tons",
//                                 style: TextStyle(
//                                     color: Colors.lightBlueAccent,
//                                     fontWeight: FontWeight.w700)),
//                             margin: EdgeInsets.fromLTRB(0, 10, 10, 10)),
//                         alignment: Alignment.center,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   width: MediaQuery.of(context).size.width,
//                   child: buttonStyle("Submit", () {
//                     if (_formKey.currentState!.validate()) {
//                       onPlaceOrder();
//                     }
//                   }))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/ui/cards.dart';
import '../Models/grade.dart';
import '../Models/lumpsum.dart';
import '../Models/region.dart';
import '../Models/size.dart';
import '../ui/common.dart';

class PlaceOrderPage extends StatelessWidget {
  const PlaceOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceOrderContent();
  }
}

class PlaceOrderContent extends StatefulWidget {
  const PlaceOrderContent({super.key});
  final selected = 0;
  @override
  State<PlaceOrderContent> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderContent> {
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
  final field1Key = GlobalKey<FormFieldState>();
  final field2Key = GlobalKey<FormFieldState>();
  final field3Key = GlobalKey<FormFieldState>();
  final field4Key = GlobalKey<FormFieldState>();
  final field5Key = GlobalKey<FormFieldState>();
  final field6Key = GlobalKey<FormFieldState>();
  final field8Key = GlobalKey<FormFieldState>();
  final field7Key = GlobalKey<FormFieldState>();
  final field9Key = GlobalKey<FormFieldState>();

  var user_type;
  void loadusertype() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user_type = await prefs.getString('userType');
  }

  String isItem = " ";

  @override
  Widget build(BuildContext context) {
    loadusertype();

    return Scaffold(
      appBar: appbar("Place Order", () {
        Navigator.pop(context);
      }),
      body: PlaceOrderBody(),
    );
  }

  String? id, supplier_id;
  var f1 = 0;
  Future<void> loadData() async {
    if(f1==0){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      id = await prefs.getString('id');
      supplier_id = await prefs.getString('parentId');
      if(user_type == "Builder"){
        selectedOrderType = "With Size";
        selectedTransType = "None";
        selectedType = "None";

      }
      f1=1;
      setState(() {});
    }
    //print("is setstate on loop");
  }

  String?
  // selectedValue,
  selectedSize,
      selectedGrade,
      selectedType,
      selectedRegion,
      selectedTransType,
      selectedOrderType;
  TextEditingController qty = TextEditingController();
  TextEditingController party_name = TextEditingController();
  TextEditingController party_address = TextEditingController();
  TextEditingController party_pan_no = TextEditingController();
  TextEditingController party_mob_num = TextEditingController();
  TextEditingController loading_type = TextEditingController();
  TextEditingController base_price = TextEditingController();
  List<Lumpsum> lumpsumList = [];
  bool isInventoryDataLoaded= false;
  loadLumpsumData() async {
    print("inLoadLumpsumData");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user_id = await prefs.getString('id');

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
      Lumpsum l = Lumpsum();
      l.orderId = responseData["data"][i]["order_id"];
      l.name = responseData["data"][i]["name"];
      l.qty = responseData["data"][i]["qty_left"];
      l.price = responseData["data"][i]["price"];
      l.status = responseData["data"][i]["status"];
      l.id = responseData['data'][i]["ls_id"];
      l.date = responseData["data"][i]["createdAt"];
      lumpsumList.add(l);
    }
    isInventoryDataLoaded = true;
    setState(() {});
  }


  @override
  void initState() {
    loadLumpsumData();
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
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    focusNode7.dispose();
    focusNode8.dispose();
    focusNode9.dispose();
    super.dispose();
  }

  // List items = ["TMT"];
  List grades = [];
  List sizes = [];
  List regions = [];
  List<Grade> gradeList = [];
  List<Region> regionList = [];
  List<ItemSize> sizeList = [];
  var f = 0;
  loadItemData() async {
    if(f==0){
      f=1;
      var res = await http.post(Uri.parse("http://urbanwebmobile.in/steffo/getsize.php"));
      var responseData = jsonDecode(res.body);
      for(int i  = 0 ; i < responseData['data'].length;i++){
        sizes.add(responseData['data'][i]["sizeValue"].toString());
        ItemSize s = ItemSize();
        s.price = responseData['data'][i]["sizePrice"];
        s.value = responseData['data'][i]["sizeValue"];
        sizeList.add(s);
      }

      var res1 = await http.post(Uri.parse("http://urbanwebmobile.in/steffo/getgrade.php"));
      var responseData1 = jsonDecode(res1.body);
      for(int i  = 0 ; i < responseData1['data'].length;i++){
        print(responseData1['data'][i]);
        grades.add(responseData1['data'][i]["gradeName"]);
        Grade s = Grade();
        s.price = responseData1['data'][i]["gradePrice"];
        s.value = responseData1['data'][i]["gradeName"];
        gradeList.add(s);
      }

      var res2 = await http.post(Uri.parse("http://urbanwebmobile.in/steffo/getregions.php"));
      var responseData2 = jsonDecode(res2.body);
      for(int i  = 0 ; i < responseData2['data'].length;i++){
        print(responseData2['data'][i]);
        regions.add(responseData2['data'][i]["regionName"]);
        Region r = Region();
        r.name = responseData2['data'][i]["regionName"];
        r.cost = responseData2['data'][i]["tCost"];
        regionList.add(r);
      }
      setState(() {

      });
    }
  }


  List type = ["Loose", "Bhari"];
  List transType = ["CIF", "FOB"];
  List orderType = ["Lump-sum", "With Size","Use Lumpsum"];

  int itemNum = 1;
  int totalQuantity = 0;

  final List<Map<String, String>> listOfColumns = [];
  onPlaceOrder() async {
    if(selectedOrderType == "Use Lumpsum"){
      for(int  i = 0 ; i < reductionData.length ; i++){
        var res = await http.post(
            Uri.parse("http://urbanwebmobile.in/steffo/updateinventory.php"),
            body: {
              "id": reductionData[i]["id"],
              "qty": reductionData[i]["qty"]
            }
        );
      }
    }
    var res = await http.post(
      Uri.parse("http://urbanwebmobile.in/steffo/placeorder.php"),
      body: selectedOrderType == "Lump-sum"
          ? {
        "userId": id!,
        "supplierId": supplier_id!,
        "shippingAddress": party_address.text,
        "partyName": party_name.text,
        "gstNumber": party_pan_no.text,
        "mobileNumber": party_mob_num.text,
        "basePrice": base_price.text,
        "status": "Pending",
        "loadingType": "None",
        "transportationType": "None",
        "orderType": selectedOrderType
      }
          : {
        "userId": id!,
        "supplierId": supplier_id!,
        "shippingAddress": party_address.text,
        "partyName": party_name.text,
        "gstNumber": party_pan_no.text,
        "mobileNumber": party_mob_num.text,
        "basePrice": base_price.text,
        "status": "Pending",
        "loadingType": selectedType,
        "orderType": selectedOrderType,
        "transportationType": selectedTransType
      },
    );
    Fluttertoast.showToast(
        msg: 'Your Order Is Placed',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white);
    Navigator.of(context).pushNamed("/home");

    var responseData = json.decode(res.body);
    print(responseData["value"].toString());

    if (responseData["status"] == '200' && selectedOrderType != "Lump-sum") {
      for (int i = 0; i < listOfColumns.length; i++) {
        http.post(
          Uri.parse("http://urbanwebmobile.in/steffo/setorder.php"),
          body: {
            "order_id": responseData["value"].toString(),
            "name": listOfColumns[i]["Name"],
            "qty": listOfColumns[i]["Qty"],
            "price": listOfColumns[i]["Price"]
          },
        );
      }
    } else {
      for (int i = 0; i < listOfColumns.length; i++) {
        http.post(
          Uri.parse("http://urbanwebmobile.in/steffo/addlumpsum.php"),
          body: {
            "order_id": responseData["value"].toString(),
            "name": listOfColumns[i]["Name"],
            "qty": listOfColumns[i]["Qty"],
            "price": listOfColumns[i]["Price"]
          },
        );
      }
    }
    // print(listOfColumns[0]['Name']);

  }

  num tCost = 0;
  var reductionData =[];
  Widget PlaceOrderBody() {
    loadItemData();
    // List<DropdownMenuItem<String>> dropdownItems = [];
    List<DropdownMenuItem<String>> dropdownGrades = [];
    List<DropdownMenuItem<String>> dropdownSize = [];
    List<DropdownMenuItem<String>> dropdownType = [];
    List<DropdownMenuItem<String>> dropdownRegion = [];
    List<DropdownMenuItem<String>> dropdownTransType = [];
    List<DropdownMenuItem<String>> dropdownOrderType = [];
    // List<DropdownMenuItem<String>> getItems() {
    //   for (int i = 0; i < items.length; i++) {
    //     DropdownMenuItem<String> it = DropdownMenuItem(
    //       value: items[i],
    //       child: Text(items[i]),
    //     );
    //     dropdownItems.add(it);
    //   }
    //   return dropdownItems;
    // }

    List<DropdownMenuItem<String>> getGrade() {
      for (int i = 0; i < grades.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: grades[i],
          child: Text(grades[i]),
        );
        dropdownGrades.add(it);
      }

      return dropdownGrades;
    }

    List<DropdownMenuItem<String>> getSize() {
      for (int i = 0; i < sizes.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: sizes[i],
          child: Text(sizes[i]),
        );
        dropdownSize.add(it);
      }
      return dropdownSize;
    }

    List<DropdownMenuItem<String>> getRegion() {
      for (int i = 0; i < regions.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: regions[i],
          child: Text(regions[i]),
        );
        dropdownRegion.add(it);
      }
      return dropdownRegion;
    }

    List<DropdownMenuItem<String>> getType() {
      for (int i = 0; i < type.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: type[i],
          child: Text(type[i]),
        );
        dropdownType.add(it);
      }
      return dropdownType;
    }

    List<DropdownMenuItem<String>> getTransType() {
      for (int i = 0; i < transType.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: transType[i],
          child: Text(transType[i]),
        );
        dropdownTransType.add(it);
      }
      return dropdownTransType;
    }

    List<DropdownMenuItem<String>> getOrderType() {
      for (int i = 0; i < orderType.length; i++) {
        DropdownMenuItem<String> it = DropdownMenuItem(
          value: orderType[i],
          child: Text(orderType[i]),
        );
        dropdownOrderType.add(it);
      }
      return dropdownOrderType;
    }

    loadData();

    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //
          //     transform: GradientRotation(1.07),
          //     colors: [
          //       Color.fromRGBO(75, 100, 160, 1.0),
          //       Color.fromRGBO(19, 59, 78, 1.0),
          //     ]
          //
          // )
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //-----------------------Name-------------------------------------
              Container(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: TextFormField(
                  key: field1Key,
                  focusNode: focusNode1,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please enter a Name.';
                    }
                    return null;
                  },
                  controller: party_name,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromRGBO(233, 236, 239,
                          0.792156862745098) //Color.fromRGBO(233, 236, 239, 0.792156862745098)

                  ),
                ),
              ),
              //----------------------------Shipping Address--------------------
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  key: field2Key,
                  focusNode: focusNode2,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'Please enter an Address.';
                    }
                    return null;
                  },
                  controller: party_address,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      labelText: "Shipping Address",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromRGBO(233, 236, 239,
                          0.792156862745098) //Color.fromRGBO(233, 236, 239, 0.792156862745098)

                  ),
                ),
              ),
              //-------------------------------Region---------------------------

              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                        hintText: "Select Region of Delivery",
                        filled: true,
                        fillColor: Color.fromRGBO(
                            233, 236, 239, 0.792156862745098),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          // borderRadius: BorderRadius.circular(20)
                        )),
                    value: selectedRegion,
                    items: getRegion(),
                    onChanged: (String? newValue) {
                      selectedRegion = newValue;
                      var ind = regions.indexOf(selectedRegion);
                      tCost = int.parse(regionList[ind].cost!);
                    },
                    validator: (selectedValue) {
                      if (selectedValue == null) {
                        // return 'Please select a value.';
                      }
                      return null;
                    },
                  )
              ),

              //-----------------------------GST Number-------------------------

              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  key: field3Key,
                  focusNode: focusNode3,
                  controller: party_pan_no,
                  maxLines: 1,
                  maxLength: 15,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value.';
                    } else if (value.length < 15) {
                      return 'Please Enter Valid Number';
                    }
                    if (value.length > 15) {
                      return 'Please Enter Valid Number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "GST Number",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: const Color.fromRGBO(233, 236, 239,
                          0.792156862745098) //Color.fromRGBO(233, 236, 239, 0.792156862745098)

                  ),
                ),
              ),

              //----------------------------Contact Number----------------------

              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  key: field4Key,
                  focusNode: focusNode4,
                  controller: party_mob_num,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Number.';
                    } else if (value.length < 10) {
                      return 'Please Enter Valid Number';
                    }
                    if (value.length > 10) {
                      return 'Please Enter Valid Number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Contact Number",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color.fromRGBO(233, 236, 239,
                          0.792156862745098) // Color.fromRGBO(233, 236, 239, 0.792156862745098)
                  ),
                ),
              ),

              LayoutBuilder(builder: (context, constraints) {
                if (user_type == "Distributor" || user_type == "Dealer") {
                  return Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            hintText: "Select Order Type",
                            filled: true,
                            fillColor: Color.fromRGBO(
                                233, 236, 239, 0.792156862745098),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              // borderRadius: BorderRadius.circular(20)
                            )),
                        value: selectedOrderType,
                        items: getOrderType(),
                        onChanged: (String? newValue) {
                          selectedOrderType = newValue;
                          if(selectedOrderType == "Lump-sum"){
                            selectedTransType = "None";
                          }
                        },
                        // key: field5Key,
                        // focusNode: focusNode5,
                        validator: (selectedValue) {
                          if (selectedValue == null) {
                            return 'Please select a value.';
                          }
                          return null;
                        },
                      ));
                } else {
                  return Container();
                }
              }),

              //--------------------------Loading Type--------------------------

              LayoutBuilder(builder: (context, constraints) {
                if (selectedOrderType != "Lump-sum" && (user_type == "Dealer" || user_type == "Distributor")) {
                  return Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                hintText: "Select Loading Type",
                                filled: true,
                                fillColor: Color.fromRGBO(
                                    233, 236, 239, 0.792156862745098),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  // borderRadius: BorderRadius.circular(20)
                                )),
                            value: selectedType,
                            items: getType(),
                            onChanged: (String? newValue) {
                              selectedType = newValue;
                            },
                            key: field5Key,
                            focusNode: focusNode5,
                            validator: (selectedValue) {
                              if (selectedValue == null) {
                                //return 'Please select a value.';
                              }
                              return null;
                            },
                          )),
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                hintText: "Select Transportation Type",
                                filled: true,
                                fillColor: Color.fromRGBO(
                                    233, 236, 239, 0.792156862745098),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  // borderRadius: BorderRadius.circular(20)
                                )),
                            value: selectedTransType,
                            items: getTransType(),
                            onChanged: (String? newValue) {
                              selectedTransType = newValue;
                            },
                            // key: field5Key,
                            // focusNode: focusNode5,
                            validator: (selectedValue) {
                              if (selectedValue == null) {
                                return 'Please select a value.';
                              }
                              return null;
                            },
                          ))

                    ],
                  );
                } else {
                  return Container();
                }
              }),

              // Container(
              //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              //   child: TextFormField(
              //     key: field5Key,
              //     focusNode: focusNode5,
              //     controller: loading_type,
              //     maxLines: 1,
              //     validator: (value) {
              //       if (value!.isEmpty || value == null) {
              //         return 'Please enter a value.';
              //       }
              //       return null;
              //     },
              //     decoration: const InputDecoration(
              //         labelText: "Loading Type",
              //         floatingLabelBehavior: FloatingLabelBehavior.never,
              //         border: OutlineInputBorder(
              //             // borderRadius: BorderRadius.circular(20),
              //             borderSide: BorderSide.none),
              //         filled: true,
              //         fillColor: Color.fromRGBO(233, 236, 239,
              //             0.792156862745098) // Color.fromRGBO(233, 236, 239, 0.792156862745098)
              //
              //         ),
              //   ),
              // ),

              //------------------------------BasePrice--------------------------

              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  key: field6Key,
                  focusNode: focusNode6,
                  controller: base_price,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Base Price",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor:
                      Color.fromRGBO(233, 236, 239, 0.792156862745098)
                  ),
                ),
              ),

              //-------------------Add Item Block-------------------------------

              Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: const BoxDecoration(
                  // color: Colors.white, borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    // Container(
                    //     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    //     child: DropdownButtonFormField(
                    //       decoration: const InputDecoration(
                    //           hintText: "Select The Product",
                    //           filled: true,
                    //           fillColor: Color.fromRGBO(
                    //               233, 236, 239, 0.792156862745098),
                    //           border: OutlineInputBorder(
                    //             borderSide: BorderSide.none,
                    //             // borderRadius: BorderRadius.circular(20)
                    //           )),
                    //       value: selectedValue,
                    //       items: getItems(),
                    //       onChanged: (String? newValue) {
                    //         selectedValue = newValue;
                    //       },
                    //       key: field9Key,
                    //       focusNode: focusNode9,
                    //       validator: (selectedValue) {
                    //         if (selectedValue == null) {
                    //           return 'Please select a value.';
                    //         }
                    //         return null;
                    //       },
                    //     )),
                    Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              hintText: "Select The Grade",
                              filled: true,
                              fillColor: Color.fromRGBO(
                                  233, 236, 239, 0.792156862745098),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                // borderRadius: BorderRadius.circular(20)
                              )),
                          value: selectedGrade,
                          items: getGrade(),
                          onChanged: (String? newValue) {
                            selectedGrade = newValue;
                          },
                          key: field8Key,
                          focusNode: focusNode8,
                          validator: (selectedValue) {
                            if (selectedValue == null) {
                              // return 'Please select a value.';
                            }
                            return null;
                          },
                        )),
                    LayoutBuilder(builder: (context, constraints) {
                      if (selectedOrderType == "With Size") {
                        if (selectedSize == " ") {
                          selectedSize = null;
                        }
                        return Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  hintText: "Select The Size",
                                  filled: true,
                                  fillColor: Color.fromRGBO(
                                      233, 236, 239, 0.792156862745098),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    // borderRadius: BorderRadius.circular(20)
                                  )),
                              value: selectedSize,
                              items: getSize(),
                              onChanged: (String? newValue) {
                                selectedSize = newValue;
                              },
                              key: field7Key,
                              focusNode: focusNode7,
                              validator: (selectedValue) {
                                if (selectedValue == null) {
                                  // return 'Please select a value.';
                                }
                                return null;
                              },
                            ));
                      } else {
                        selectedSize = " ";
                        return Container();
                      }
                    }),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: TextFormField(
                        maxLines: 1,
                        controller: qty,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Quantity",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Color.fromRGBO(233, 236, 239,
                              0.792156862745098), //Color.fromRGBO(233, 236, 239, 0.792156862745098)
                        ),
                      ),
                    ),
                    Center(
                      child: Text(isItem, style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              // borderRadius: BorderRadius.circular(20),
                                side: BorderSide.none),
                            minimumSize: const Size(190, 40)),
                        onPressed: () {
                          var grdpct,szpct = 0;
                          if(selectedOrderType != "Use Lumpsum"){
                            if (selectedGrade != null &&
                                selectedSize != null &&
                                qty.text != "" &&
                                base_price.text != "" &&
                                selectedRegion != null &&
                                selectedTransType != null) {
                              for (int i = 0; i < gradeList.length; i++) {
                                if (gradeList[i].value == selectedGrade) {
                                  grdpct = int.parse(gradeList[i].price!);
                                }
                              }
                              for (int i = 0; i < sizeList.length; i++) {
                                if (sizeList[i].value == selectedSize) {
                                  szpct = int.parse(sizeList[i].price!);
                                }
                              }
                              setState(() {
                                isItem = " ";
                                int f = 0;
                                for (int i = 0; i < listOfColumns.length; i++) {
                                  if (listOfColumns.elementAt(i)["Name"]! ==
                                      // "$selectedValue"
                                      "$selectedGrade $selectedSize") {
                                    int quty = int.parse(
                                        listOfColumns.elementAt(i)["Qty"]!);
                                    quty = quty + int.parse(qty.text);
                                    num p = selectedTransType == "CIF" &&
                                        selectedOrderType != "Lump-sum"
                                        ? (int.parse(base_price.text) +
                                        grdpct +
                                        szpct +
                                        tCost) *
                                        quty
                                        : (int.parse(base_price.text) +
                                        grdpct +
                                        szpct +
                                        0) *
                                        quty;

                                    listOfColumns.elementAt(i)["Qty"] =
                                        quty.toString();
                                    listOfColumns.elementAt(i)["Price"] =
                                        p.toString();
                                    f = 1;
                                  }
                                }
                                if (f == 0) {
                                  listOfColumns.add({
                                    "Sr_no": itemNum.toString(),
                                    "Name": "$selectedGrade $selectedSize",
                                    "Qty": qty.text,
                                    "Price": selectedTransType == "CIF" &&
                                        selectedOrderType != "Lump-sum"
                                        ? ((int.parse(base_price.text) +
                                        grdpct +
                                        szpct +
                                        tCost) *
                                        int.parse(qty.text))
                                        .toString()
                                        : ((int.parse(base_price.text) +
                                        grdpct +
                                        szpct +
                                        0) *
                                        int.parse(qty.text))
                                        .toString()
                                  });
                                  itemNum = itemNum + 1;
                                }
                              });
                              totalQuantity =
                                  totalQuantity + int.parse(qty.text);
                              //print(totalQuantity);
                            } else {
                              isItem = "Please Enter All of the above fields";
                              setState(() {});
                            }
                          }else{
                            showDialog (
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 16,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      //height: 400,
                                      child: Column(
                                        children: [
                                          Container(child: Text("Select The Lumpsum",style: GoogleFonts.poppins(textStyle: TextStyle()))),
                                          SingleChildScrollView(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/2,
                                              child: ListView.builder(
                                                  itemCount: lumpsumList.length,
                                                  itemBuilder: (context,index){
                                                    return LayoutBuilder(
                                                        builder: (context,constraints) {
                                                          if(lumpsumList[index].name == "$selectedGrade $selectedSize" && int.parse(lumpsumList[index].qty!) > int.parse(qty.text)){
                                                            return Container(
                                                                margin: EdgeInsets.only(top: 10),
                                                                child: InkWell(
                                                                  onTap: (){
                                                                    listOfColumns.add({
                                                                      "Sr_no": itemNum.toString(),
                                                                      "Name": lumpsumList[index].name!,
                                                                      "Qty": qty.text,
                                                                      "Price": selectedTransType == "CIF" &&
                                                                          selectedOrderType != "Lump-sum"
                                                                          ? ((int.parse(lumpsumList[index].price!)+tCost) *
                                                                          int.parse(qty.text))
                                                                          .toString()
                                                                          : ((int.parse(lumpsumList[index].price!)) *
                                                                          int.parse(qty.text))
                                                                          .toString()
                                                                    });
                                                                    lumpsumList[index].qty = (int.parse(lumpsumList[index].qty!) - int.parse(qty.text)).toString();

                                                                    reductionData.add({
                                                                      "id": lumpsumList[index].id,
                                                                      "qty": lumpsumList[index].qty
                                                                    });
                                                                    itemNum = itemNum + 1;
                                                                    setState(() {

                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: Card(
                                                                    elevation: 15,
                                                                    child: InventoryCard(context, lumpsumList[index]),
                                                                  ),
                                                                ));
                                                          }else{
                                                            return Container();
                                                          }
                                                        }
                                                    );
                                                  }),
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: const Text("Add Item")
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                  builder: (context,constraints) {
                    return Text("*Transportaion Cost Are Included",style: TextStyle(color: Colors.red),);
                  }
              ),


              //-----------------------DataTable--------------------------------

              Card(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(20)
                        ),
                        child: SingleChildScrollView(
                          child: DataTable(
                            border: TableBorder.all(
                                width: 1, color: Colors.black26),
                            columnSpacing:
                            MediaQuery.of(context).size.width / 20,
                            //border: TableBorder.all(borderRadius: BorderRadius.circular(20)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),

                            columns: const [
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Sr\nNo',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  numeric: true),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'HSN/Name',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Quantity\n(Tons)',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Price',
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                              DataColumn(label: Text(' '))
                            ],
                            rows:
                            listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                                .map(
                                  (element) {
                                int i;

                                for (i = 0; i < listOfColumns.length; i++) {
                                  if (listOfColumns.elementAt(i)["Name"] ==
                                      element["Name"]!) {
                                    break;
                                  }
                                }

                                //listOfColumns.indexWhere((element) => false);
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Align(
                                      child: Text((i + 1).toString()),
                                      alignment: Alignment.center,
                                    )), //Extracting from Map element the value
                                    DataCell(Text(element["Name"]!)),
                                    DataCell(Align(
                                        child: Text(element["Qty"]!),
                                        alignment: Alignment.center)),
                                    DataCell(Align(
                                        child: Container(
                                          child: Text(element["Price"]!),
                                          width: 70,
                                        ),
                                        alignment: Alignment.center)),
                                    DataCell(Container(
                                      child: IconButton(
                                        icon: Icon(Icons.delete_rounded,
                                            color: Colors.red),
                                        onPressed: () {
                                          setState(() {
                                            listOfColumns.remove(element);
                                            totalQuantity = totalQuantity -
                                                int.parse(element["Qty"]!);
                                          });
                                        },
                                      ),
                                      width: 25,
                                    )),

                                    // DataCell(Icon(element["Action"]!))
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                            child: Text("Total = $totalQuantity Tons",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700)),
                            margin: EdgeInsets.fromLTRB(0, 10, 10, 10)),
                        alignment: Alignment.bottomRight,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: buttonStyle("Submit", () {
                    if (_formKey.currentState!.validate()) {
                      onPlaceOrder();
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}

