import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttravel_mate/auth/signin.dart';
import 'package:ttravel_mate/auth/signup.dart';
import 'package:ttravel_mate/auth/welcome.dart';
import 'package:ttravel_mate/login_pages/signin.dart';
import 'package:ttravel_mate/screens/navigation.dart';
import 'package:ttravel_mate/screens/splash_screen.dart';
import 'package:ttravel_mate/themes/dark_theme.dart';
import 'package:ttravel_mate/themes/light_theme.dart';
import 'package:ttravel_mate/user_provider.dart';

import 'firebase_options.dart';




void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Travel Mate',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,

        home: const SplashScreenPage(),
      ),
    );
  }
}


