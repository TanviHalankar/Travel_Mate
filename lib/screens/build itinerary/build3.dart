import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'build4.dart';

class Build3 extends StatefulWidget {
  @override
  _Build3State createState() => _Build3State();
}

class _Build3State extends State<Build3> {
  DateTime? start;
  DateTime? end;
  double _budgetValue = 500.0;
  TextEditingController tripDurationController = TextEditingController();
  static const double _minBudget = 0.0;
  static const double _maxBudget = 1000.0;

  @override
  Widget build(BuildContext context) { 
    return Container(
      height: 534,
      width: MediaQuery.of(context).size.width,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'Select  ',
                  style:
                  GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8), fontSize: 25,fontWeight: FontWeight.w200),
                ),
                Text(
                  'Your',
                  style:
                  GoogleFonts.montserrat(color: Colors.orange.shade300, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Text(
                'Preference.....',
                style:
                GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8), fontSize: 25,fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(height: 80),
            //Text('Select Duration',style: GoogleFonts.montserrat(fontSize: 15,color: Colors.black)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text('Trip Duration',style: GoogleFonts.montserrat(fontSize: 15)),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text('Trip Duration',style: GoogleFonts.montserrat(fontSize: 15)),
                    SizedBox(height: 10,),
                    TextFormField(
                      readOnly: true,
                      controller: tripDurationController,
                      onTap: () async {
                        var selectedRange =
                        await showCalendarDatePicker2Dialog(
                          context: context,
                          config:
                          CalendarDatePicker2WithActionButtonsConfig(
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
                        //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
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
              ],
            ),
            SizedBox(height: 60),
            //Divider(height: 20,color: Colors.white.withOpacity(0.3),thickness: 1),
            //Text('Select Budget',style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white)),

            Text(
              'Budget: ${_budgetValue.toInt()}k', // Display value in thousands
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 15,color: Colors.white),
            ),
            Slider(
              activeColor: Colors.blueGrey.shade200,
              inactiveColor:Colors.blueGrey.shade800 ,
              value: _budgetValue,
              min: _minBudget,
              max: _maxBudget,
              onChanged: (value) {
                setState(() {
                  _budgetValue = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\₹1000',style: GoogleFonts.montserrat(fontSize: 10,color: Colors.white),),
                Text('\₹10,00,000',style: GoogleFonts.montserrat(fontSize: 10,color: Colors.white),),
              ],
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => Build4(),));
            //   },
            //   style: ElevatedButton.styleFrom(primary: Colors.purple.shade100),
            //   child: Text(
            //     'Continue',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
          ],
        ),

    );
  }


}
