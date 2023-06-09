// import 'dart:async';

// import 'package:flutter/material.dart';

// class CarouselSlider extends StatefulWidget {
//   const CarouselSlider({Key? key}) : super(key: key);

//   @override
//   State<CarouselSlider> createState() => _CarouselSliderState();
// }

// class _CarouselSliderState extends State<CarouselSlider> {
//   late final PageController pageController;
//   int currentpage = 0;

//   late final Timer carouselTimer;

//   Timer getTimer() {
//     return Timer.periodic(Duration(seconds: 3), (timer) {
//       if (currentpage == 6) {
//         currentpage = 0;
//       }
//       pageController.animateToPage(
//         currentpage,
//         duration: Duration(seconds: 1),
//         curve: Curves.easeInOutCirc,
//       );
//       currentpage++;
//     });
//   }

//   @override
//   void initState() {
//     pageController = PageController(initialPage: 0, viewportFraction: 0.85);
//     carouselTimer = getTimer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 200,
//           child: PageView.builder(
//               itemCount: serviceslist.length,
//               controller: pageController,
//               onPageChanged: (value) {
//                 setState(() {
//                   currentpage = value;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return AnimatedBuilder(
//                   animation: pageController,
//                   builder: (context, child) {
//                     return child!;
//                   },
//                   child: InkWell(
//                     onTap: () {
//                       print('on tap to navigate');
//                     },
//                     child: Stack(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(right: 15),
//                           height: 180,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: serviceslist[index].colors,
//                           ),
//                         ),
//                         Positioned(
//                             right: 15,
//                             child: Container(
//                               width: 150,
//                               height: 180,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(20),
//                                       bottomRight: Radius.circular(20)),
//                                   image: DecorationImage(
//                                     image:
//                                         AssetImage(serviceslist[index].image),
//                                     fit: BoxFit.cover,
//                                   )),
//                             )),
//                         Positioned(
//                           left: 10,
//                           top: 10,
//                           child: Text(
//                             serviceslist[index].title,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 20,
//                           top: 80,
//                           child: Text(
//                             serviceslist[index].text,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             left: 20,
//                             top: 120,
//                             child: Container(
//                               width: 90,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: kgridcolor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   padding: EdgeInsets.zero,
//                                   backgroundColor: kgridcolor.withOpacity(0.5),
//                                   elevation: 0,
//                                 ),
//                                 onPressed: () {},
//                                 child: Text(
//                                   serviceslist[index].button,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ),
//                             ))
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         ),
//         SizedBox(height: 10),
//         Container(
//           height: 5,
//           width: 62,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Color(0xFF979797).withOpacity(0.1),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ...List.generate(
//                 serviceslist.length,
//                 (index) => buildDots1(index: index),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   AnimatedContainer buildDots1({int? index}) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       // margin: EdgeInsets.only(right: 5),
//       height: 19,
//       width: currentpage == index ? 20 : 6,
//       decoration: BoxDecoration(
//         color: currentpage == index
//             ? Colors.black.withOpacity(0.6)
//             : Color(0xFF979797).withOpacity(0.1),
//       ),
//     );
//   }
// }
