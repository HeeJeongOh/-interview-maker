import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:safari_front/constants.dart';
import 'package:safari_front/admin/edit.dart';
import 'package:safari_front/main.dart';
import 'package:safari_front/model/base.dart';
import 'package:safari_front/model/generated.dart';
import 'package:safari_front/model/message.dart';
import 'package:safari_front/pages/intro_page.dart';
import 'package:safari_front/services/create_excel.dart';
import 'package:safari_front/services/service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Service dioClient = Service();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();

  int totalTextCnts = 0;

  int currentCycle = 0;
  int currentTextCnt = 0;
  int currentBid = 0;

  final List<List<String>> _contents = [];

  List<Message> _messages = [];
  List<GeneratedQuestion> generatedQuestions = [];
  bool showQustionList = false;
  bool blockInput = false;

  String last_question = "";
  String last_answer = "";

  bool isLoading = false;
  bool isEnd = false;

  @override
  void initState() {
    super.initState();
    _getStartQuestions(currentCycle);
  }

  @override
  void dispose() {
    //포커스노드도 없앨 것
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _getStartQuestions(int currentCycle) async {
    // 서버와 통신해서 질문 구해오기
    BaseQuestion question =
        await dioClient.getBaseQuestion(gender: 0, cycle: currentCycle);
    debugPrint("debug: ${question.toJson()}");

    currentBid = question.bid;
    _messages.insert(0, Message('admin', question.question));
    setState(() {});
  }

  void _getNextQuestion(String question, String answers) async {
    isLoading = true;
    List<GeneratedQuestion> response = await dioClient.getGeneratedQuestion(
        bid: currentBid, question: question, answer: answers);
    showQustionList = true;
    blockInput = true;
    isLoading = false;
    generatedQuestions = response;
    setState(() {});
  }

  void _handleSendPressed(String message) {
    String message = _textController.text;

    _textController.clear();
    FocusScope.of(context).requestFocus(_textFieldFocusNode);
    if (message.isEmpty) {
      debugPrint("debug: empty input");
      return;
    }

    _messages.insert(0, Message('user', message));
    currentTextCnt += message.length;
    totalTextCnts += message.length;
    setState(() {});
  }

  void _handleNextPressed({String? situation}) {
    // 0. [질문, 답변] 쌍 추출
    last_answer = "";
    for (Message m in _messages) {
      if (m.sendBy == "admin") {
        last_question = m.message;
        break;
      }
      last_answer = "${m.message} $last_answer";
    }
    debugPrint("q : $last_question \na : $last_answer");
    // 1. 질문 회피
    if (situation == "skip_based" || situation == "skip_generated") {
      _getStartQuestions(currentCycle);
      showQustionList = false;
      blockInput = false;
      setState(() {});
    }
    //else if (situation == "skip_generated") {
    //   _getNextQuestion(last_question, last_answer);
    // }
    // 2. 다음 꼬리질문 생성 또는 다음 생애주기
    else {
      _contents.add([last_question, last_answer]);

      debugPrint('debug: $currentTextCnt / $stdTextCnts');
      // 다음 꼬리질문 생성
      if (currentTextCnt <= stdTextCnts) {
        _getNextQuestion(last_question, last_answer);
      }
      // 다음 생애주기
      else {
        currentCycle += 1;

        // 인터뷰 종료 조건
        if (currentCycle > user.cycle) {
          isEnd = true;
        } else {
          currentTextCnt = 0;
          _getStartQuestions(currentCycle);
        }
      }
    }
    _textController.clear();
    FocusScope.of(context).requestFocus(_textFieldFocusNode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    Widget bubble(Message message) {
      bool user = message.sendBy == 'user' ? false : true;
      return Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: user
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('images/dev0.png'),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        constraints: BoxConstraints(maxWidth: w * 0.6),
                        child: Bubble(
                          color: kTransparentOrange,
                          padding: const BubbleEdges.symmetric(
                              vertical: 10, horizontal: 15),
                          elevation: 0,
                          nip: BubbleNip.leftTop,
                          child: Text(
                            message.message,
                            style: TextStyle(
                              fontSize: kfontSize,
                              color: kGrey9,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  Container(
                    constraints: BoxConstraints(maxWidth: w * 0.6),
                    child: Bubble(
                      color: kWhite,
                      padding: const BubbleEdges.symmetric(horizontal: 15),
                      elevation: 0,
                      nip: BubbleNip.rightTop,
                      borderColor: kLightOrange,
                      child: Text(
                        message.message,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: kfontSize,
                          color: kBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );
    }

    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kTransparentBlack,
          automaticallyImplyLeading: false,
          title: FAProgressBar(
              size: 25,
              progressColor: kOrange,
              backgroundColor: kWhite,
              displayText: '%',
              currentValue:
                  ((totalTextCnts / (stdTextCnts * (user.cycle + 1))) * 100)),
          actions: [
            IconButton(
              icon: Icon(Icons.help_rounded, color: kOrange),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                      opaque: false, // set to false
                      pageBuilder: (_, __, ___) => IntroPage(popup: true)),
                );
              },
            )
          ],
        ),
        body: Container(
            width: w,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // 채팅리스트
                Expanded(
                    child: SingleChildScrollView(
                        reverse: true,
                        child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            // 종료 시 내보낼 화면
                            return isEnd && index == 0
                                ? Column(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: bubble(_messages[index]),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                          "인터뷰가 종료되었습니다. 제공해주신 답변은 서비스 개선에 활용됩니다.",
                                          style: TextStyle(
                                            color: kGrey5,
                                          )),
                                    ),
                                    SizedBox(
                                      width: w * 0.5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        kBorderRadius),
                                                minimumSize: Size(w * 0.2, 50),
                                                foregroundColor: Colors.white,
                                                backgroundColor: kOrange),
                                            onPressed: () async {
                                              CreateExcel createExcel =
                                                  CreateExcel();

                                              await createExcel
                                                  .generateExcel(_contents);
                                              // toast message to user

                                              await Fluttertoast.showToast(
                                                textColor: Colors.black,
                                                webBgColor:
                                                    "linear-gradient(to right, #E0E0E0, #CECECE)",
                                                msg: '성공적으로 저장되었습니다.',
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                              );

                                              Timer.periodic(
                                                  const Duration(seconds: 5),
                                                  (timer) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MyApp(),
                                                  ),
                                                );
                                              });
                                            },
                                            child: Text("저장하기",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: kfontSize + 2,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        kBorderRadius),
                                                minimumSize: Size(w * 0.2, 50),
                                                foregroundColor: Colors.white,
                                                backgroundColor: kOrange),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => const MyApp(),
                                                ),
                                              );
                                            },
                                            child: Text("나가기",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: kfontSize + 2,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])
                                : Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: bubble(_messages[index]),
                                  );
                          },
                        ))),
                const SizedBox(height: 20),
                // 입력란
                Column(
                  children: [
                    isLoading
                        ? SizedBox(
                            width: w,
                            height: 80,
                            child: Column(children: [
                              Text("질문을 불러오고 있어요. 잠시만 기다려주세요 :)",
                                  style:
                                      TextStyle(color: kOrange, fontSize: 16)),
                              LoadingAnimationWidget.prograssiveDots(
                                color: kOrange,
                                size: 35,
                              ),
                            ]))
                        : showQustionList
                            ? SizedBox(
                                width: w,
                                height: 80,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        alignment: Alignment.center,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              minimumSize: Size(w * 0.3, 80),
                                              maximumSize: Size(w * 0.3, 80),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: kBorderRadius),
                                              backgroundColor: kGrey2),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 3),
                                            child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                text: TextSpan(
                                                  text:
                                                      generatedQuestions[index]
                                                          .question,
                                                )),
                                          ),
                                          onPressed: () {
                                            _messages.insert(
                                                0,
                                                Message(
                                                    "admin",
                                                    generatedQuestions[index]
                                                        .question));
                                            showQustionList = false;
                                            blockInput = false;
                                            setState(() {});
                                          },
                                        ));
                                  },
                                  itemCount: generatedQuestions.length,
                                ),
                              )
                            : const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextField(
                          enabled:
                              blockInput || isLoading || isEnd ? false : true,
                          focusNode: _textFieldFocusNode,
                          controller: _textController,
                          onSubmitted: _handleSendPressed,
                          onChanged: (value) {},
                          style: TextStyle(fontSize: kfontSize, color: kBlack),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kWhite,
                            hintStyle:
                                TextStyle(fontSize: kfontSize, color: kBlack),
                            counterText: "",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGrey5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGrey5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )),
                        Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: const Size(80, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: kBorderRadius),
                                    backgroundColor:
                                        blockInput || isLoading || isEnd
                                            ? kLightGrey
                                            : kOrange),
                                onPressed: () {
                                  blockInput || isLoading || isEnd
                                      ? null
                                      : _handleSendPressed(
                                          _textController.text);
                                },
                                child: Text("전송",
                                    style: TextStyle(color: kWhite)))),
                        Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: const Size(80, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: kBorderRadius),
                                    backgroundColor: isLoading || isEnd
                                        ? kLightGrey
                                        : kOrange),
                                onPressed: () {
                                  // 질문 불러오기, 인터뷰 종료 시 다음 버튼 막기
                                  if (isLoading || isEnd) {
                                    return;
                                  }
                                  // 시작 질문 회피 + 꼬리 질문 선택 후 마음에 안 들때에도 새로운 시작 질문으로
                                  else if (_messages[0].sendBy == "admin") {
                                    _handleNextPressed(situation: "skip_based");
                                  }
                                  // 꼬리 질문 회피
                                  else if (showQustionList) {
                                    _handleNextPressed(
                                        situation: "skip_generated");
                                  } else {
                                    _handleNextPressed();
                                  }
                                },
                                child: Text("다음",
                                    style: TextStyle(color: kWhite))))
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}
