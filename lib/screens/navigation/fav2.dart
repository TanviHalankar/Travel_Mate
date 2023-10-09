import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ttravel_mate/screens/add%20post/view%20itinerary.dart';
import 'package:ttravel_mate/widget/back.dart';
import 'package:ttravel_mate/widget/lists.dart';


import '../../db_info.dart';
import '../../model/itinerary.dart';
import '../../model/places.dart';
import '../../model/post.dart';
import '../../model/seasons.dart';
import '../../model/time.dart';
import '../../model/users.dart';
import '../../providers/user_provider.dart';
import '../Create Trip/create_trip.dart';
import '../add post/create_post.dart';

class Fav2 extends StatefulWidget {
  final String? uid;
  const Fav2({Key? key, required this.uid}) : super(key: key);
  @override
  _FavState createState() => _FavState();
}


class _FavState extends State<Fav2> {
  List<Post> posts = [];
  List<Seasons> season = [];
  List<Itinerary> itineraries = [];
  List<Places> places=[];
  List<Times> times=[];

  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final auth.User? user = _auth.currentUser;
    String? uid=user?.uid;
    fetchPosts();
    futurePosts = fetchPosts();
  }
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('http://$ip:9000/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> postList = json.decode(response.body);
      return postList.map((tripData) => Post.fromJson(tripData)).toList();

    } else {
      print('HTTP Request Error: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  }
  Future<void> fetchSeasons(int postId) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/seasons?postId=$postId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Find the post that matches the postId
          final post = posts.firstWhere((post) => post.id == postId);

          // Parse the JSON data and create a list of Seasons objects
          post.seasons = (data as List).map((model) => Seasons.fromJson(model)).toList();
          print('njnn${post.seasons}');
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
        throw Exception('Failed to load seasons');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }

  Future<void> fetchItinerary(int postId) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/itinerary?postId=$postId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Find the post that matches the postId
          final post = posts.firstWhere((post) => post.id == postId);

          // Parse the JSON data and create a list of Seasons objects
          post.itinerary = (data as List).map((model) => Itinerary.fromJson(model)).toList();
          print('njnn${post.seasons}');
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
        throw Exception('Failed to load seasons');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // appBar: AppBar(
      //   title: Text('All Posts'),
      // ),
      body: posts.isEmpty
          ? Center(
        child: Text('No posts available.'),
      )
          : Stack(
          children:[
            BackGround(),
            FutureBuilder<List<Post>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      'assets/lottie/loading_animation.json',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Post> fetchedPosts = snapshot.data ?? [];
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 600,
                        child: ListView.builder(
                          itemCount: fetchedPosts.length,  // Use fetchedPosts instead of posts
                          itemBuilder: (context, index) {
                            Post post = fetchedPosts[index];  // Use fetchedPosts instead of posts
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTrip(tripId:trip.tripId,memberId:uid,),));
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
                                                  image: NetworkImage('http://$ip:9000/${post.postCover}'),
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
                                                    post.location,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.white.withOpacity(0.7)),
                                                  ),
                                                  SizedBox(height: 10),
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
          ]
      ),
    );
  }
  }







