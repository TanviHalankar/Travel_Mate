import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttravel_mate/screens/navigation.dart';
import 'package:ttravel_mate/widget/back.dart';

import '../../db_info.dart';
import '../../utils/utils.dart';

class CreatePost extends StatefulWidget {
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
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Uint8List? _image;

  Future<void> _selectImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: -15,
                  child: Container(
                    width: 60,
                    height: 7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(0.8)),
                  )),
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20),
                        topStart: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          Uint8List im = await pickImage(ImageSource.camera);
                          setState(() {
                            _image = im;
                          });
                        },
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3004/3004613.png?ga=GA1.1.2014633652.1690347742&track=ais'),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'CAMERA',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                )
                              ],
                            ),
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pop(context);
                          Uint8List im = await pickImage(ImageSource.gallery);
                          setState(() {
                            _image = im;
                          });
                        },
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3342/3342137.png?ga=GA1.1.2014633652.1690347742&track=ais'),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'GALLERY',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black),
                                )
                              ],
                            ),
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            )),
                      ),
                    ],
                  )),
            ]);
        //   Row(
        //   children: [GestureDetector(
        //     child: Text('Take a picture'),
        //     onTap: () async {
        //       Navigator.pop(context);
        //         Uint8List im = await pickImage(ImageSource.camera);
        //         setState(() {
        //           _image = im;
        //         });
        //     },
        //   ),
        //   Padding(padding: EdgeInsets.all(8.0)),
        //   GestureDetector(
        //     child: Text('Choose from gallery'),
        //     onTap: () async {
        //       Navigator.pop(context);
        //         Uint8List im = await pickImage(ImageSource.gallery);
        //         setState(() {
        //           _image = im;
        //         });
        //     },
        //   ),
        // ]
        // );
      },
    );
  }
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
              // if(widget.location.isNotEmpty&&widget.description.isNotEmpty&&widget.duration.isNotEmpty&&widget.category.isNotEmpty&&_image!=null)
              // {
              //   createPost(widget.location, widget.description, widget.duration, widget.category, widget.budget,uid!,_image)
              //       .then((postId) {
              //     // After the post is created, associate seasons with it
              //     for (String season_name in widget.seasons) {
              //       print(season_name);
              //       createSeason(season_name, postId);
              //     }
              //     createItinerary(postId, widget.duration, widget.location,uid).
              //     then((itiId) {
              //       for (int day = 0; day < widget.placesList.length; day++) {
              //         // Add places for the current day
              //         for (String placeName in widget.placesList[day]) {
              //           createPlaces(itiId,day+1, placeName);
              //           //createPlace(postId,placeName,duration,itiId);
              //         }
              //
              //         // Add times for the current day
              //         for (String timeInfo in widget.timesList[day]) {
              //           createTimes(itiId,day+1, timeInfo);
              //         }
              //       }
              //     });
              //   });
              //   Navigator.pop(context);
              //   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TripsPage(),));
              // }
              // else{
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       duration: Duration(seconds: 1),
              //       content: Text('Please Fill All The Details!',style: GoogleFonts.montserrat(color: Colors.white)),
              //       backgroundColor: Colors.blueGrey.shade600,
              //     ),
              //   );
              // }

              createPost(widget.location, widget.description, widget.duration, widget.category, widget.budget,uid!,_image)
                  .then((postId) {
                // After the post is created, associate seasons with it
                for (String season_name in widget.seasons) {
                  print(season_name);
                  createSeason(season_name, postId);
                }
                createItinerary(postId, widget.duration, widget.location,uid).
                then((itiId) {
                  for (int day = 0; day < widget.placesList.length; day++) {
                    // Add places for the current day
                    for (String placeName in widget.placesList[day]) {
                      createPlaces(itiId,day+1, placeName);
                      //createPlace(postId,placeName,duration,itiId);
                    }

                    // Add times for the current day
                    for (String timeInfo in widget.timesList[day]) {
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
                    '${widget.location}',
                    style: GoogleFonts.montserrat(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.grey.shade500),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _selectImage(),
                    child: Container(
                        decoration: BoxDecoration(
                            image: _image==null?DecorationImage(
                                image: NetworkImage(
                                    'https://img.freepik.com/free-vector/slr-camera-grunge-tshirt-design-hand-drawn-sketch-vector-illustration_460848-14467.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
                                fit: BoxFit.cover,
                                opacity: 0.1):DecorationImage(image: MemoryImage(_image!),fit: BoxFit.cover)),
                        height: 250,
                        width: 400,
                        child: _image==null?Center(
                            child: Text(
                              'Add Cover Photo',
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, color: Colors.grey),
                            )):null),
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
                                '${widget.duration}',
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
                                '${widget.category}',
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
                                '\₹${widget.budget.toStringAsFixed(2)}k',
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
                            children: widget.seasons.map((season) {
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
