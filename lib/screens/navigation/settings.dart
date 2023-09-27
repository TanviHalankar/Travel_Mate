import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/widget/back.dart';

import '../../login_pages/auth_methods.dart';
import '../../model/users.dart';
import '../start_screen.dart';

class Settings extends StatefulWidget {
  List<Users> users;
  Settings({Key? key,required this.users}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children:[
            BackGround(),
            Padding(
            padding: EdgeInsets.only(right: 10,left: 10,top: 200),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: 400,
                  color: Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Username',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.users[0].username,
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(height: 30, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.users[0].email,
                              style: GoogleFonts.montserrat(fontSize: 12),
                            ),
                          ],
                        ),
                        Divider(height: 30, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Country',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.users[0].country,
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ],
                        ),
                        Divider(height: 30, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.users[0].phone_num,
                              style: GoogleFonts.montserrat(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange.withOpacity(0.3))),
                      onPressed: ()async{
                    await AuthMethods().signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StartScreen(),));
                  }, child: Text('LOGOUT',style: GoogleFonts.montserrat(color: Colors.white,fontWeight: FontWeight.w500),
                  )),
                ),
              ],
            ),
          ),
        ]
        ),
      ),
    );
  }
}
