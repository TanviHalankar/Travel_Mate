import 'dart:typed_data';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttravel_mate/db_info.dart';
import 'package:ttravel_mate/widget/back.dart';

import '../../utils/utils.dart';
import '../add post/add_post.dart';
import '../build itinerary/build.dart';

class CreateTrip extends StatefulWidget {
  @override
  State<CreateTrip> createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController tripDurationController = TextEditingController();
  String age1 = '18';
  String age2 = '30';
  DateTime? start;
  DateTime? end;
  Uint8List? _image;

  List<String> ageList = List.generate(33, (index) {
    if (index == 32) {
      return '50+';
    } else {
      return (18 + index).toString();
    }
  });

  // void selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = im;
  //   });
  // }
  Future<void> _selectImage() async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
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
                            onTap: () async {
                              Navigator.pop(context);
                                Uint8List im = await pickImage(ImageSource.camera);
                                setState(() {
                                  _image = im;
                                });
                            },
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3004/3004613.png?ga=GA1.1.2014633652.1690347742&track=ais'),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'CAMERA',
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
                            onTap: () async {
                              Navigator.pop(context);
                                Uint8List im = await pickImage(ImageSource.gallery);
                                setState(() {
                                  _image = im;
                                });
                            },
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                  image: NetworkImage('https://cdn-icons-png.flaticon.com/128/3342/3342137.png?ga=GA1.1.2014633652.1690347742&track=ais'),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'GALLERY',
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
        //   Row(
        //   children: [GestureDetector(
        //     child: Text('Take a picture'),
        //     onTap: () async {
        //       Navigator.pop(context);
        //         Uint8List im = await pickImage(ImageSource.camera);
        //         setState(() {
        //           _image = im;
        //         });
        //     },
        //   ),
        //   Padding(padding: EdgeInsets.all(8.0)),
        //   GestureDetector(
        //     child: Text('Choose from gallery'),
        //     onTap: () async {
        //       Navigator.pop(context);
        //         Uint8List im = await pickImage(ImageSource.gallery);
        //         setState(() {
        //           _image = im;
        //         });
        //     },
        //   ),
        // ]
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid=user?.uid;
    return Scaffold(
        appBar: AppBar(
            //title: Text('Add Trip Details'),
            ),
        body: Stack(children: [
          // BackGround(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectImage(),
                    child: Container(
                        decoration: BoxDecoration(
                            image: _image==null?DecorationImage(
                                image: NetworkImage(
                                    'https://img.freepik.com/free-vector/slr-camera-grunge-tshirt-design-hand-drawn-sketch-vector-illustration_460848-14467.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph'),
                                fit: BoxFit.cover,
                                opacity: 0.1):DecorationImage(image: MemoryImage(_image!),fit: BoxFit.cover)),
                        height: 250,
                        width: 400,
                        child: _image==null?Center(
                            child: Text(
                          'Cover Photo',
                          style: GoogleFonts.montserrat(
                              fontSize: 20, color: Colors.grey),
                        )):null),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: titleController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.edit),
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.grey)),
                  ),
                  //SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text('Trip Duration',style: GoogleFonts.montserrat(fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: tripDurationController,
                        readOnly: true,
                        onTap: () async {
                          var selectedRange =
                              await showCalendarDatePicker2Dialog(
                            context: context,
                            config: CalendarDatePicker2WithActionButtonsConfig(
                              cancelButtonTextStyle:
                                  TextStyle(color: Colors.white60),
                              controlsTextStyle: TextStyle(color: Colors.black),
                              dayTextStyle: TextStyle(color: Colors.white60),
                              selectedDayHighlightColor: Colors.green[200],
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
                                (end?.difference(start!)?.inDays ?? 0) + 1;

                            setState(() {
                              tripDurationController.text = '$duration days';
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                            ),
                            labelText: 'Trip Duration',
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10),
                  //   child: Text('Age-Group',style: GoogleFonts.montserrat(fontWeight: FontWeight.w300,fontSize: 10),),
                  // ),
                  // DropdownButtonFormField<String>(
                  //   hint: Text('Age-Group'),
                  //   items: ['18-25', '26-35', '36-50', '50+']
                  //       .map((ageGroup) => DropdownMenuItem<String>(
                  //     value: ageGroup,
                  //     child: Text(ageGroup),
                  //   ))
                  //       .toList(),
                  //   onChanged: (selectedAgeGroup) {
                  //     // TODO: Handle age group selection
                  //   },
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 160,
                        child: DropdownButtonFormField<String>(
                          //hint: Text('18'),
                          items: ageList
                              .map((ageGroup) => DropdownMenuItem<String>(
                                    value: ageGroup,
                                    child: Text(ageGroup),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              age2 = value!;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Text(
                        ' --- ',
                        style: TextStyle(fontSize: 10),
                      ),
                      Container(
                        width: 160,
                        child: DropdownButtonFormField<String>(
                          hint: Text('18'),
                          items: ageList
                              .map((ageGroup) => DropdownMenuItem<String>(
                                    value: ageGroup,
                                    child: Text(ageGroup),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              age2 = value!;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  //Divider(color: Colors.grey,height: 30),
                  //Text('Add Description',style: GoogleFonts.montserrat()),
                  Container(
                    color: Colors.white.withOpacity(0.1),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Add Description',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, color: Colors.grey)),
                        ),
                        TextFormField(
                          controller: descController,
                          cursorColor: Colors.white,
                          maxLines: 15,
                          // decoration: InputDecoration(
                          //     border: OutlineInputBorder(),
                          //     //suffixIcon: Icon(Icons.edit_note),
                          // ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.white.withOpacity(0.3))),
                        onPressed: () {
                          createTrips(titleController.text, descController.text, start.toString(), end.toString(), age1, age2, uid!,_image);
                        },
                        child: Text(
                          'ADD ITINERARY',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}

// import 'package:flutter/material.dart';
// class CreateTrip extends StatelessWidget {
//   const CreateTrip({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Text('Cover photo'),
//           Text('Trip Title'),
//           Text('Trip Desc'),
//           Text('Trip start and end date'),
//           Text('Trip itinerary'),
//           Text('Age Group')
//         ],
//       ),
//     );
//   }
// }
