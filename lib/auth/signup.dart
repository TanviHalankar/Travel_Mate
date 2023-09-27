//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
//
// import 'otp.dart';
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//   static String verify="";
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController phnum=TextEditingController();
//   TextEditingController email=TextEditingController();
//   TextEditingController uname=TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 150),
//               child: Center(
//                   child: Text('SIGN-UP',
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold
//                     ),
//                   )
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(top: 70.0,right: 20.0,left: 20.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(
//                         hintText: 'User Name',
//                         prefixIcon: Icon(Icons.person_outline,),
//                         enabledBorder:OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         ) ,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         )
//                     ),
//                     controller: uname,
//                   ),
//                   SizedBox(height: 20),
//
//                   TextField(
//                     decoration: InputDecoration(
//                         hintText: 'Email',
//                         prefixIcon: Icon(Icons.email_outlined,),
//                         enabledBorder:OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         ) ,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         )
//                     ),
//                     controller: email,
//                   ),
//                   SizedBox(height: 20),
//
//                   TextField(
//
//                     controller: phnum,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                         hintText: 'Phone Number',
//                         prefixIcon: Icon(Icons.local_phone_outlined),
//                         enabledBorder:OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         ) ,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         )
//                     ),
//                   ),
//                   SizedBox(height: 20),
//
//                   SizedBox(
//                       width: 300.0,
//                       child: ElevatedButton(onPressed: ()async{
//                         {
//                           await FirebaseAuth.instance.verifyPhoneNumber(
//                             phoneNumber: phnum.text.startsWith("+91") ? phnum.text : "+91"+phnum.text,
//                             verificationCompleted: (PhoneAuthCredential credential) { },
//                             verificationFailed: (FirebaseAuthException e) { },
//                             codeSent: (String verificationId, int? resendToken) {
//                               SignUp.verify=verificationId;
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => Otp(phone: "+91"+phnum.text, email: email.text,uname:uname.text),),);},
//                             codeAutoRetrievalTimeout: (String verificationId) {},
//                           );
//                         }
//                       },
//                           child: Text('SEND')
//                       )
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }
