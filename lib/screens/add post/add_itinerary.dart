import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:ttravel_mate/widget/lists.dart';

import '../../db_info.dart';
import '../../widget/back.dart';
import 'create_post.dart';

class AddItinerary extends StatefulWidget {
  final String title;
  final String description;
  final List<String> season;
  final String duration;
  final DateTime? start;
  final DateTime? end;
  final String category;
  final double budget;

  AddItinerary({
    Key? key,
    required this.start,
    required this.end,
    required this.title,
    required this.duration,
    required this.description,
    required this.season,
    required this.category,
    required this.budget,
  }) : super(key: key);

  @override
  _AddItineraryState createState() => _AddItineraryState();
}

class _AddItineraryState extends State<AddItinerary>
    with TickerProviderStateMixin {
  //User? user = Provider.of<UserProvider>(context).getUser;
  late TabController _tabController;
  List<DateTime> _dates = [];
  int currentIndex = 0;
  List<List<String>> placesLists = []; // List of place lists for each tab
  List<List<String>> timesList = []; // List of time lists for each tab

  @override
  void initState() {
    super.initState();
    _initializeDates();
    _tabController = TabController(length: _dates.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _initializeDates() {
    if (widget.start != null && widget.end != null) {
      DateTime date = widget.start!;
      while (date.isBefore(widget.end!) || date.isAtSameMomentAs(widget.end!)) {
        _dates.add(date);
        placesLists.add([]); // Initialize an empty list for each date
        timesList.add([]); // Initialize an empty list for each date
        date = date.add(const Duration(days: 1));
      }
      _tabController = TabController(length: _dates.length, vsync: this);
      _tabController.addListener(_handleTabChange);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      currentIndex = _tabController.index;
    });
  }

  void addPlace(String newPlace) {
    setState(() {
      placesLists[currentIndex].add(newPlace);
    });
  }

  void addTime(String? newTime) {
    setState(() {
      timesList[currentIndex].add(newTime!);
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.start == null || widget.end == null) {
    //   return CupertinoAlertDialog(
    //     content: Text('Please select the duration'),
    //       );
    //
    // }

    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.1),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
// Create the post
//               createPost(widget.title, widget.description, widget.duration, widget.category, widget.budget)
//                   .then((postId) {
//                 // After the post is created, associate seasons with it
//                 for (String season_name in widget.season) {
//                   print(season_name);
//                   createSeason(season_name, postId);
//                 }
//               });

              //print(widget.season);
              //String title,String desc,String season,String duration,String category,double budget
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePost(
                      description: widget.description,
                      category: widget.category,
                      budget: widget.budget,
                      location: widget.title,
                      duration: widget.duration,
                      seasons: widget.season,
                      placesList: placesLists,
                      timesList: timesList,
                    ),
                  ));
            },
            child: Text('Save',
                style: GoogleFonts.montserrat(color: Colors.white)),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              height: 60,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  //color: Colors.blueGrey,
                  color: Colors.white),
              /*TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicator: BoxDecoration(
                //color: Colors.blueGrey.shade200,
                color: Colors.white,
              ),
              controller: _tabController,
              tabs: _dates
                  .map((date) => Tab(text: DateFormat('dd MMM').format(date)))
                  .toList(),
              isScrollable: true,
            ),*/
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                indicator: BoxDecoration(
                  color: Colors.orange[100],
                ),
                controller: _tabController,
                isScrollable: true,
                tabs: _dates.asMap().entries.map((entry) {
                  final date = entry.value;
                  final formattedDate = DateFormat('dd MMM').format(date);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Day ${entry.key + 1}',
                        style: GoogleFonts.montserrat(
                            fontSize: 16), // Adjust font size as needed
                      ),
                      Text(
                        formattedDate,
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight:
                                FontWeight.w300), // Adjust font size as needed
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _dates
                  .map(
                    (date) => DayView(
                      date: date,
                      currentIndex: _tabController.index,
                      placesList: placesLists,
                      timeList: timesList,
                      addPlace: addPlace,
                      addTime: addTime,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DayView extends StatefulWidget {
  final DateTime date;
  final int currentIndex;
  final List<List<String>> placesList;
  final List<List<String>> timeList;
  final Function(String) addPlace;
  final Function(String?) addTime;

  DayView({
    Key? key,
    required this.date,
    required this.currentIndex,
    required this.placesList,
    required this.timeList,
    required this.addPlace,
    required this.addTime,
  }) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  //TimeOfDay? newTime;
  TextEditingController timeController = TextEditingController();
  String? newPlace;
  String? newTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Stack(children: [
        BackGround(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.orange)),
                child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        side: MaterialStatePropertyAll(BorderSide.none)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.green[100],
                            title: Text('New Location',
                                style: GoogleFonts.montserrat(
                                    color: Colors.green)),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    controller: timeController,
                                    onTap: () async {
                                      final selectedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              // Customize the colors here
                                              primaryColor: Colors
                                                  .white, // Header background color
                                              accentColor: Colors
                                                  .black, // Highlighted color
                                              colorScheme: ColorScheme.dark(
                                                primary: Colors
                                                    .green, // Selected time color
                                                onPrimary:
                                                    Colors.black, // Text color
                                                surface: Colors
                                                    .white, // Dial background color
                                                onSurface: Colors
                                                    .black, // Dial text color
                                              ),
                                              buttonTheme: ButtonThemeData(
                                                textTheme:
                                                    ButtonTextTheme.primary,
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (selectedTime != null) {
                                        final formattedTime =
                                            selectedTime.format(context);
                                        setState(() {
                                          timeController.text = formattedTime;
                                          newTime = formattedTime;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Time',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                  ),
                                  TextField(
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (value) {
                                      setState(() {
                                        newPlace = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Place',
                                        hintStyle:
                                            TextStyle(color: Colors.black)),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (newPlace != null && newTime != null) {
                                    widget.addPlace(newPlace!);
                                    widget.addTime(newTime!);
                                    Navigator.of(context).pop();
                                    print(widget.placesList);
                                    print(widget.timeList);
                                  }
                                },
                                child: Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(LineIcons.plus, size: 15, color: Colors.white),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ADD PLACE',
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 10),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.placesList[widget.currentIndex].length,
                  itemBuilder: (context, index) {
                    return TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.2,
                        //alignment: TimelineAlign.center,
                        beforeLineStyle:
                            LineStyle(color: Colors.white, thickness: 2),
                        afterLineStyle:
                            LineStyle(color: Colors.white, thickness: 2),
                        indicatorStyle:
                            IndicatorStyle(color: Colors.white, width: 15),
                        startChild: Text(
                          '${widget.timeList[widget.currentIndex][index]}',
                          style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400),
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            padding: EdgeInsets.all(10),
                            height: 120,
                            width: 220,
                            child: Center(
                              child: Text(
                                '${widget.placesList[widget.currentIndex][index]}',
                                maxLines: 3,
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
