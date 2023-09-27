import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
import '../../user_provider.dart';

class Fav extends StatefulWidget {
  final String? uid;
  const Fav({Key? key, required this.uid}) : super(key: key);
  @override
  _FavState createState() => _FavState();
}


class _FavState extends State<Fav> {
  List<Post> posts = [];
  List<Seasons> season = [];
  List<Itinerary> itineraries = [];
  List<Places> places=[];
  List<Times> times=[];
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  final List<String> letters = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
  ];

  bool _isPlaying = false;
  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final auth.User? user = _auth.currentUser;
    String? uid=user?.uid;
    fetchPosts();

  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/posts'));

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

  // Future<void> fetchPostsById(String? uid) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://$ip:9000/posts/$uid')); // Pass uid as a query parameter
  //     print(uid);
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Parse the JSON data and create a list of Post objects
  //         posts = (data as List).map((model) => Post.fromJson(model)).toList();
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load posts');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error, e.g., show an error message to the user
  //   }
  // }


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




  // Future<void> fetchPlaces(int postId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://$ip:9000/places?postId=$postId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Find the post that matches the postId
  //         final post = posts.firstWhere((post) => post.id == postId);
  //
  //         // Parse the JSON data and create a list of Seasons objects
  //         post.places = (data as List).map((model) => Places.fromJson(model)).toList();
  //         print('post.places: ${post.places}');
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load seasons');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error, e.g., show an error message to the user
  //   }
  // }

  // Future<void> fetchTimes(int postId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://$ip:9000/times?postId=$postId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Find the post that matches the postId
  //         final post = posts.firstWhere((post) => post.id == postId);
  //
  //         // Parse the JSON data and create a list of Seasons objects
  //         post.times = (data as List).map((model) => Times.fromJson(model)).toList();
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load seasons');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error, e.g., show an error message to the user
  //   }
  // }
  // Future<void> fetchItinerary(int postId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://' + ip + ':9000/itinerary?postId=$postId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Itinerary data for postId $postId: $data');
  //
  //       // Create a list to hold the fetched itineraries
  //       itineraries= (data as List).map((model) => Itinerary.fromJson(model)).toList();
  //
  //       // Find the post that matches the postId
  //       final post = posts.firstWhere((post) => post.id == postId);
  //
  //       // Assign the fetched itineraries to the post
  //       setState(() {
  //         post.itinerary = itineraries;
  //         print('Here: ${post.itinerary}');
  //       });
  //
  //       // Fetch places associated with each itinerary and store them
  //       for (var itinerary in itineraries) {
  //         await fetchPlaces(itinerary.itiId);
  //       }
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load itinerary');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }



  // Future<void> fetchPlaces(int itiId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://' + ip + ':9000/places?itiId=$itiId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Places data for itiId $itiId: $data');
  //
  //       final post = posts.firstWhere((post) => post.itinerary.any((itinerary) => itinerary.itiId == itiId));
  //
  //
  //       places = (data as List).map((model) => Places.fromJson(model)).toList();
  //       setState(() {
  //         // Update the places for the specific itinerary
  //         final itinerary = post.itinerary.firstWhere((itinerary) => itinerary.itiId == itiId);
  //         itinerary.place = places;
  //         print('thissssssssssssssssssss${itinerary.place}');
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load places');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  // Future<void> fetchItinerary(int postId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://' + ip + ':9000/itinerary?postId=$postId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Itinerary data for postId $postId: $data');
  //
  //       // Create a list to hold the fetched itineraries
  //       List<Itinerary> fetchedItineraries = (data as List).map((model) => Itinerary.fromJson(model)).toList();
  //
  //       // Find the post that matches the postId
  //       final post = posts.firstWhere((post) => post.id == postId);
  //
  //       // Assign the fetched itineraries to the post
  //       setState(() {
  //         post.itinerary = fetchedItineraries;
  //         print('Here: ${post.itinerary}');
  //       });
  //
  //       // Fetch places associated with each itinerary
  //       for (var itinerary in fetchedItineraries) {
  //         await fetchPlaces(itinerary.itiId);
  //       }
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load itinerary');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // Future<void> fetchPlaces(int itiId) async {
  //   try {
  //          final response = await http.get(Uri.parse('http://' + ip + ':9000/places?itiId=$itiId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Find the post that matches the postId
  //         final itinerary = itineraries.firstWhere((itinerary) => itinerary.itiId == itiId);
  //
  //         // Parse the JSON data and create a list of Seasons objects
  //         itinerary.place = (data as List).map((model) => Places.fromJson(model)).toList();
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load seasons');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error, e.g., show an error message to the user
  //   }
  // }
  // Future<void> fetchPlaces(int itiId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://' + ip + ':9000/places?itiId=$itiId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Places data for itiId $itiId: $data');
  //
  //       // Now, you can parse this data and use it as needed, such as displaying it in your UI.
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load places');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }



  // Future<void> fetchSeasons(int postId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://'+ip+':9000/seasons?postId=$postId'));
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Parse the JSON data and create a list of Seasons objects
  //         season = (data as List).map((model) => Seasons.fromJson(model)).toList();
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load seasons');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error, e.g., show an error message to the user
  //   }
  // }

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
            ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                print(post);
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
                          const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                                    print('Places: ${places}');
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewItinerary(duration: post.duration,id:post.id,title:post.location),
                                      ));

                                    //fetchTimes(post.id);
                                    print(post.places);

                                  }, child: Text('View Itinerary',style: GoogleFonts.montserrat(color: Colors.white.withOpacity(0.5)),)),
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

                              // if (post.showSeasons)
                              //   Wrap(
                              //     spacing: 8.0,
                              //     runSpacing: 4.0,
                              //     children: season.map((seasonName) {
                              //       return Chip(
                              //         label: Text(seasonName.season_name),
                              //         backgroundColor: Colors.green.shade200,
                              //         labelStyle: TextStyle(color: Colors.green.shade900),
                              //       );
                              //     }).toList(),
                              //   ),

                              //                 if(post.showSeasons)
                              //                   for(int i=0;i<season.length;i++)
                              //                    // Text('Email: ${season[i].season_name}'),
                              // Chip(
                              //       label: Text('${season[i].season_name}'),
                              //       backgroundColor: Colors.green.shade200,
                              //       labelStyle:
                              //       TextStyle(color: Colors.green.shade900),
                              //     ),
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
    );
  }
}
