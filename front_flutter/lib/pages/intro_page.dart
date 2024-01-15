import 'package:flutter/material.dart';
import 'package:safari_front/constants.dart';
import 'package:safari_front/admin/edit.dart';
import 'package:safari_front/pages/chat_page.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key, required this.popup});
  final bool popup;
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: kTransparentBlack,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.15),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                  width: w * 0.76,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        introduction,
                        style: kContentTextStyle,
                      ),
                      widget.popup
                          ? Container(
                              margin: const EdgeInsets.only(top: 30),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: double.infinity,
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: kBorderRadius),
                                      foregroundColor: Colors.white,
                                      backgroundColor: kOrange),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "닫기",
                                  )))
                          : Container(
                              margin: const EdgeInsets.only(top: 30),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: double.infinity,
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: kBorderRadius),
                                      foregroundColor: Colors.white,
                                      backgroundColor: kOrange),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ChatPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "시작",
                                  )))
                    ],
                  )),
              // 상단 제목부
              Positioned(
                  child: Container(
                      height: 60,
                      width: w * 0.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: kOrange,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        '안내사항',
                        style: kTitleTextStyle,
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
        ));
  }
}
