import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ttravel_mate/screens/navigation.dart';
import 'package:ttravel_mate/screens/start_screen.dart';
import '../login_pages/signup.dart';
import 'package:ttravel_mate/model/users.dart' as model;


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();
    //addData();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StreamBuilder(
              stream: FirebaseAuth.instance
                  .authStateChanges(), //runs when user has signed in or signed out
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    print(snapshot);
                    return Navigation();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StartScreen();
              },
            ),
          ));
    });
  }

  /*
  addData() async{
    UserProvider _userProvider = Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  */
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Container(
        //color: Colors.black,
        child: const Center(
          child: Image(image: AssetImage('assets/splash.png')),
        ),
      ),
    );
  }
/*
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }
*/
}
