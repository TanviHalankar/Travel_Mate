import 'dart:async';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/back.dart';
import '../../widget/image_card.dart';
import '../../widget/lists.dart';
import '../search2.dart';
import 'newSearch2.dart';

class NewSearch extends StatefulWidget {
  NewSearch({Key? key}) : super(key: key);

  @override
  State<NewSearch> createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  int _selectedIndex = 0;
  late PageController _controller;
  bool forward=true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(
      viewportFraction: .7,
    );
    /*_controller.addListener(() {
      var currentPosition = _controller.page??0;
      var converted = currentPosition % 1;
      if(converted>=0.5){
        converted=1-converted;
      }
      setState(() {
        _rotateY=converted;
      });
    });*/
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (forward){
        if(_selectedIndex<locations.length){
          _selectedIndex++;
        }else{
          forward=false;
        }
      }
      if(!forward){
        if(_selectedIndex<=4 && _selectedIndex>0){
          _selectedIndex--;
        }else{
          forward=true;
        }
      }
      _controller.animateToPage(_selectedIndex, duration: Duration(milliseconds: 1300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
            children:[
              //BackGround(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      /*SearchBarAnimation(
                    buttonWidget: LineIcon(LineIcons.search,size: 30,color: Colors.black,),
                    secondaryButtonWidget: LineIcon(LineIcons.search,color: Colors.black),
                    textEditingController: TextEditingController(),
                    isOriginalAnimation: false,
                    buttonBorderColour: Colors.black,
                    onFieldSubmitted: (String value){
                      debugPrint('onFieldSubmitted value $value');
                    }, trailingWidget:Icon(Icons.cancel_rounded,color: Colors.grey),
                  ),*/
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text('Find Your \nDream Trip',
                                style: GoogleFonts.montserrat(fontSize: 40,fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: TextField(
                          readOnly: true,
                          style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 20),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewSearch2(),));
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: Colors.grey), // Change this color
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                              prefixIcon: Icon(Icons.search,color: Colors.grey,),
                              hintText: 'e.g. Mumbai',
                              //labelText: 'Title',
                              hintStyle: GoogleFonts.montserrat(color: Colors.grey)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: size.height * .5,
                            child: PageView.builder(
                              itemCount: locations.length,
                              controller: _controller,
                              onPageChanged: (value) {
                                setState(() {
                                  _selectedIndex = value;
                                });
                              },
                              itemBuilder: (context, index) {
                                Location location = locations[index];
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 7),
                                    color: Colors.transparent,
                                    child: ImageCard(
                                      size: size,
                                      location: location,
                                      isSelected: index == _selectedIndex ? true : false,
                                    ));
                              },
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
