import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:safari_front/constants.dart';
import 'package:safari_front/admin/edit.dart';
import 'package:safari_front/model/user.dart';
import 'package:safari_front/pages/intro_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController nameTextController = TextEditingController();
  List<String> ageItems = [
    '20세 미만',
    '20세 이상 40세 미만',
    '40세 이상 65세 미만',
    "65세 이상"
  ];
  var genderItems = ['남성', '여성'];

  String ageDropdownValue = '';
  String genderDropdownValue = '';
  bool check = false;

  @override
  void initState() {
    super.initState();
    user = User(name: "", cycle: -1, gender: -1);
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    InputDecoration inputDecoration = InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: kBorderRadius,
            borderSide: BorderSide(color: kOrange)),
        enabledBorder: OutlineInputBorder(
            borderRadius: kBorderRadius,
            borderSide: BorderSide(color: kGrey5)));

    return Scaffold(
        backgroundColor: kTransparentBlack,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.2),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 1. 이름 입력
                            SizedBox(
                                width: w * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 이름 입력
                                    Text("성함을 입력해주세요",
                                        style: kContentTextStyle),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter(
                                            RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|·|：]'),
                                            allow: true,
                                          )
                                        ],
                                        controller: nameTextController,
                                        onChanged: (text) {
                                          user.name = text;
                                          setState(() {});
                                        },
                                        decoration: inputDecoration),
                                  ],
                                )),
                            // 2. 연령대 입력
                            SizedBox(
                                width: w * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("연령대를 선택해주세요",
                                        style: kContentTextStyle),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      hint: Text(ageItems.first),
                                      decoration: inputDecoration,
                                      items: ageItems
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: kContentTextStyle),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        ageDropdownValue = value.toString();
                                        user.cycle = ageItems.indexOf(value!);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                )),

                            // 3. 성별 입력
                            SizedBox(
                                width: w * 0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("성별을 선택해주세요",
                                        style: kContentTextStyle),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      hint: Text(genderItems.first),
                                      decoration: inputDecoration,
                                      items: genderItems
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item,
                                                    style: kContentTextStyle),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        genderDropdownValue = value.toString();
                                        user.gender =
                                            genderItems.indexOf(value!) + 1;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("(필수) 개인정보 수집 및 이용 동의",
                                style: kContentTextStyle),
                            Checkbox(
                                value: check,
                                activeColor: kOrange,
                                onChanged: (bool? value) {
                                  setState(() {
                                    check = value!;
                                  });
                                }),
                          ],
                        ),
                        Container(
                            width: w * 0.7,
                            height: h * 0.2,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(color: kGrey4),
                                borderRadius: kBorderRadius),
                            alignment: Alignment.centerLeft,
                            child: Text(agreement, style: kContentTextStyle)),
                        Container(
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
                                    backgroundColor: user.name.isNotEmpty &&
                                            user.cycle >= 0 &&
                                            user.gender >= 0 &&
                                            check
                                        ? kOrange
                                        : kGrey2),
                                onPressed: () {
                                  user.name.isNotEmpty &&
                                          user.cycle >= 0 &&
                                          user.gender >= 0 &&
                                          check
                                      ? Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => IntroPage(
                                              popup: false,
                                            ),
                                          ),
                                        )
                                      : null;
                                  setState(() {});
                                  debugPrint(user.toJson().toString());
                                },
                                child: const Text(
                                  "다음",
                                )))
                      ])),
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
                        '기본정보',
                        style: kTitleTextStyle,
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
        ));
  }
}
