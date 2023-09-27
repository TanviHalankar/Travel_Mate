import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/screens/navigation/settings.dart';

import '../../db_info.dart';
import '../../login_pages/auth_methods.dart';
import '../../model/itinerary.dart';
import '../../model/post.dart';

import '../../model/seasons.dart';
import '../../model/users.dart';
import '../../widget/back.dart';
import '../add post/view itinerary.dart';
import '../start_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;



class UserProfilePage extends StatefulWidget {
  List<Users> users;
  UserProfilePage ({Key? key,required this.users}) : super(key: key);
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  List<Post> posts = [];
  List<Seasons> season = [];
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing=false;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final auth.User? user = _auth.currentUser;
    String? uid=user?.uid;
    fetchPostsById(uid);
    fetchFollowersCount(uid);
    fetchFollowingCount(uid);
  }
  void followUser() {
    // Send a request to the server to follow the user
    // Update the UI to reflect the new relationship status
    setState(() {
      isFollowing = true;
    });
  }

  void unfollowUser() {
    // Send a request to the server to unfollow the user

    // Update the UI to reflect the new relationship status
    setState(() {
      isFollowing = false;
    });
  }

  Future<void> fetchFollowersCount(String? uid) async {
    try {
      final response = await http.get(
        Uri.parse('http://$ip:9000/followers/count/$uid'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          followersCount = data['count'];
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchFollowingCount(String? uid) async {
    try {
      final response = await http.get(
        Uri.parse('http://$ip:9000/following/count/$uid'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          followingCount = data['count'];
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }





  Future<void> fetchPostsById(String? uid) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/posts/$uid')); // Pass uid as a query parameter
      print(uid);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Parse the JSON data and create a list of Post objects
          posts = (data as List).map((model) => Post.fromJson(model)).toList();
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }


  Future<void> fetchSeasons(int postId) async {
    try {
      final response = await http.get(Uri.parse('http://' + ip + ':9000/seasons?postId=$postId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Find the post that matches the postId
          final post = posts.firstWhere((post) => post.id == postId);

          // Parse the JSON data and create a list of Seasons objects
          post.seasons = (data as List).map((model) => Seasons.fromJson(model)).toList();
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
  double currentValue=80;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(users: widget.users),));
          }, icon: Icon(Icons.settings),color: Colors.white,),],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/woman-female-young-adult-girl-abstract-minimalist-face-portrait-digital-generated-illustration-cover_840789-1569.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=ais',//'https://img.freepik.com/premium-photo/man-wearing-sunglasses-shirt-with-white-collar_14117-15974.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=ais'
                     ),
                ),
                SizedBox(height: 20),
                if (widget.users.isNotEmpty) // Check if users list is not empty
                Text(
                  '${widget.users[0].username}',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Travel Enthusiast',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    buildCountColumn('Trips', '${posts.length}'),
                    buildCountColumn('Followers', followersCount.toString()),
                    buildCountColumn('Following', followingCount.toString()),
                  ],
                ),
                SizedBox(height: 10,),
                /*Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.maxFinite,

                    child: ElevatedButton(
                      style: ButtonStyle(shape: MaterialStatePropertyAll(BeveledRectangleBorder())),
                      onPressed: () {
                        // Add navigation to edit profile
                      },
                      child: Text('Edit Profile',style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w200)),
                    ),
                  ),
                ),*/


                SizedBox(height: 10,),

                Center(
                    child: FAProgressBar(
                      currentValue: currentValue,
                      displayText: '%',
                      backgroundColor: Colors.brown.shade100,
                      progressColor: Colors.brown.shade300,
                      borderRadius: BorderRadius.circular(5),
                    )),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement follow/unfollow logic here
                      // You can check the current relationship status and take appropriate action
                      if (isFollowing) {
                        // User is currently following, so unfollow
                        unfollowUser();
                      } else {
                        // User is not following, so follow
                        followUser();
                      }
                    },
                    child: Text(
                      isFollowing ? 'Unfollow' : 'Follow',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                ),


                SizedBox(height: 5,),
                Text('(You are ${currentValue}% close to getting TravelMate badge)',style: GoogleFonts.aBeeZee(fontSize: 8,color: Colors.grey)),
                SizedBox(height: 10,),
                Divider(color: Colors.grey.shade700,thickness: 1,height: 2,),
                Row(
                  children: [
                    Text('My Trips',style: GoogleFonts.montserrat()),
                  ],
                ),
                SizedBox(height: 10,),

                posts.isEmpty
                    ? Center(
                  child: Text('No posts available.'),
                )
                    : Container(
                      height: 300,
                      child: Stack(
                      children:[
                        BackGround(),
                        ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(
                                    post.location,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    post.description,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15, color: Colors.grey.shade500),
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    height: 355,
                                    width: 400,
                                    color: Colors.white.withOpacity(0.1),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Duration',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                post.duration,
                                                style: GoogleFonts.montserrat(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Divider(height: 30, thickness: 1),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Category',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                post.category,
                                                style: GoogleFonts.montserrat(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Divider(height: 30, thickness: 1),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Budget',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '\₹${post.budget.toStringAsFixed(2)}',
                                                style: GoogleFonts.montserrat(fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Divider(height: 30, thickness: 1),
                                          Row(
                                            children: [
                                              Text(
                                                'Seasons',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15, fontWeight: FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(onPressed: (){
                                                    setState(() {
                                                      post.showSeasons = !post.showSeasons;
                                                    });
                                                    if (post.showSeasons==true) {
                                                      fetchSeasons(post.id);
                                                    }

                                                  }, icon: post.showSeasons==false?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down_outlined)),
                                                  ElevatedButton(onPressed: (){
                                                    print(post.id);
                                                    fetchItinerary(post.id);
                                                    // fetchPlaces(post.id);
                                                    print('Duration: ${post.duration}');

                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewItinerary(duration: post.duration,id:post.id, title: post.location,),
                                                    ));

                                                    //fetchTimes(post.id);
                                                    print(post.places);

                                                  }, child: Text('View Itinerary',style: GoogleFonts.montserrat(color: Colors.white.withOpacity(0.5)),)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          if(post.showSeasons)
                                            Wrap(
                                              spacing: 8.0,
                                              runSpacing: 4.0,
                                              children: post.seasons.map((seasonName) {
                                                return Chip(
                                                  label: Text(seasonName.season_name),
                                                  backgroundColor: Colors.green.shade200,
                                                  labelStyle:
                                                  TextStyle(color: Colors.green.shade900),
                                                );
                                              }).toList(),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Container(width: double.maxFinite,child: ElevatedButton(onPressed: (){
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddItinerary(start: start, end: end, title: location, duration: duration, description: description, season: seasons, category: category, budget: budget),));
                                  // }, child: Text('View Itinerary',style: GoogleFonts.montserrat(color: Colors.white.withOpacity(0.7)),))
                                  // )
                                ],
                              ),
                            );
                          },
                        ),]
                ),
                    ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildCountColumn(String label, String count) {
    return Column(
      children:[
        Text(
          count,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white60
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
