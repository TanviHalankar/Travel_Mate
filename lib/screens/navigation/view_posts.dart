import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:ttravel_mate/screens/navigation/fav.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../db_info.dart';
import '../../model/post.dart';
import '../../model/trips.dart';
import '../../model/users.dart';
import '../Create Trip/create_trip.dart';
import '../Create Trip/view_trip.dart';
import '../add post/view_post.dart';
import '../search2.dart';

class ViewPosts extends StatefulWidget {
ViewPosts({Key? key}) : super(key: key);

  @override
  State<ViewPosts> createState() => _ViewPostsState();
}

class _ViewPostsState extends State<ViewPosts> {
  List<Users> users = [];
  //bool isLiked=false;

  late Future<List<Post>> futurePosts;

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('http://$ip:9000/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> postList = json.decode(response.body);
      return postList.map((tripData) => Post.fromJson(tripData)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }



// Function to handle liking a post
  Future<void> likePost(int postId) async {
    final response = await http.post(Uri.parse('http://$ip:9000/posts/like/$postId'));
    if (response.statusCode == 200) {
      print('Post liked successfully');
      // Optionally, update the UI
    } else {
      throw Exception('Failed to like post');
    }
  }

// Function to handle unliking a post
  Future<void> unlikePost(int postId) async {
    final response = await http.post(Uri.parse('http://$ip:9000/posts/unlike/$postId'));
    if (response.statusCode == 200) {
      print('Post unliked successfully');
      // Optionally, update the UI
    } else {
      throw Exception('Failed to unlike post');
    }
  }


  // Future<void> fetchUsers(String? postId) async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://$ip:9000/users/profilePic/$postId')); // Pass uid as a query parameter
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Parse the JSON data and create a list of Post objects
  //         users = (data as List).map((model) => Users.fromJson(model)).toList();
  //       });
  //     } else {
  //       print('HTTP Request Error: ${response.statusCode}');
  //       throw Exception('Failed to load profilePic');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     // Handle the error, e.g., show an error message to the user
  //   }
  // }

  // Future<void> fetchUsers(String? uid) async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://$ip:9000/users/$uid')); // Pass uid as a query parameter
  //     print(uid);
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       setState(() {
  //         // Parse the JSON data and create a list of Post objects
  //         users = (data as List).map((model) => Users.fromJson(model)).toList();
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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
    futurePosts = fetchPosts();
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // String? uid = user?.uid;
    //fetchUsers(uid);
  }
  String getProfilePicUrl(String filename) {
    // Assuming your server serves static files from '/uploads'
    final serverBaseUrl = 'http://$ip:9000';
    //final uploadsPath = 'uploads';  // Adjust this based on your server's file structure
    return '$serverBaseUrl/$filename';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                  'assets/lottie/loading_animation.json', // replace with your Lottie animation file
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Post> posts = snapshot.data ?? [];
              return MasonryGridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = posts[index];
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
                      children:[
                        Container(
                        height: (index == 0) ? 250 : 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  'http://$ip:9000/${post.postCover}',
                                ),
                                fit: BoxFit.cover)
                        ),
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             post.location,
                        //             style: TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //           Text(
                        //             post.duration,
                        //             style: TextStyle(
                        //                 fontSize: 12, color: Colors.grey),
                        //           ),
                        //           // Add other details you want to display...
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ),
                        Positioned.fill(child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors:[Colors.transparent,Colors.black],
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            stops: [0.4,1.0])
                          ),
                        )),
                        Positioned(right: 0,child: Column(
                          children: [
                            IconButton(icon: post.isLiked?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: Colors.white.withOpacity(0.6),size: 30), onPressed: () {
                              if (post.isLiked) {
                                // If the post is liked, unlike it
                                unlikePost(post.id);
                              } else {
                                // If the post is not liked, like it
                                likePost(post.id);
                              }
                              setState(() {
                                post.isLiked=!post.isLiked;
                                if (post.isLiked) {
                                  post.likes += 1;
                                } else {
                                  post.likes -= 1;
                                }
                              });
                            },),

                            Text('${post.likes}')
                          ],
                        )),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: Row(
                            children: [
                              // CircleAvatar(
                              //   backgroundImage: NetworkImage('http://$ip:9000/uploads//1696239856595.jpg'),
                              // ),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.location,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    post.duration,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                  );
                },
                //staggeredTileBuilder: (int index) => StaggeredTile.fit(1), // Adjust tile sizes as needed
              );
              //   Column(
              //   children: [
              //     Container(
              //       height: 600,
              //       child: ListView.builder(
              //         itemCount: posts.length,
              //         itemBuilder: (context, index) {
              //           Post post = posts[index];
              //           return Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               children: [
              //                 GestureDetector(
              //                   onTap: () {
              //                     Navigator.push(context, MaterialPageRoute(builder: (context) => Fav(postId: post.id),));
              //                   },
              //                   child: Stack(children: [
              //                     Container(
              //                       height: 350,
              //                       color: Colors.black,
              //                     ),
              //                     Opacity(
              //                       opacity: 0.7,
              //                       child: Container(
              //                         width: double.maxFinite,
              //                         height: 320,
              //                         decoration: BoxDecoration(
              //                             image: DecorationImage(
              //                                 image: NetworkImage('http://$ip:9000/${post.postCover}'),
              //                                 fit: BoxFit.cover)),
              //                       ),
              //                     ),
              //                     Positioned(
              //                         left: 20,
              //                         bottom: 60,
              //                         child: Container(
              //                             width: 250,
              //                             child: Column(
              //                               crossAxisAlignment: CrossAxisAlignment.start,
              //                               children: [
              //                                 Text(
              //                                   post.location,
              //                                   style: GoogleFonts.montserrat(
              //                                       fontSize: 25,
              //                                       fontWeight: FontWeight.w500,
              //                                       color: Colors.white.withOpacity(0.7)),
              //                                 ),
              //                                 SizedBox(height: 10),
              //                                 Text('${post.duration}',
              //                                     style: GoogleFonts.montserrat(
              //                                         fontSize: 12,
              //                                         fontWeight: FontWeight.w500,
              //                                         color: Colors.white.withOpacity(0.7))),
              //                               ],
              //                             ))),
              //                     Positioned(
              //                         right: 20,
              //                         top: 20,
              //                         child: CircleAvatar(
              //                           backgroundImage: NetworkImage('http://$ip:9000/${users[0].profilePic}'),
              //                           radius: 25,
              //                         )),
              //                     // Positioned(
              //                     //     bottom: -20,
              //                     //     left: 20,
              //                     //     child: CircleAvatar(backgroundColor: Colors.white)),
              //                   ]
              //                   ),
              //                 )
              //
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ],
              // );
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
