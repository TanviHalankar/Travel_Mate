import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/screens/navigation.dart';
import 'package:ttravel_mate/widget/back.dart';

import '../../db_info.dart';

class CreatePost extends StatelessWidget {
  final String location;
  final String description;
  final String duration;
  final String category;
  final double budget;
  final DateTime? start;
  final DateTime? end;
  final List<String> seasons;
  final List<List<String>> placesList;
  final List<List<String>> timesList;

  CreatePost({
    required this.location,
    required this.description,
    required this.duration,
    required this.category,
    required this.budget,
    required this.seasons,
    required this.placesList,
    required this.timesList,
    this.start,
    this.end,
  });


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid=user?.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        shadowColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              createPost(location, description, duration, category, budget,uid!)
                  .then((postId) {
                // After the post is created, associate seasons with it
                for (String season_name in seasons) {
                  print(season_name);
                  createSeason(season_name, postId);
                }
                createItinerary(postId, duration, location,uid).
                then((itiId) {
                  for (int day = 0; day < placesList.length; day++) {
                    // Add places for the current day
                    for (String placeName in placesList[day]) {
                      createPlaces(itiId,day+1, placeName);
                      //createPlace(postId,placeName,duration,itiId);
                    }

                    // Add times for the current day
                    for (String timeInfo in timesList[day]) {
                      createTimes(itiId,day+1, timeInfo);
                    }
                  }
                });
              });

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Navigation(),
                  ));
            },
            child: Text('POST',
                style: GoogleFonts.montserrat(color: Colors.white)),
          )
        ],
      ),
      body: Stack(
        // Use Stack for overlaying widgets
        children: [
          // Background Image
          BackGround(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '$location',
                    style: GoogleFonts.montserrat(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.grey.shade500),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 325,
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
                                '$duration',
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
                                '$category',
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
                                '\₹${budget.toStringAsFixed(2)}',
                                style: GoogleFonts.montserrat(fontSize: 15),
                              ),
                            ],
                          ),
                          Divider(height: 30, thickness: 1),
                          Text(
                            'Seasons',
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: seasons.map((season) {
                              return Chip(
                                label: Text(season),
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
            ),
          ),
        ],
      ),
    );
  }
}
