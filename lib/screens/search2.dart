import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/map/map.dart';
import 'package:ttravel_mate/screens/navigation/tripsPage.dart';

import '../db_info.dart';
import '../widget/back.dart';
import 'navigation/tripsPage2.dart';


class Search2 extends StatefulWidget {
  String name;
  Search2({Key? key,required this.name}) : super(key: key);

  @override
  State<Search2> createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/${widget.name}.png',
              fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black,
                ],
              ),
            ),
          ),
          Positioned(left:70,bottom:500,child: Text(widget.name,style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 40),)),
          Positioned(
            bottom: 50,
              height: 300,
              child: Container(
            width: 500,
            height: 200,
            color: Colors.white,
          ))

          // Opacity(
          //   opacity: 0.4,
          //   child: Image.asset(
          //     'assets/${widget.name}.png', // Replace with your image URL
          //     width: double.infinity,
          //     height: 250, // Adjust the height as needed
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // Positioned(
          //   bottom: 20, // Adjust the position of the text
          //   left: 20, // Adjust the position of the text
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         widget.name,
          //         style: GoogleFonts.montserrat(
          //           color: Colors.white,
          //           fontSize: 40,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
