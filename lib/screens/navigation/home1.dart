import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/screens/navigation/user_profile.dart';

import '../../db_info.dart';
import '../../model/post.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_carousel_slider/carousel_slider.dart' as c;

import '../../model/users.dart';
import '../../widget/lists.dart';
import '../category_search.dart';
import '../search2.dart';
import 'fav.dart';

class Home1 extends StatefulWidget {
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  late Future<List<Post>> futureTrendingPosts;


  Future<List<Post>> fetchTrendingPosts() async {
    final response =
        await http.get(Uri.parse('http://$ip:9000/posts/trending'));
    if (response.statusCode == 200) {
      final List<dynamic> postList = json.decode(response.body);
      return postList.map((tripData) => Post.fromJson(tripData)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  List<Users> users = [];
  late Post post;

  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    futureTrendingPosts = fetchTrendingPosts();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    String? uid = user?.uid;
    fetchUsers(uid);
    //getUserProfilePic(post.id);
  }

  // Function to handle liking a post
  Future<void> likePost(int postId) async {
    final response =
        await http.post(Uri.parse('http://$ip:9000/posts/like/$postId'));
    if (response.statusCode == 200) {
      print('Post liked successfully');
      // Optionally, update the UI
    } else {
      throw Exception('Failed to like post');
    }
  }

// Function to handle unliking a post
  Future<void> unlikePost(int postId) async {
    final response =
        await http.post(Uri.parse('http://$ip:9000/posts/unlike/$postId'));
    if (response.statusCode == 200) {
      print('Post unliked successfully');
      // Optionally, update the UI
    } else {
      throw Exception('Failed to unlike post');
    }
  }

  Future<void> fetchUsers(String? uid) async {
    try {
      final response = await http.get(Uri.parse(
          'http://$ip:9000/users/$uid')); // Pass uid as a query parameter
      print(uid);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Parse the JSON data and create a list of Post objects
          users = (data as List).map((model) => Users.fromJson(model)).toList();
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

  Future<String?> getUserProfilePic(int postId) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/users/profilePic/$postId'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Assuming the API returns the profilePicUrl field
        final String? profilePicUrl = data['profilePicUrl'];

        return profilePicUrl;
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load profile picture');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the HTTP request.
      print('Error: $e');
      return null;
    }
  }
  final List<NetworkImage> backpic = [
    NetworkImage(
        'https://img.freepik.com/free-photo/high-angle-shot-bandra-worli-sealink-mumbai-enveloped-with-fog_181624-6592.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
    NetworkImage(
        'https://img.freepik.com/free-photo/beautiful-wide-shot-eiffel-tower-paris-surrounded-by-water-with-ships-colorful-sky_181624-5118.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
    NetworkImage(
        'https://img.freepik.com/free-photo/beautiful-shot-small-village-surrounded-by-lake-snowy-hills_181624-37802.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
    NetworkImage(
        'https://img.freepik.com/premium-photo/houseboat-alappuzha-backwaters-kerala_78361-13098.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
  ];
  final List<String> places = [
    "Mumbai",
    "Paris",
    "Austria",
    "Kerala",
  ];
  @override
  Widget build(BuildContext context) {
    return users.isNotEmpty?Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   actions: [
      //     ClipOval(
      //       child:users[0].profilePic.isNotEmpty?Image.network('http://$ip:9000/${users[0].profilePic}',
      //           height: 50,
      //           width: 60,
      //           fit: BoxFit.cover):Image.asset('assets/profile.jpg',height: 100,width: 100),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (users.isNotEmpty) // Check if users list is not empty
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('WELCOME  ',style: GoogleFonts.aboreto(fontSize: 35)),
                                Text('${users[0].username}',style: GoogleFonts.aboreto(fontSize: 30,color: Colors.orange.shade600))
                              ],
                            ),

                          CircleAvatar(
                            radius: 40, // Adjust the radius as needed
                            backgroundColor: Colors.transparent, // You can set a background color if desired
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserProfilePage(users: users),
                                  ),
                                );
                              },
                              child: ClipOval(
                                child:users[0].profilePic.isNotEmpty?Image.network('http://$ip:9000/${users[0].profilePic}',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover):Image.asset('assets/profile.jpg',height: 100,width: 100),
                              ),
                            ),
                          )

                        ],
                      ),
                      //Text("See what's trending"),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 250,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: c.CarouselSlider.builder(
                                  key: _sliderKey,
                                  unlimitedMode: true,
                                  slideBuilder: (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Search2(
                                                  name: places[index]),
                                            ));
                                      },
                                      child: Container(
                                        color: Colors.black,
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: backpic[index],
                                                  opacity: 0.8,
                                                  fit: BoxFit.cover)),
                                          child: Text(
                                            places[index],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  slideTransform: CubeTransform(),
                                  enableAutoSlider: true,
                                  autoSliderDelay: Duration(seconds: 4),
                                  slideIndicator: CircularSlideIndicator(
                                    padding: EdgeInsets.only(bottom: 32),
                                  ),
                                  itemCount: places.length),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Section: Trending Posts Carousel
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            categories.length, // Number of cards you want
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategorySearch(
                                              title: categories[index]),
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: images2[index],
                                            fit: BoxFit.cover,
                                            opacity: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 155.0, // Width of each card
                                    height: 70.0, // Height of each card
                                    child: Center(
                                      child: Text(
                                        categories[index],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            categories.length, // Number of cards you want
                                (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategorySearch(
                                              title: categories[index]),
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: images2[index],
                                            fit: BoxFit.cover,
                                            opacity: 0.5),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    width: 155.0, // Width of each card
                                    height: 70.0, // Height of each card
                                    child: Center(
                                      child: Text(
                                        categories[index],
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("See what's trending",style: GoogleFonts.montserrat(fontSize: 10)),
                      _buildTrendingPostsSection(),

                      SizedBox(
                        height: 20,
                      ),

                      // Section: Other Content
                      //_buildOtherSection(),

                      // Add more sections as needed
                    ],
                  ),
                ),
              )
      ),
    ):Center(child: CircularProgressIndicator());
  }

  Widget _buildTrendingPostsSection() {
    return FutureBuilder<List<Post>>(
      future: futureTrendingPosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Post> trendingPosts = snapshot.data ?? [];
          return trendingPosts.isEmpty
              ? Center(
                  child: Text('No posts'),
                ) // Don't show an empty section
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(height: 16.0),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: Text(
                    //     'Trending Posts',
                    //     style: TextStyle(
                    //       fontSize: 24.0,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 8.0),
                    CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 300.0,
                        //enableInfiniteScroll: true,
                        autoPlay: true,
                      ),
                      items: trendingPosts.map((post) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Fav(postId: post.id),
                                  ),
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'http://$ip:9000/${post.postCover}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black
                                            ],
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                            stops: [0.4, 1.0])),
                                  )),
                                  Positioned(
                                      right: 0,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: post.isLiked
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(Icons.favorite_border,
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    size: 30),
                                            onPressed: () {
                                              if (post.isLiked) {
                                                // If the post is liked, unlike it
                                                unlikePost(post.id);
                                              } else {
                                                // If the post is not liked, like it
                                                likePost(post.id);
                                              }
                                              setState(() {
                                                post.isLiked = !post.isLiked;
                                                if (post.isLiked) {
                                                  post.likes += 1;
                                                } else {
                                                  post.likes -= 1;
                                                }
                                              });
                                            },
                                          ),
                                          Text('${post.likes}')
                                        ],
                                      )),

                                  // Positioned(
                                  //   left: 10,
                                  //   bottom: 10,
                                  //   child: FutureBuilder<String?>(
                                  //     future: getUserProfilePic(post.id),
                                  //     builder: (context, profilePicSnapshot) {
                                  //       if (profilePicSnapshot.connectionState ==
                                  //           ConnectionState.waiting) {
                                  //         return CircularProgressIndicator();
                                  //       } else if (profilePicSnapshot.hasError) {
                                  //         return Text('Error: ${profilePicSnapshot.error}');
                                  //       } else {
                                  //         final String? profilePicUrl = profilePicSnapshot.data;
                                  //         return Row(
                                  //           children: [
                                  //             CircleAvatar(
                                  //               backgroundImage: profilePicUrl != null
                                  //                   ? NetworkImage(profilePicUrl) as ImageProvider<Object>
                                  //                   : AssetImage('assets/default_profile_pic.png'), // Replace with your default profile picture asset
                                  //             ),
                                  //             const SizedBox(width: 10),
                                  //             // Other details...
                                  //           ],
                                  //         );
                                  //       }
                                  //     },
                                  //   ),
                                  // )
                             Positioned(
                                    left: 10,
                                    bottom: 10,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'http://$ip:9000/${users[0].profilePic}'
                            ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post.location,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              post.duration,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                  // Positioned(
                                  //   bottom: 0.0,
                                  //   left: 0.0,
                                  //   right: 0.0,
                                  //   child: Container(
                                  //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  //     decoration: BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         begin: Alignment.bottomCenter,
                                  //         end: Alignment.topCenter,
                                  //         colors: [Colors.black, Colors.transparent],
                                  //       ),
                                  //     ),
                                  //     child: Text(
                                  //       post.location,
                                  //       style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 20.0,
                                  //         fontWeight: FontWeight.bold,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
        }
      },
    );
  }

  // Widget _buildOtherSection() {
  //   // Build the widget for the other section
  //   // Use the data from the `futureOtherSectionData` Future
  //   return FutureBuilder<List<Post>>(
  //     future: futureOtherSectionData,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (snapshot.hasError) {
  //         return Center(
  //           child: Text('Error: ${snapshot.error}'),
  //         );
  //       } else {
  //         // Build your UI for the other section
  //         return Container(
  //           // Customize your UI based on the data
  //           child: Column(
  //             children: [
  //               Text(
  //                 'Other Section',
  //                 style: TextStyle(
  //                   fontSize: 24.0,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               // Add your UI components for this section
  //             ],
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
}
