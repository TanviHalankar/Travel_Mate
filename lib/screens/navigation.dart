
import 'dart:ui';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ttravel_mate/screens/navigation/home_page.dart';
import 'add post/add_post.dart';
import 'build itinerary/build.dart';
import 'navigation/fav.dart';
import 'navigation/noti.dart';
import 'navigation/search.dart';
import 'package:ttravel_mate/model/users.dart' as model;

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}
int _bottomNavIndex = 0;
final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
String? uid=user?.uid;
//model.User? uid = Provider.of<UserProvider>(context).getUser;

class _NavigationState extends State<Navigation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final List<Widget> _pages = [
    //HomePage(),
    HomePage2(),
    //Home(),
    Fav(uid: uid),
    //MapPage(),
    Search(),
    NotificationPage(),
  ];
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
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
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPost(),
                              ));
                        },
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/add_iti.png',
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'ADD TRIP',
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
                        onTap: () {
                          //print(uid);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StepperScreen(),
                              ));
                        },
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/build_iti.png',
                                  ),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'BUILD ITINERARY',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      //backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _bottomNavIndex,
                  children: _pages,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          _showModalBottomSheet(context);
        },
        child: Icon(LineIcons.plus, color: Colors.white,size: 35),
        //backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.blueGrey.shade200,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          LineIcons.home,
          LineIcons.heart,
          LineIcons.search,
          LineIcons.bell,
        ],
        elevation: 20,
        activeIndex: _bottomNavIndex,
        backgroundColor: Colors.blueGrey[800],
        //backgroundColor: Colors.teal[900],
        //backgroundColor: Colors.white.withOpacity(0.9),
        //backgroundColor: Colors.black,
        //activeColor: Colors.blue[900],
        //activeColor: Colors.green[200],
        activeColor: Colors.blueGrey.shade200,
        inactiveColor: Colors.black,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        height: 60,
      ),
    );
  }
}
