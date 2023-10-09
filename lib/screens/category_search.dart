import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:ttravel_mate/widget/display_post.dart';
import '../../model/post.dart';
import '../../model/seasons.dart';

import '../db_info.dart';
import '../widget/back.dart';
import 'add post/view itinerary.dart';

class CategorySearch extends StatefulWidget {
  String title;
  CategorySearch({Key? key, required this.title}) : super(key: key);
  @override
  _CategorySearchState createState() => _CategorySearchState();
}

class _CategorySearchState extends State<CategorySearch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Post> posts = [];
  List<Seasons> season = [];

  Future<void> fetchPostsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse(
          'http://$ip:9000/posts/category/$category')); // Pass uid as a query parameter
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Parse the JSON data and create a list of Post objects
          posts = (data as List).map((model) => Post.fromJson(model)).toList();
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
        throw Exception('Failed to load posts by category');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }

  Future<void> fetchSeasons(int postId) async {
    try {
      final response =
          await http.get(Uri.parse('http://$ip:9000/seasons?postId=$postId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Find the post that matches the postId
          final post = posts.firstWhere((post) => post.id == postId);

          // Parse the JSON data and create a list of Seasons objects
          post.seasons =
              (data as List).map((model) => Seasons.fromJson(model)).toList();
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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2); // Two tabs
    fetchPostsByCategory(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text('Two Unique Tabs Example'),
          toolbarHeight: 30,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Itinerary'), // First tab label
              Tab(text: 'Suggestions'), // Second tab label
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, 
            children: [
          // Content for Tab 1
              posts.isEmpty
                  ? Center(
                child: Text('No posts available.'),
              )
                  : Stack(
                children: [
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
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              post.description,
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.grey.shade500),
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 355,
                              width: 400,
                              color: Colors.white.withOpacity(0.1),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 30),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Duration',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          post.duration,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 30, thickness: 1),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Category',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          post.category,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 30, thickness: 1),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Budget',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        Text(
                                          '\₹${post.budget.toStringAsFixed(2)}k',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Divider(height: 30, thickness: 1),
                                    Row(
                                      children: [
                                        Text(
                                          'Seasons',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                post.showSeasons =
                                                !post.showSeasons;
                                              });
                                              if (post.showSeasons ==
                                                  true) {
                                                fetchSeasons(post.id);
                                              }
                                            },
                                            icon: post.showSeasons ==
                                                false
                                                ? Icon(
                                                Icons.arrow_drop_up)
                                                : Icon(Icons
                                                .arrow_drop_down_outlined)),
                                        ElevatedButton(
                                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green.shade200)),
                                            onPressed: () {
                                              print(post.id);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewItinerary(
                                                            duration: post
                                                                .duration,
                                                            id: post.id,
                                                            title: post
                                                                .location),
                                                  ));

                                              //fetchTimes(post.id);
                                              print(post.places);
                                            },
                                            child: Text(
                                              'View Itinerary',
                                              style:
                                              GoogleFonts.montserrat(
                                                  color: Colors.green.shade900),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    if (post.showSeasons)
                                      Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        children: post.seasons
                                            .map((seasonName) {
                                          return Chip(
                                            label: Text(
                                                seasonName.season_name),
                                            backgroundColor:
                                            Colors.green.shade200,
                                            labelStyle: TextStyle(
                                                color: Colors
                                                    .green.shade900),
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
                  ),
                ],
              ),
              Text(''),

        ]));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
