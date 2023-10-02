import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ttravel_mate/screens/navigation.dart';
import 'package:ttravel_mate/screens/start_screen.dart';
import '../login_pages/signup.dart';
import 'package:ttravel_mate/model/users.dart' as model;


class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    Timer(Duration(seconds: 2), () async {
      await _controller.forward().whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
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
                return StartScreen();
              },
            );
          }),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'assets/lottie/splash.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height * 1,
        animate: true,
      ),
    );
  }
}

