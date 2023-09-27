// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ttravel_mate/auth/signin.dart';
// import 'package:ttravel_mate/auth/signup.dart';
//
//
// class WelcomePage extends StatelessWidget {
//   const WelcomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceHeight =MediaQuery.of(context).size.height;
//     final deviceWidth =MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Column(
//
//         children: [
//           Container(
//             //color: Colors.white,
//             height: deviceHeight*0.50,
//             child: FittedBox(
//               child: Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: CircleAvatar(
//                   backgroundImage:AssetImage('assets/beach.png') ,
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             height: deviceHeight*0.45,
//             width: double.infinity,
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 80),
//                   child: Text('HEY! WELCOME',
//                       style: GoogleFonts.aBeeZee(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold
//                       )
//                   ),
//                 ),
//                 Text('The best way to make your drinks!',
//                 style: TextStyle(
//                   color: Colors.grey,
//                 )
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top:30.0),
//                   child: SizedBox(
//                     width: 300.0,
//                     child: ElevatedButton(
//                         onPressed: (){
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const SignUp()),
//                           );
//                         },
//                         child: Text('GET STARTED'),
//                     ),
//                   ),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Already have an account?',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 10.0,
//                           )
//                       ),
//                       GestureDetector(
//                         onTap: (){
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const SignIn()),
//                           );
//                         },
//                         child: Text('SIGN-IN',
//                             style: TextStyle(
//                               color: Colors.deepOrangeAccent[100],
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.bold,
//                               decoration: TextDecoration.underline
//                             )
//                         ),
//                       ),
//                     ],
//
//                   ),
//                 ),
//               ],
//             ),
//             //color: Colors.cyan,
//           ),
//         ],
//       ),
//     );
//   }
// }
