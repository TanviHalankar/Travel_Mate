import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:timeline_tile/timeline_tile.dart';
import 'package:ttravel_mate/widget/back.dart';

import '../../db_info.dart';

class ViewItinerary extends StatefulWidget {
  final String duration;
  final int id;
  final String title;
  const ViewItinerary({Key? key, required this.duration, required this.id,required this.title}) : super(key: key);

  @override
  State<ViewItinerary> createState() => _ViewItineraryState();
}

class _ViewItineraryState extends State<ViewItinerary> {
  List<Map<String, dynamic>> placesData = [];
  List<Map<String, dynamic>> timesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchPlacesData(int postId) async {
    final response = await http.get(Uri.parse('http://$ip:9000/places?postId=$postId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load places data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTimesData(int postId) async {
    final response = await http.get(Uri.parse('http://$ip:9000/times?postId=$postId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load times data');
    }
  }

  Future<void> fetchData() async {
    try {
      final fetchedPlacesData = await fetchPlacesData(widget.id);
      final fetchedTimesData = await fetchTimesData(widget.id);

      setState(() {
        placesData = fetchedPlacesData; // Store the fetched placesData in the instance variable
        timesData = fetchedTimesData;
      });

      final List<String> placeNames = placesData.map((place) => place['place'] as String).toList();

      // Use the fetched data as needed.
      print('Places Data: $placesData');
      print('Times Data: $timesData');
      print(placeNames);
    } catch (e) {
      // Handle errors here.
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = 0;
    int duration = 0;
    List<int> _dates = [];

    String input = widget.duration;
    List<String> parts = input.split(' ');
    if (parts.length >= 2) {
      try {
        duration = int.parse(parts.first);
        print('Extracted number: $duration');
      } catch (e) {
        print('Failed to extract number.');
      }
    } else {
      print('String does not contain a number and a unit.');
    }

    List<Tab> generateTabs(int duration) {
      List<Tab> tabs = [];
      for (int i = 1; i <= duration; i++) {
        tabs.add(Tab(text: 'Day $i'));
        _dates.add(i);
      }

      return tabs;
    }

    List<Tab> tabs = generateTabs(duration);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: Text(widget.title,style: GoogleFonts.montserrat()),
      ),
      body: DefaultTabController(
      length: duration,
      child: SafeArea(
        child: Stack(
          children: [
            BackGround(),
            Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              toolbarHeight: 3,
              bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                indicator: BoxDecoration(
                  color: Colors.orange[100],
                ),
                isScrollable: true,
                tabs: _dates.asMap().entries.map((entry) {
                  return Tab(
                    text: 'Day ${entry.key + 1}',
                  );
                }).toList(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBarView(
                children: List.generate(duration, (dayIndex) {
                  // Filter places for the current day (dayIndex + 1)
                  final placesForDay = placesData.where((place) => place['dayNum'] == dayIndex + 1).toList();
                  final timesForDay = timesData.where((time) => time['dayNum'] == dayIndex + 1).toList();

                  // Create a list of widgets for places
                  final placeWidgets = placesForDay.map((place) {
                    final correspondingTime = timesForDay.firstWhere(
                          (time) => time['postId'] == place['postId'] && time['dayNum'] == place['dayNum'],
                      orElse: () => {'time': 'No time'}, // A default value if no corresponding time is found
                    );
                    return Padding(
                      padding: const EdgeInsets.only(left: 20,right: 13,top: 20),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox(height: 20),
                          //Image(image: AssetImage('assets/location.png'), height: 30),
                          Text(
                            place['place'] as String, // Extract 'place' value
                            style: GoogleFonts.montserrat(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                           correspondingTime['time'] as String, // Extract 'place' value
                            style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    );
                  }).toList();
                  return ListView.builder(
                    itemCount: placeWidgets.length,
                    itemBuilder: (context, index) {
                      return TimelineTile(
                        beforeLineStyle: LineStyle(color: Colors.white),
                        afterLineStyle: LineStyle(color: Colors.white),
                        indicatorStyle: IndicatorStyle(color: Colors.white, width: 30),
                        endChild: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 20, top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 90,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                children: [
                                  placeWidgets[index], // Add the widgets for places
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        ]
        ),
      ),
        ),
    );
  }
}
