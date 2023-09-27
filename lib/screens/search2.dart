import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/map/map.dart';

import '../widget/back.dart';


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
      body: Column(
        children: [
          // Image with Text Overlay
          Stack(
            children: [

              Opacity(
                opacity: 0.4,
                child: Image.asset(
                  'assets/${widget.name}.png', // Replace with your image URL
                  width: double.infinity,
                  height: 250, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20, // Adjust the position of the text
                left: 20, // Adjust the position of the text
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Tab Bar
          Expanded( // Wrap the Tab Bar with Expanded
            child: DefaultTabController(
              length: 3, // Number of tabs
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Popular'),
                      Tab(text: 'Things 2 Do'),
                      Tab(text: 'Hotels'),
                    ],
                  ),
                  Expanded( // Wrap the Tab Bar View with Expanded
                    child: TabBarView(
                      children: [
                        MapPage(name: widget.name),
                        Center(child: Text('Tab 2 Content')),
                        //Center(child: Text('Tab 2 Content')),

                        Center(child: Text('Tab 3 Content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
