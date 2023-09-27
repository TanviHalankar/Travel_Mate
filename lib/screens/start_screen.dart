import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/widget/back.dart';
import '../login_pages/signin.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BackGround(),
        Positioned(
            top: 260,
            left: 37,
            child: Text(
              'Travel Mate',
              style:GoogleFonts.aclonica(fontSize: 40,color: Colors.white,),
            )),
        Positioned(
          top:170,
          left: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
            child: Center(
                child: Text('Connect, Explore & Share Travel Experiences',
                    style: GoogleFonts.cormorant(
                        fontSize: 15, color: Colors.white))),
          ),
        ),
        Positioned(
            bottom: 240,
            left: 80,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.8), // Set the border color
                  width: 2.0, // Set the border width
                ),
                borderRadius: BorderRadius.circular(2.0), // Set the border radius
              ),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => SignIn(),));
                },
                child: Text('GET  STARTED',style: GoogleFonts.cormorant(fontSize: 15)),
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20)),
                    foregroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.8)),
                    //backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2)),
                    backgroundColor: MaterialStatePropertyAll(Colors.transparent.withOpacity(0.4)),
                    elevation: MaterialStatePropertyAll(2),
                    overlayColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1))
                  //shadowColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2))
                ),

              ),
            ))
      ]),
    );
  }
}
