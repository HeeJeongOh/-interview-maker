import 'package:flutter/material.dart';
import 'package:safari_front/constants.dart';
import 'package:safari_front/admin/edit.dart';
import 'package:safari_front/pages/user_page.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PretendardMedium',
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: kGrey4,
            selectionHandleColor: kGrey4,
            selectionColor: kGrey4.withOpacity(0.3)),
        appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      ),
      home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kTransparentBlack,
      body: Center(
        child: Container(
          height: h * 0.8,
          color: kWhite,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(greeting,
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.bold)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      img1_path,
                      width: w * 0.25,
                    ),
                    Image.asset(
                      img2_path,
                      width: w * 0.25,
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape:
                          RoundedRectangleBorder(borderRadius: kBorderRadius),
                      minimumSize: Size(w * 0.8, 60),
                      foregroundColor: Colors.white,
                      backgroundColor: kOrange),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserPage(),
                      ),
                    );
                  },
                  child: Text(
                    "시작하기",
                    style: TextStyle(fontSize: kfontSize * 1.2),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
