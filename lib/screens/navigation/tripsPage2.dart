import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart' as c;
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../db_info.dart';
import '../../model/trips.dart';
import '../Create Trip/create_trip.dart';
import '../Create Trip/view_trip.dart';
import '../search2.dart';

class TripsPage2 extends StatefulWidget {
  String name;
  TripsPage2({Key? key,required this.name}) : super(key: key);

  @override
  State<TripsPage2> createState() => _TripsPage2State();
}

class _TripsPage2State extends State<TripsPage2> {
  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();
  late Future<List<Trips>> futureTrips;

  Future<List<Trips>> fetchTripsByTitle(String title) async {
    final response = await http.get(Uri.parse('http://$ip:9000/trips/title/$title'));
    if (response.statusCode == 200) {
      final List<dynamic> tripList = json.decode(response.body);
      return tripList.map((tripData) => Trips.fromJson(tripData)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTrips = fetchTripsByTitle(widget.name);
  }
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Trips>>(
          future: futureTrips,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return
                Center(
                  child: Lottie.asset(
                    'assets/lottie/loading_animation.json', // replace with your Lottie animation file
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
            } else if (snapshot.hasError) {
              return Center(child: Text('No trips availabe'),);
            } else {
              List<Trips> trips = snapshot.data ?? [];
              return Column(
                children: [
                  // Container(
                  //   width: double.maxFinite,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //           style: BorderStyle.solid, color: Colors.orange.withOpacity(0.2))),
                  //   child: OutlinedButton(
                  //       style: ButtonStyle(
                  //           backgroundColor:
                  //           MaterialStatePropertyAll(Colors.transparent),
                  //           side: MaterialStatePropertyAll(BorderSide.none)),
                  //       onPressed: () {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTrip(),));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           Icon(LineIcons.plus, size: 15, color: Colors.white.withOpacity(0.7)),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             'CREATE TRIP',
                  //             style: GoogleFonts.montserrat(
                  //                 color: Colors.white.withOpacity(0.7), fontSize: 10),
                  //           ),
                  //         ],
                  //       )),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        Trips trip = trips[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTrip(tripId:trip.tripId,memberId:uid,),));
                                },
                                child: Stack(children: [
                                  Container(
                                    height: 350,
                                    color: Colors.black,
                                  ),
                                  Opacity(
                                    opacity: 0.7,
                                    child: Container(
                                      width: double.maxFinite,
                                      height: 320,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage('http://$ip:9000/${trip.coverPhoto}'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Positioned(
                                      left: 20,
                                      bottom: 60,
                                      child: Container(
                                          width: 250,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                trip.title,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white.withOpacity(0.7)),
                                              ),
                                              SizedBox(height: 10),
                                              Text('${trip.startDate}-${trip.endDate}',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white.withOpacity(0.7))),
                                            ],
                                          ))),
                                  Positioned(
                                      right: 20,
                                      top: 20,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 25,
                                      )),
                                  // Positioned(
                                  //     bottom: -20,
                                  //     left: 20,
                                  //     child: CircleAvatar(backgroundColor: Colors.white)),
                                ]
                                ),
                              )
                              // Container(
                              //   height: 600,
                              //   width: 300,
                              //   child: ListView.builder(
                              //     itemCount: 20, // Replace with the number of items you want
                              //     itemBuilder: (context, index) {
                              //       final double parallaxOffset = 0.5; // Adjust this value for parallax speed
                              //       final double itemHeight = 200.0; // Adjust this value for item height
                              //
                              //       return Container(
                              //         height: itemHeight,
                              //         child: Transform.translate(
                              //           offset: Offset(0.0, index * parallaxOffset * itemHeight),
                              //           child: Card(
                              //             elevation: 4.0,
                              //             margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              //             child: ListTile(
                              //               title: Text('Item $index'),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       // TextField(
        //       //   style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 15),
        //       //   decoration: InputDecoration(
        //       //     border: OutlineInputBorder(
        //       //         borderRadius: BorderRadius.circular(5)),
        //       //     prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
        //       //     hintText: 'Search.....',
        //       //     //labelText: 'Title',
        //       //     hintStyle: GoogleFonts.montserrat(color: Colors.grey),
        //       //   ),
        //       // ),
        //       Container(
        //         width: double.maxFinite,
        //         decoration: BoxDecoration(
        //             border: Border.all(
        //                 style: BorderStyle.solid, color: Colors.orange.withOpacity(0.2))),
        //         child: OutlinedButton(
        //             style: ButtonStyle(
        //                 backgroundColor:
        //                 MaterialStatePropertyAll(Colors.transparent),
        //                 side: MaterialStatePropertyAll(BorderSide.none)),
        //             onPressed: () {
        //               Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTrip(),));
        //             },
        //             child: Row(
        //               children: [
        //                 Icon(LineIcons.plus, size: 15, color: Colors.white.withOpacity(0.7)),
        //                 SizedBox(
        //                   width: 10,
        //                 ),
        //                 Text(
        //                   'CREATE TRIP',
        //                   style: GoogleFonts.montserrat(
        //                       color: Colors.white.withOpacity(0.7), fontSize: 10),
        //                 ),
        //               ],
        //             )),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTrip(),));
        //         },
        //         child: Stack(children: [
        //           Container(
        //             height: 350,
        //             color: Colors.black,
        //           ),
        //           Opacity(
        //             opacity: 0.6,
        //             child: Container(
        //               width: double.maxFinite,
        //               height: 350,
        //               decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                       image: AssetImage('assets/beach.png'),
        //                       fit: BoxFit.cover)),
        //             ),
        //           ),
        //           Positioned(
        //               left: 20,
        //               bottom: 50,
        //               child: Container(
        //                   width: 250,
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text('MAY 05, 2023',
        //                           style: GoogleFonts.montserrat(
        //                               fontSize: 12,
        //                               fontWeight: FontWeight.w500,
        //                               color: Colors.white.withOpacity(0.7))),
        //                       SizedBox(height: 20),
        //                       Text(
        //                         'Riding through the lands of the legends',
        //                         style: GoogleFonts.montserrat(
        //                             fontSize: 20,
        //                             fontWeight: FontWeight.w500,
        //                             color: Colors.white.withOpacity(0.7)),
        //                       ),
        //                     ],
        //                   ))),
        //           Positioned(
        //               right: 20,
        //               top: 20,
        //               child: CircleAvatar(
        //                 backgroundColor: Colors.black,
        //                 radius: 25,
        //               )),
        //           // Positioned(
        //           //     bottom: -20,
        //           //     left: 20,
        //           //     child: CircleAvatar(backgroundColor: Colors.white)),
        //         ]
        //         ),
        //       )
        //       // Container(
        //       //   height: 600,
        //       //   width: 300,
        //       //   child: ListView.builder(
        //       //     itemCount: 20, // Replace with the number of items you want
        //       //     itemBuilder: (context, index) {
        //       //       final double parallaxOffset = 0.5; // Adjust this value for parallax speed
        //       //       final double itemHeight = 200.0; // Adjust this value for item height
        //       //
        //       //       return Container(
        //       //         height: itemHeight,
        //       //         child: Transform.translate(
        //       //           offset: Offset(0.0, index * parallaxOffset * itemHeight),
        //       //           child: Card(
        //       //             elevation: 4.0,
        //       //             margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        //       //             child: ListTile(
        //       //               title: Text('Item $index'),
        //       //             ),
        //       //           ),
        //       //         ),
        //       //       );
        //       //
        //       //     },
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class TripCategory {
//   final String name;
//   final String imageAsset;
//   final String logoAsset;
//
//   TripCategory({
//     required this.name,
//     required this.imageAsset,
//     required this.logoAsset,
//   });
// }
//
//
//
//
// class NotificationPage extends StatelessWidget {
//   final List<TripCategory> tripCategories = [
//     TripCategory(
//       name: 'Beaches',
//       imageAsset: 'assets/beach.jpg',
//       logoAsset: 'assets/beach_logo.png',
//     ),
//     TripCategory(
//       name: 'Mountains',
//       imageAsset: 'assets/mountain.jpg',
//       logoAsset: 'assets/mountain_logo.png',
//     ),
//     TripCategory(
//       name: 'City Tours',
//       imageAsset: 'assets/city.jpg',
//       logoAsset: 'assets/city_logo.png',
//     ),
//     // Add more trip categories here
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: tripCategories.length,
//       itemBuilder: (context, index) {
//         final tripCategory = tripCategories[index];
//         return TripCategoryCard(tripCategory: tripCategory);
//       },
//     );
//   }
// }
//
// class TripCategoryCard extends StatelessWidget {
//   final TripCategory tripCategory;
//
//   TripCategoryCard({required this.tripCategory});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160.0, // Adjust the width as needed
//       margin: EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               tripCategory.imageAsset,
//               width: 80.0,
//               height: 80.0,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 8.0),
//             Image.asset(
//               tripCategory.logoAsset,
//               width: 40.0,
//               height: 20.0,
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               tripCategory.name,
//               style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
