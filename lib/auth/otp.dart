//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ttravel_mate/auth/signup.dart';
//
// import '../screens/navigation.dart';
//
//
// class Otp extends StatefulWidget {
//   String phone;
//   String email;
//   String uname;
//   Otp({Key? key, required this.phone, required this.email,required this.uname}) : super(key: key);
//
//   @override
//   State<Otp> createState() => _OtpState();
// }
//
// class _OtpState extends State<Otp> {
//
//   final FirebaseAuth auth =FirebaseAuth.instance;
//   var value="";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 250),
//               child: Center(
//                   child: Text('Phone Verification',
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold
//                     ),
//                   )
//               ),
//             ),
//             SizedBox(
//               width: 300,
//                 height: 70,
//                 child: Center(
//                   child: Text('Enter your OTP code number!',
//                   style: TextStyle(color: Colors.grey),),
//                 )
//             ),
//
//             SizedBox(
//               height: 50,
//               width: 300,
//               child: OtpTextField(
//                 numberOfFields: 6,
//                 decoration: InputDecoration(
//                   //counter: Offstage(),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 0.0, color: Colors.white10),
//                       //borderRadius: BorderRadius.circular(100)
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 0.0, color: Colors.black),
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 showFieldAsBox: true,
//                 focusedBorderColor: Colors.black,
//                 borderWidth: 4.0,
//                 //runs when a code is typed in
//                 onCodeChanged: (String code) {//handle validation or checks here if necessary
//                 },
//                 //runs when every textfield is filled
//                 onSubmit: (String verificationCode) {
//                   value=(verificationCode);
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 50.0),
//               child: SizedBox(
//                   width: 300.0,
//                   child: ElevatedButton(onPressed: ()async {
//                     // Create a PhoneAuthCredential with the code
//                     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: SignUp.verify, smsCode: value);
//                     // Sign the user in (or link) with the credential
//                     await auth.signInWithCredential(credential);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Navigation()),
//                     );
//
//                   },
//                       child: Text('SEND')
//                   )
//               ),
//             )
//
//     ]
//     )
//     )
//     );
//
//   }
// }
