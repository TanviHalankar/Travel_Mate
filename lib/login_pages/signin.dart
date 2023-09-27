import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/login_pages/phone_screen.dart';
import 'package:ttravel_mate/login_pages/signup.dart';

import '../screens/navigation.dart';
import '../widget/validation_textField.dart';
import 'auth_methods.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //TextEditingController unameController=new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passController.dispose();
    emailController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passController.text,
    );
    if (res == "success") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation(),));
    } else {
      print(res);
    }
    setState(() {
      _isLoading = false;
    });
  }
  bool passwordConfirmVisibility=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/back.png'),fit: BoxFit.cover,opacity: 0.8)
            ),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1)
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 170),
                        child: TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                        }, child: Text('Create Account',style: GoogleFonts.montserrat(color: Colors.orange,fontSize: 10),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                        ),
                        child: Text(
                          'TravelMate',
                          style: GoogleFonts.montserrat(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(children: [
                            ValidationText(controller: emailController, hint_text: 'Email',hintColor: Colors.white, validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')|| !value.contains('.')) {
                                  return 'Invalid email';
                                }
                                return null; // Return null if the input is valid

                            },),
                            SizedBox(height: 20,),
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
                              if(value.length<8){
                                return 'Too Short.Minimum length should be 8';
                              }
                              // if (!value.contains(RegExp(r'\d'))) {
                              //   return 'Password must contain at least one digit';
                              // }
                              // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                              //   return 'Password must contain at least one special character';
                              // }
                              return null;
                            },),
                            SizedBox(height: 60,),
                            OutlinedButton(
                              onPressed: () {
                                // Perform validation when the button is pressed
                                if (_formKey.currentState!.validate()) {
                                  loginUser();
                                }
                                else{
                                  print('user doesnt exists');
                                }
                              },
                              child: _isLoading?const Center(child:CircularProgressIndicator(color: Colors.white,)):Text('LOGIN',style: GoogleFonts.cormorant(fontSize: 15)),
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20)),
                                  foregroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.8)),
                                  //backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2)),
                                  backgroundColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.6)),
                                  elevation: MaterialStatePropertyAll(6),
                                  overlayColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1))
                                //shadowColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.2))
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Row(
                                children: [
                                  Text('Forgot Password?',style: GoogleFonts.montserrat(fontSize: 10)),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PhnumScreen(),));
                                  }, child: Text('Send OTP',style: GoogleFonts.montserrat(fontSize: 13,color: Colors.orange,fontWeight: FontWeight.w300)))
                                ],
                              ),
                            )

                          ]),
                        ),
                      ),
                    ]),
                  )),
            ),
          ),
        ));
  }
}
