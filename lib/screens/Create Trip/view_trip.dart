import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ttravel_mate/screens/Create%20Trip/join_trip.dart';
import 'package:http/http.dart' as http;
import 'package:ttravel_mate/screens/Create%20Trip/view_details.dart';

import '../../db_info.dart';
import '../../model/members.dart';
import '../../model/trips.dart';
import '../../providers/join_trip_state.dart';
import 'memDetails.dart';

class ViewTrip extends StatefulWidget {
  int tripId;
  String? memberId;
  ViewTrip({Key? key, required this.tripId, required this.memberId})
      : super(key: key);

  @override
  State<ViewTrip> createState() => _ViewTripState();
}

class _ViewTripState extends State<ViewTrip> {
  late Future<Trips> futureTrip;
  late Future<Members?> futureMembers;
  late Future<List<Members>> mems;

  Future<Trips> fetchTripById(String tripId) async {
    final response = await http.get(Uri.parse('http://$ip:9000/trips/$tripId'));
    if (response.statusCode == 200) {
      print(response.body);
      final dynamic tripData = json.decode(response.body);
      return Trips.fromJson(tripData);
    } else {
      throw Exception('Failed to load trip with ID: $tripId');
    }
  }

  // Future<Members> fetchMemberByIds(int tripId, String? memberId) async {
  //   final response = await http.get(Uri.parse('http://$ip:9000/members/$tripId/$memberId'));
  //   if (response.body.isEmpty) {
  //     throw Exception('Empty response received from the server');
  //   }
  //   if (response.statusCode == 200) {
  //     final dynamic memData = json.decode(response.body);
  //     return Members.fromJson(memData);
  //   } else {
  //     throw Exception('Failed to load member with ID: $tripId and $memberId');
  //   }
  // }
  Future<Members?> fetchMemberByIds(int tripId, String? memberId) async {
    final response = await http.get(Uri.parse('http://$ip:9000/members/$tripId/$memberId'));

    if (response.statusCode == 200) {
      final dynamic memData = json.decode(response.body);
      return Members.fromJson(memData);
    } else if (response.statusCode == 404) {
      // Assuming 404 indicates that the user is not a member of the trip
      return null;
    } else {
      throw Exception('Failed to load member with ID: $tripId and $memberId');
    }
  }

