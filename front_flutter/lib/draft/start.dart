// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:safari_front/privacy_page.dart';
// import 'constants.dart';

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   var filledInputField;

//   @override
//   void initState() {
//     super.initState();
//     filledInputField = false;
//   }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   var userName = "";
//   //   var userPhoneNumber = "";
//   //   var filledInputField = userName != "" && userPhoneNumber != "";
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepOrangeAccent,
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(50),
//           // width: double.infinity,
//           // height: double.infinity,
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     "안녕하세요, 저는 호산나에요.\n자서전을 위한 인터뷰를 시작할게요",
//                     style: TextStyle(
//                       fontSize: kfontSize * 1.5,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 20),
//                   child: TextField(
//                     onChanged: (text) {
//                       setState(() {
//                         userName = text;
//                         filledInputField =
//                             userName.length >= 2 && userPhoneNumber.length == 4;
//                       });
//                     },
//                     decoration: const InputDecoration(
//                         labelText: "이름",
//                         hintText: "이름을 입력해주세요",
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             borderSide:
//                                 BorderSide(width: 1, color: Colors.blueAccent)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         )),
//                   ),
//                 ),
//                 TextField(
//                   onChanged: (text) {
//                     setState(() {
//                       userPhoneNumber = text;
//                       filledInputField =
//                           userName.length >= 2 && userPhoneNumber.length == 4;
//                     });
//                   },
//                   decoration: const InputDecoration(
//                       labelText: "휴대폰번호",
//                       hintText: "휴대폰번호 뒤의 네자리를 입력해주세요",
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           borderSide:
//                               BorderSide(width: 1, color: Colors.blueAccent)),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       )),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp('[0-9]'))
//                   ],
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(top: 20),
//                     padding: const EdgeInsets.symmetric(vertical: 5),
//                     width: double.infinity,
//                     alignment: Alignment.bottomRight,
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             minimumSize: const Size(80, 50),
//                             foregroundColor: Colors.white,
//                             backgroundColor:
//                                 filledInputField ? kOrange : kGrey2),
//                         onPressed: () {
//                           filledInputField
//                               ? Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => const Privacy(),
//                                   ),
//                                 )
//                               : null;
//                         },
//                         child: const Text("다음으로")))
//               ]),
//         ),
//       ),
//     ));
//   }
// }
