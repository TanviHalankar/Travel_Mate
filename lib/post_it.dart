// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ttravel_mate/model/place.dart';
// import 'db_info.dart';
//
// import 'model/post.dart';
// class post_it extends StatefulWidget {
//   const post_it({Key? key}) : super(key: key);
//
//   @override
//   State<post_it> createState() => _post_itState();
// }
//
// class _post_itState extends State<post_it> {
//   List<Post> posts = [];
//   List<Place> place = [];
//
//   @override
//   void initState() {
//     super.initState();
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final User? user = _auth.currentUser;
//     String? uid=user?.uid;
//     fetchPosts();
//     fetchPlace();
//
//   }
//   Future<void> fetchPosts() async {
//     try {
//       final response = await http.get(Uri.parse('http://$ip:9000/posts'));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//
//         setState(() {
//           // Parse the JSON data and create a list of Post objects
//           posts = (data as List).map((model) => Post.fromJson(model)).toList();
//           print(posts);
//         });
//       } else {
//         print('HTTP Request Error: ${response.statusCode}');
//         throw Exception('Failed to load posts');
//       }
//     } catch (e) {
//       print('Error: $e');
//       // Handle the error, e.g., show an error message to the user
//     }
//   }
//
//   Future<void> fetchPlace() async {
//     try {
//       final response = await http.get(Uri.parse('http://$ip:9000/posts'));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//
//         setState(() {
//           // Parse the JSON data and create a list of Post objects
//           place = (data as List).map((model) => Place.fromJson(model)).toList();
//           print(place.toString());
//         });
//       } else {
//         print('HTTP Request Error: ${response.statusCode}');
//         throw Exception('Failed to load posts');
//       }
//     } catch (e) {
//       print('Error: $e');
//       // Handle the error, e.g., show an error message to the user
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//         appBar: AppBar(),
//         backgroundColor: Colors.white,
//       body:(posts.length==0 || place.length==0)? Center(child: CircularProgressIndicator()):
//       Column(
//         children: [
//           Text(posts[0].location),
//           Text(posts[0].duration),
//           Text(place[0].pname),
//           Text(place[0].time),
//         ],
//       ),
//     );
//   }
// }