  Future<List<Members>> fetchMembersById(int tripId) async {
    final response =
    await http.get(Uri.parse('http://$ip:9000/members/$tripId'));
    if (response.statusCode == 200) {
      final List<dynamic> memDataList = json.decode(response.body);
      return memDataList.map((memData) => Members.fromJson(memData)).toList();
    } else {
      throw Exception('Failed to load members with ID: $tripId');
    }
  }
  // Future<List<Members>> fetchMembersById(int tripId) async {
  //   final response =
  //       await http.get(Uri.parse('http://$ip:9000/members/$tripId'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> memDataList = json.decode(response.body);
  //     return memDataList.map((memData) => Members.fromJson(memData)).toList();
  //   } else {
  //     throw Exception('Failed to load members with ID: $tripId');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTrip = fetchTripById('${widget.tripId}');
    futureMembers = fetchMemberByIds(widget.tripId, widget.memberId);
    mems=fetchMembersById(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    final joinTripState = context.watch<JoinTripState>();
    return Scaffold(
      body: FutureBuilder<Trips>(
        future: futureTrip,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            Trips trip = snapshot.data!;
            return FutureBuilder<Members?>(
              future: futureMembers,
              builder: (context, membersSnapshot) {
                if (membersSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                  // } else if (membersSnapshot.hasError) {
                  //   return Center(child: Text('Error: ${membersSnapshot.error}'));
                } else {
                  Members? membersList = membersSnapshot.data;
                  print(membersList);
                  print(mems);
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network('http://$ip:9000/${trip.coverPhoto}',
                          fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 400,
                        left: 16,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${trip.title}',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                '${trip.startDate}',
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 10),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 320,
                                  height: 200,
                                  child: Text(
                                    '${trip.desc}',
                                    style: GoogleFonts.actor(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100,
                                    ),
                                    textScaleFactor: 1.2,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (trip.ownerId == uid) {
                                      // If the user is the owner, show member details
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MemberDetails(
                                            tripId: trip.tripId,
                                          ),
                                        ),
                                      );
                                    } else if (membersList != null) {
                                      if (membersList.status == 'pending') {
                                        // The user is not the owner or a member, and the request is pending
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text('Request already sent!'),
                                          ),
                                        );
                                      } else if (membersList.status ==
                                          'accept') {
                                        // The user is not the owner or a member, and the request is accepted
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ViewDetails(
                                              trip: trip,
                                              ownerPhn:trip.ownerPhn
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      // If none of the above conditions are met, navigate to the JoinTrip page
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => JoinTrip(
                                            tripId: trip.tripId,
                                            ownerId: trip.ownerId,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: trip.ownerId == uid
                                      ? Text('Show Member Details')
                                      : (membersList != null
                                          ? (membersList.status == 'pending'
                                              ? Text('Requested')
                                              : Text('View Details'))
                                          : Text('Join Trip'))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
// return Scaffold(
//     body: FutureBuilder<Trips>(
//         future: futureTrip,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data available'));
//           } else {
//             Trips trip = snapshot.data!;
//
//             //'http://$ip:9000/${trip.coverPhoto}'
//             return FutureBuilder <Members?>(
//               future: futureMembers,
//               builder: (context, membersSnapshot) {
//                 if (membersSnapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 // } else if (membersSnapshot.hasError) {
//                 //   return Center(
//                 //       child: Text('Error: ${membersSnapshot.error}'));
//                 // } else if (!membersSnapshot.hasData ||
//                 //     membersSnapshot.data == null) {
//                 //   return Center(child: Text('No members data available'));
//                 } else {
//                   Members membersList = membersSnapshot.data!;
//                   print(membersList);
//                   return Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.network('http://$ip:9000/${trip.coverPhoto}',
//                           fit: BoxFit.cover),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.black.withOpacity(0.5),
//                               Colors.black,
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 400,
//                         left: 16,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '${trip.title}',
//                                 style: GoogleFonts.montserrat(
//                                     color: Colors.white, fontSize: 30),
//                               ),
//                               Text(
//                                 '${trip.startDate}',
//                                 style: GoogleFonts.montserrat(
//                                     color: Colors.white, fontSize: 10),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   width: 320,
//                                   //color: Colors.white,
//                                   child: Text(
//                                     '${trip.desc}',
//                                     style: GoogleFonts.actor(
//                                         color:
//                                             Colors.white.withOpacity(0.7),
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w100),
//                                     textScaleFactor: 1.2,
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   // Check if the user is the owner of the trip
//                                   if (trip.ownerId == uid) {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => MemberDetails(
//                                           tripId: trip.tripId,
//                                         ),
//                                       ),
//                                     );
//                                   } else {
//                                     // Check if the request is already sent and status is pending
//                                     if (membersList.status == 'pending' && membersList.memberId==uid) {
//                                       // Show a snack bar indicating that the request is already sent
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(
//                                           duration: Duration(seconds: 1),
//                                           content: Text('Request already sent!'),
//                                         ),
//                                       );
//                                     }
//                                     // Check if the request is already accepted
//                                     else if (joinTripState.getRequestStatus(widget.tripId) &&
//                                         membersList.status == 'accept') {
//                                       // Navigate to the view details page
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => ViewDetails(
//                                             tripId: widget.tripId,
//                                           ),
//                                         ),
//                                       );
//                                     } else {
//                                       // If none of the above conditions are met, navigate to the JoinTrip page
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => JoinTrip(
//                                             tripId: trip.tripId,
//                                             ownerId: trip.ownerId,
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                   }
//                                 },
//                                 // Determine the text for the button based on conditions
//                                 child: trip.ownerId == uid
//                                     ? Text('Show Member Details') // If the user is the owner
//                                     : joinTripState.getRequestStatus(widget.tripId)
//                                     ? membersList.status == 'pending'
//                                     ? Text('Requested') // If the request is pending
//                                     : membersList.status == 'accept'
//                                     ? Text('View Trip Details') // If the request is accepted
//                                     : Text('Join Trip') // Default case
//                                     : Text('Join Trip') // Default case// Default case
//                               ),
//
//                               // Add more details as needed
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//
//                   // ElevatedButton(
//                   //   onPressed: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context) => JoinTrip(),));
//                   //   },
//                   //   child: Text('Join Trip'),
//                   // ),
//
//                 }
//               },
//             );
//
//             // Column(
//             //   children: [
//             //     Text('Cover photo'),
//             //     Text('Trip Title'),
//             //     Text('Trip Desc'),
//             //     Text('Trip start and end date'),
//             //     Text('Total Members'),
//             //     Text('Trip itinerary'),
//             //     Text('Age Group'),
//             //     ElevatedButton(onPressed: (){
//             //       Navigator.push(context, MaterialPageRoute(builder: (context) => JoinTrip(),));
//             //     }, child: Text('Join Trip'))
//             //   ],
//             // ),
//           }
//         }));
