import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/login_pages/signin.dart';
import 'package:ttravel_mate/screens/category_search.dart';
import 'package:ttravel_mate/screens/navigation.dart';
import 'package:ttravel_mate/screens/navigation/user_profile.dart';
import 'package:ttravel_mate/screens/search2.dart';
import 'package:ttravel_mate/widget/back.dart';
import 'package:ttravel_mate/model/users.dart' as model;
import 'package:http/http.dart' as http;

import '../../data/locations.dart';
import '../../model/users.dart';
import '../../widget/lists.dart';
import '../../widget/locations_widget.dart';

import '../../widget/image_card.dart';
import '../../db_info.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_carousel_slider/carousel_slider.dart' as c;
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final List<NetworkImage> colors = [
   NetworkImage('https://img.freepik.com/free-photo/high-angle-shot-bandra-worli-sealink-mumbai-enveloped-with-fog_181624-6592.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
    NetworkImage('https://img.freepik.com/free-photo/beautiful-wide-shot-eiffel-tower-paris-surrounded-by-water-with-ships-colorful-sky_181624-5118.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
    NetworkImage('https://img.freepik.com/free-photo/beautiful-shot-small-village-surrounded-by-lake-snowy-hills_181624-37802.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
    NetworkImage('https://img.freepik.com/premium-photo/houseboat-alappuzha-backwaters-kerala_78361-13098.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
  ];
  final List<String> letters = [
    "Mumbai",
    "Paris",
    "Austria",
    "Kerala",
  ];

  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();

  List<Users> users=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    String? uid=user?.uid;
    fetchUsers(uid);
  }

  Future<void> fetchUsers(String? uid) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/users/$uid')); // Pass uid as a query parameter
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
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body:Stack(
        children:[
          //BackGround(),
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (users.isNotEmpty) // Check if users list is not empty
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WELCOME  ',style: GoogleFonts.aboreto(fontSize: 35)),
                          Text('${users[0].username}',style: GoogleFonts.aboreto(fontSize: 30,color: Colors.green.shade200))
                        ],
                      ),
                    
                    CircleAvatar(
                      radius: 30, // Adjust the radius as needed
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
                          child: Image.network(
                            'https://img.freepik.com/premium-photo/woman-female-young-adult-girl-abstract-minimalist-face-portrait-digital-generated-illustration-cover_840789-1569.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=ais',
                            //'https://img.freepik.com/premium-photo/man-wearing-sunglasses-shirt-with-white-collar_14117-15974.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=ais',
                            width: 100, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                            fit: BoxFit.cover, // Fit the image within the circle
                          ),
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 250,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 250,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: c.CarouselSlider.builder(
                                key: _sliderKey,
                                unlimitedMode: true,
                                slideBuilder: (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Search2(name: letters[index]),));
                                    },
                                    child: Container(
                                      color: Colors.black,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: colors[index],opacity: 0.8,fit: BoxFit.cover)
                                        ),
                                        child: Text(
                                          letters[index],
                                          style: GoogleFonts.montserrat(fontSize: 40, color: Colors.white,fontWeight: FontWeight.w300),
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
                                itemCount: colors.length),
                          ),


                        ],
                      ),
                    ),
                  ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('Categories',style: GoogleFonts.montserrat()),
            // ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CategorySearch(title: categories[index]),));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(image: images2[index],fit: BoxFit.cover,opacity: 0.5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 200.0, // Width of each card
                          height: 120.0, // Height of each card
                          child: Center(
                            child: Text(
                              categories[index],
                              style: GoogleFonts.montserrat(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     color: Colors.white,
                //     child: Stack(
                //       children: [
                //         Container(height: 200,
                //       decoration: BoxDecoration(
                //         image: DecorationImage(fit: BoxFit.cover,opacity: 0.8,image: NetworkImage('https://img.freepik.com/free-photo/sunrise-vasco-da-gama-bridge-lisbon-portugal_268835-1338.jpg?size=626&ext=jpg&ga=GA1.2.2014633652.1690347742&semt=sph'))
                //       )),
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 70),
                //           child: Text('Mumbai',style: GoogleFonts.montserrat(fontSize: 30)),
                //         ),
                //       ]
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 25,
                ),
                LocationsWidget(),

              ],
            ),
          ),
        ),]
      ),
    ),
  );
}