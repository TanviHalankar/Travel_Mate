import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttravel_mate/db_info.dart';
import 'package:ttravel_mate/login_pages/signin.dart';

import '../utils/utils.dart';
import '../widget/validation_textField.dart';
import 'auth_methods.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController unameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController cpassController = new TextEditingController();
  TextEditingController mobController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool passwordConfirmVisibility=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    unameController.dispose();
    passController.dispose();
    countryController.dispose();
    cpassController.dispose();
    mobController.dispose();
  }

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
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        uname: unameController.text,
        password: passController.text,
        email: emailController.text,
        phnum: mobController.text,
        country: countryController.text,
        file: _image
        //file:
        );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn()
          ));
      showSnackBar(res, context);
    }
    else{
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/back.png'),
                  fit: BoxFit.cover,
                  opacity: 0.8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Container(
              color: Colors.white.withOpacity(0.1),
              child: Column(
                children: [
                  /*Text('CREATE ACCOUNT',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),*/

                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  AssetImage('assets/profile.jpg')),
                      Positioned(
                          bottom: 0,
                          left: 85,
                          child: IconButton(
                            onPressed: _selectImage,
                            icon: Icon(Icons.add_a_photo,color: Colors.orange,size: 40),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        ValidationText(
                          controller: unameController,
                          hint_text: 'User Name',
                          hintColor: Colors.white,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ValidationText(
                          controller: emailController,
                          hint_text: 'Email',
                          hintColor: Colors.white,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // if (!value.contains('@')||!value.contains('.')) {
                            //   return 'Invalid Email';
                            // }
                            if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*(\.[a-zA-Z]{2,})$')
                                .hasMatch(value)) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // ValidationText(
                        //   controller: passController,
                        //   hint_text: 'Password',
                        //   hintColor: Colors.white,
                        //   obscureText: true,
                        //   validation: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter your password';
                        //     }
                        //     if (value.length < 8) {
                        //       return 'Too Short...minimum length should be 8';
                        //     }
                        //     // if (!value.contains(RegExp(r'\d'))) {
                        //     //   return 'Password must contain at least one digit';
                        //     // }
                        //     // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        //     //   return 'Password must contain at least one special character';
                        //     // }
                        //     return null;
                        //   },
                        // ),
                        ValidationText(suffix_icon:  InkWell(
                          onTap: () => setState(
                                () => passwordConfirmVisibility =
                            !passwordConfirmVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordConfirmVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF57636C),
                            size: 24,
                          ),
                        ),controller: passController, hint_text: 'Password',hintColor: Colors.white,obscureText:   !passwordConfirmVisibility,validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Too Short...minimum length should be 8';
                          }
                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>0-9]').hasMatch(value)) {
                            return 'Password must contain at least one special character and one digit';
                          }
                          // if (!value.contains(RegExp(r'\d'))) {
                          //   return 'Password must contain at least one digit';
                          // }
                          // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          //   return 'Password must contain at least one special character';
                          // }
                          return null;
                        },),
                        SizedBox(
                          height: 20,
                        ),
                        ValidationText(
                          keyboardType: TextInputType.phone,
                          controller: mobController,
                          hint_text: 'Phone Number',
                          hintColor: Colors.white,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Invalid phone number (At least 10 digits)';
                            }
                            // if (value.length != 10) {
                            //   return 'Invalid phone number(Atleast 10 digit)';
                            // }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ValidationText(
                          controller: countryController,
                          hint_text: 'Where do you live?',
                          hintColor: Colors.white,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the field value';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // Perform validation when the button is pressed
                            if (_formKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator())
                              : Text('CREATE ACCOUNT',
                                  style: GoogleFonts.montserrat(fontSize: 15)),
                          style: ButtonStyle(
                              padding: MaterialStatePropertyAll(
                                  EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      top: 20,
                                      bottom: 20)),
                              foregroundColor: MaterialStatePropertyAll(
                                  Colors.white.withOpacity(0.8)),
                              //backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.black.withOpacity(0.6)),
                              elevation: MaterialStatePropertyAll(6),
                              overlayColor: MaterialStatePropertyAll(
                                  Colors.white.withOpacity(0.1))
                              //shadowColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2))
                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text('Already have an account?',
                                  style: GoogleFonts.montserrat(fontSize: 10)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignIn(),
                                        ));
                                  },
                                  child: Text('Sign In',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.orange)))
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
