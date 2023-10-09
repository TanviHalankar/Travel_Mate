import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../db_info.dart';
import '../../widget/back.dart';
import '../../widget/lists.dart';
import 'add_itinerary.dart';

class AddPost extends StatefulWidget {

  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  DateTime? start;
  DateTime? end;
  String selectedValue = 'Adventure';
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController tripDurationController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  //double _minBudget = 1000;
  //double _maxBudget = 5000;

  double _budgetValue = 500.0;
  static const double _minBudgetValue = 0.0;
  static const double _maxBudgetValue = 1000.0; // Represents 100k

  FocusNode textFieldFocusNode = FocusNode();

  bool showSuggestions = false;


  @override
  void initState() {
    super.initState();
    selectedSeasons.clear();
    // Add a listener to the FocusNode to detect when TextField gets focus
    textFieldFocusNode.addListener(() {
      if (textFieldFocusNode.hasFocus) {
        setState(() {
          showSuggestions = true;
        });
      }
    });
  }


  @override
  void dispose() {
    // Dispose the FocusNode when done
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            //title: Text('New Post',style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w400)),
            backgroundColor: Colors.black.withOpacity(0.2),
            elevation: 0,
            shadowColor: Colors.transparent),
        //backgroundColor: Colors.white,
        body: Stack(
          children:[
            //BackGround(),
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                //Text('NEW POST',style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.bold)),
                //SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text('Title',style: GoogleFonts.montserrat(fontSize: 15)),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        TextField(
                          cursorColor: Colors.white,
                          style: GoogleFonts.montserrat(),
                          controller: titleController,
                          focusNode:
                              textFieldFocusNode, // Associate the FocusNode
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(color: Colors.grey), // Change this color
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              LineIcons.pen,
                              color: Colors.grey,
                            ),
                            labelText: 'Location',
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (value) {
                            // Filter the list of places based on user input
                            filteredPlaces = places
                                .where((place) => place
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            setState(() {
                              showSuggestions = true;
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              showSuggestions = false;
                            });
                          },
                          onTap: () {
                            setState(() {
                              showSuggestions = false;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Stack(children: [
                      Column(
                        children: [
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text('Description',style: GoogleFonts.montserrat(fontSize: 15)),
                              //SizedBox(height: 3,),
                              TextFormField(
                                cursorColor: Colors.white,
                                controller: descController,
                                maxLines: 2,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color: Colors.grey), // Change this color
                                    ),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.edit_note,color: Colors.grey,),
                                    labelText: 'Description',
                                    labelStyle: TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text('Select Season',style: GoogleFonts.montserrat(fontSize: 15)),
                              Text('(seasons you would recommend)',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green.shade100)),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 100,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      CardItem(
                                          imageUrl: 'assets/summer.png',
                                          title: 'Summer',
                                        season: 'Summer',

                                      ),
                                      CardItem(
                                          imageUrl: 'assets/winter.png',
                                          title: 'Winter',
                                        season: 'Winter',

                                      ),
                                      CardItem(
                                          imageUrl: 'assets/monsoon.png',
                                          title: 'Monsoon',
                                      season: 'Monsoon',
                                        ),
                                      CardItem(
                                          imageUrl: 'assets/spring.png',
                                          title: 'Spring',
                                      season: 'Spring',
                                       ),
                                      CardItem(
                                          imageUrl: 'assets/fall.png',
                                          title: 'Fall',
                                      season: 'Fall',
                                        ),
                                    ],
                                  )),
                              /*DropdownButtonFormField<String>(
                            value: selectedValue,
                            items: seasons.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder()
                              //labelText: 'Season',
                            ),
                            style: TextStyle(color: Colors.grey),
                          ),*/
                            ],
                          ),
                          SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text('Trip Duration',style: GoogleFonts.montserrat(fontSize: 15)),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                readOnly: true,
                                controller: tripDurationController,
                                onTap: () async {
                                  var selectedRange =
                                      await showCalendarDatePicker2Dialog(
                                    context: context,
                                    config:
                                        CalendarDatePicker2WithActionButtonsConfig(
                                          lastDate: DateTime.now().subtract(Duration(days: 1)),
                                      cancelButtonTextStyle:
                                          TextStyle(color: Colors.white60),
                                      controlsTextStyle:
                                          TextStyle(color: Colors.black),
                                      dayTextStyle:
                                          TextStyle(color: Colors.white60),
                                      selectedDayHighlightColor:
                                          Colors.green[200],
                                      weekdayLabelTextStyle:
                                          TextStyle(color: Colors.green[200]),
                                      //yearTextStyle: TextStyle(color: Colors.green[200],),

                                      calendarType: CalendarDatePicker2Type.range,

                                    ),
                                    dialogSize: Size(325, 400),
                                  );
                                  if (selectedRange != null) {
                                    start = selectedRange.first;
                                    end = selectedRange.last;
                                    final duration =
                                        (end?.difference(start!)?.inDays ?? 0) +
                                            1;

                                    setState(() {
                                      tripDurationController.text =
                                          '$duration days';
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(color: Colors.grey), // Change this color
                                    ),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),
                                    labelText: 'Trip Duration',
                                    labelStyle: TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text('Category',style: GoogleFonts.montserrat(fontSize: 15)),
                              SizedBox(
                                height: 10,
                              ),
                              /*TextFormField(
                            readOnly: true,
                            controller: titleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Category',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.category,color: Colors.grey,)
                            ),
                          ),*/
                              DropdownButtonFormField<String>(
                                //dropdownColor: Colors.black.withOpacity(0.9),
                                dropdownColor: Colors.white,
                                //hint: Text('Category',style: GoogleFonts.montserrat(color: Colors.white)),
                                value: selectedValue,
                                items: categories.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.montserrat(color: Colors.black),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                decoration:
                                    InputDecoration(border: OutlineInputBorder()
                                        //labelText: 'Season',
                                        ),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Text('Budget',style: GoogleFonts.montserrat(fontSize: 15)),
                          SizedBox(height: 20,),
                          Center(
                            child: Text(
                              '\₹${_minBudget.toInt()}  -  \₹${_maxBudget.toInt()}',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          RangeSlider(
                            values: RangeValues(_minBudget, _maxBudget),
                            min: 1000,
                            max: 1000000,
                            onChanged: (values) {
                              setState(() {
                                _minBudget = values.start;
                                _maxBudget = values.end;
                              });
                            },
                            divisions:20,
                            activeColor: Colors.grey,
                            inactiveColor: Colors.grey.shade100,
                          ),
                    ],
                  ),*/
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //Text('Budget',style: GoogleFonts.montserrat(fontSize: 15)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Budget: ${_budgetValue.toInt()}k', // Display value in thousands
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 15, color: Colors.green.shade100),
                              ),
                              Slider(
                                value: _budgetValue,
                                min: _minBudgetValue,
                                max: _maxBudgetValue,
                                activeColor: Colors.grey,
                                inactiveColor: Colors.grey.shade200,
                                onChanged: (value) {
                                  setState(() {
                                    _budgetValue = value;
                                  });
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\₹1000',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 10)),
                                  Text('\₹10,00,000',
                                      style:
                                          GoogleFonts.montserrat(fontSize: 10)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                //color: Colors.grey,
                                child: ElevatedButton(
                                  onPressed: () {

                                    //createPost(titleController.text,'yo',descController.text,tripDurationController.text,categoryController.text,_budgetValue);
                                    //titleController.clear();
                                    //descController.clear();
                                    //print(selectedSeasons);
                                    if(titleController.text.isNotEmpty && descController.text.isNotEmpty && selectedSeasons.isNotEmpty &&tripDurationController.text.isNotEmpty )
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddItinerary(
                                                start: start,
                                                end: end,
                                                title: titleController.text,
                                                duration: tripDurationController.text,
                                                budget: _budgetValue,
                                                category: selectedValue,
                                                description: descController.text,
                                                season: selectedSeasons,
                                            ),
                                          ),
                                        );
                                      }
                                    else{

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text('Please Fill All The Details!',style: GoogleFonts.montserrat(color: Colors.black)),
                                          backgroundColor: Colors.white,
                                        ),
                                      );
                                    }

                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.green.shade100)),
                                  child: Text('Add Itinerary',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (showSuggestions)
                        Container(
                          decoration:
                              BoxDecoration(color:Colors.white),
                          constraints: BoxConstraints(
                              maxHeight:
                                  300), // Set a maximum height for the suggestions
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredPlaces.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.location_on,size: 15,color: Colors.black,),
                                    SizedBox(width: 10,),
                                    Text(filteredPlaces[index],
                                        style: GoogleFonts.montserrat(
                                            color: Colors.black)),
                                  ],
                                ),
                                onTap: () {
                                  titleController.text = filteredPlaces[index];
                                  // Set showSuggestions to false when a suggestion is selected
                                  setState(() {
                                    showSuggestions = false;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                    ]),
                  ],
                ),
              ]),
            ),
          ),]
        ),
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String season;
  //final List<String>selectedSeasons;

  CardItem({required this.imageUrl, required this.title, required this.season, });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isSelected = false;
  //List<String> selectedSeasons = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle the selection state
          if (isSelected) {
            selectedSeasons.add(widget.season); // Add the season to the list if selected
          } else {
            selectedSeasons.remove(widget.season); // Remove the season if deselected
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  color: Colors.green.shade200,
                  width: 2.0) // Add border if selected
              : null,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ColorFiltered(
                  colorFilter: isSelected
                      ? ColorFilter.mode(Colors.transparent, BlendMode.dst)
                      : ColorFilter.mode(Colors.black, BlendMode.saturation),
                  child: Image.asset(
                    widget.imageUrl,
                    width: 80,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isSelected)
                  Positioned(
                      child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade200,
                  ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
