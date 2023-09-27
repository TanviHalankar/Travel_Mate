// import 'dart:math';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ttravel_mate/screens/navigation/user_profile.dart';
//
//
// class HomePage extends StatefulWidget {
//   HomePage() : super();
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     TabController _tabController = TabController(length: 3, vsync: this);
//     return Scaffold(
//       //backgroundColor: Colors.transparent,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.person,size: 40),
//                     color: Colors.green[100],
//                     onPressed: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(),));
//                     },
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     "SEE WHAT'S TRENDING",
//                     style: GoogleFonts.montserrat(
//                       fontSize: 15,
//                       color: Colors.green[500],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               CarouselSlider(
//                 options: CarouselOptions(
//                   autoPlay: true,
//                   height: 250.0,
//                   enlargeCenterPage: true,
//                 ),
//                 items: [
//                   //image 1
//                   Stack(
//                     children: [
//                       Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                                 opacity: 100.0,
//                                 image: AssetImage('assets/beach.png'),
//                                 fit: BoxFit.cover)),
//                       ),
//                       Positioned(
//                         left: 30,
//                         top: 130,
//                         child: Container(
//                           child:Padding(
//                             padding: const EdgeInsets.only(left: 8,top: 8),
//                             child: Text('Mumbai',style: GoogleFonts.montserrat(fontSize: 10,color: Colors.black)),
//                           ),
//                           height: 100,
//                           width: 210,
//                           decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(8),
//                             boxShadow: [
//                               BoxShadow(offset: Offset.fromDirection(2),color: Colors.grey,spreadRadius: 2,blurRadius: 3)
//                             ]
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//
//               Row(
//                 children: [
//                   RotatedBox(
//                     quarterTurns: 3,
//                     child: SizedBox(
//                       height: 80,
//                       width: 300,
//                       child: TabBar(
//                         controller: _tabController,
//                         indicatorColor: Colors.grey,
//                         labelColor: Colors.white,
//                         unselectedLabelColor: Colors.grey,
//                         indicator: BoxDecoration(
//                             color: Colors.green[200],
//                             borderRadius: BorderRadius.circular(10)),
//                         indicatorPadding:
//                             const EdgeInsets.only(top: 10, bottom: 10),
//                         //indicator: CircleTabIndicator(color:Colors.grey,radius:4),
//                         labelPadding: const EdgeInsets.only(left: 5, right: 5),
//                         tabs: const [
//                           RotatedBox(
//                               quarterTurns: 1,
//                               child: Tab(
//                                   icon: Icon(Icons.wallet_travel),
//                                   text: 'Short')),
//                           RotatedBox(
//                               quarterTurns: 1,
//                               child: Tab(
//                                   icon: Icon(Icons.mood_outlined),
//                                   text: 'Category')),
//                           RotatedBox(
//                               quarterTurns: 1,
//                               child: Tab(
//                                   icon: Icon(Icons.sunny_snowing),
//                                   text: 'Season')),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: Container(
//                       color: Colors.grey.withOpacity(0.1),
//                       width: double.maxFinite,
//                       height: 350,
//                       child: TabBarView(
//                         controller: _tabController,
//                         children: [
//                           Container(
//                             height: 756.0,
//                             width: 1070,
//                             color: Colors.transparent,
//                             child: ListView(
//                               scrollDirection: Axis.vertical,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(12),
//                                         child: Image.asset('assets/beach.png'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                               child: Image.asset(
//                                                   'assets/friends.png')),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                               child: Image.asset(
//                                                   'assets/iti.png')),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 756.0,
//                             width: 1070,
//                             color: Colors.transparent,
//                             child: ListView(
//                               scrollDirection: Axis.vertical,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             child:
//                                                 Image.asset('assets/beach.png'),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                               child: Image.asset(
//                                                   'assets/beach.png')),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 756.0,
//                             width: 1070,
//                             color: Colors.transparent,
//                             child: ListView(
//                               scrollDirection: Axis.vertical,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             child:
//                                                 Image.asset('assets/beach.png'),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                               child: Image.asset(
//                                                   'assets/beach.png')),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: InkWell(
//                                     onTap: () {},
//                                     child: Container(
//                                       padding: EdgeInsets.all(20.0),
//                                       width: 200,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: Colors.black12,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                               child: Image.asset(
//                                                   'assets/beach.png')),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
