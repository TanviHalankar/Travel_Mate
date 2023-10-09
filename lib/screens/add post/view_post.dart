// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:ttravel_mate/screens/Create%20Trip/join_trip.dart';
// import 'package:http/http.dart' as http;
// import 'package:ttravel_mate/screens/Create%20Trip/view_details.dart';
// import 'package:ttravel_mate/screens/navigation/view_posts.dart';
//
// import '../../db_info.dart';
// import '../../model/itinerary.dart';
// import '../../model/members.dart';
// import '../../model/post.dart';
// import '../../model/seasons.dart';
// import '../../model/trips.dart';
// import '../../providers/join_trip_state.dart';
//
//
// class ViewPost extends StatefulWidget {
//   int postId;
//   ViewPost({Key? key, required this.postId})
//       : super(key: key);
//
//   @override
//   State<ViewPost> createState() => _ViewPostState();
// }
//
// class _ViewPostState extends State<ViewPost> {
//   late Future<Post> futurePost;
//
//
//   Future<Post> fetchPostById(int postId) async {
//     final response = await http.get(Uri.parse('http://$ip:9000/posts/postId/$postId'));
//     if (response.statusCode == 200) {
//       final dynamic responseData = json.decode(response.body);
//
//       if (responseData is List) {
//         // Assuming the response is a list, take the first item
//         final dynamic postData = responseData.isNotEmpty ? responseData[0] : null;
//         if (postData != null) {
//           return Post.fromJson(postData);
//         } else {
//           throw Exception('Post with ID $postId not found');
//         }
//       } else if (responseData is Map<String, dynamic>) {
//         // Assuming the response is a single object
//         return Post.fromJson(responseData);
//       } else {
//         throw Exception('Unexpected response format');
//       }
//     } else {
//       throw Exception('Failed to load post with ID: $postId');
//     }
//   }
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     futurePost = fetchPostById(widget.postId);
//     //futureMembers = fetchMemberByIds(widget.tripId, widget.memberId);
//     //mems=fetchMembersById(widget.tripId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final User? user = _auth.currentUser;
//     final uid = user?.uid;
//     final joinTripState = context.watch<JoinTripState>();
//     return Scaffold(
//       body: FutureBuilder<Post>(
//         future: futurePost,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data available'));
//           } else {
//             Post post = snapshot.data!;
//             return Stack(
//               fit: StackFit.expand,
//               children: [
//                 Image.network('http://$ip:9000/${post.postCover}',
//                     fit: BoxFit.cover),
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.5),
//                         Colors.black,
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 400,
//                   left: 16,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${post.location}',
//                           style: GoogleFonts.montserrat(
//                               color: Colors.white, fontSize: 30),
//                         ),
//                         Text(
//                           '${post.duration}',
//                           style: GoogleFonts.montserrat(
//                               color: Colors.white, fontSize: 10),
//                         ),
//                         SizedBox(height: 20),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             width: 320,
//                             height: 200,
//                             child: Text(
//                               '${post.description}',
//                               style: GoogleFonts.actor(
//                                 color: Colors.white.withOpacity(0.7),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w100,
//                               ),
//                               textScaleFactor: 1.2,
//                             ),
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
