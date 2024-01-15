// // import 'package:bubble/bubble.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
// // import 'package:safari_front/constants.dart';
// // import 'package:safari_front/main.dart';

// // class ChatPage extends StatefulWidget {
// //   const ChatPage({super.key, required this.name, required this.age});
// //   final String name;
// //   final int age;
// //   @override
// //   State<ChatPage> createState() => _ChatPageState();
// // }

// // class _ChatPageState extends State<ChatPage> {
// //   // 대화를 5번 주고받으면 멈추는 것으로 임시 지정. count 사용
// //   int count = 0;
// //   String userInput = "";
// //   // 주고 받는 대화가 저장될 messages 변수
// //   List _messages = [];
// //   final ScrollController scrollController = ScrollController();
// //   final TextEditingController textController = TextEditingController();

// //   // 포커스를 적용하기 위한 포커스노드 설정
// //   late FocusNode textFieldFocusNode;
// //   // 종료 알림 메세지를 여기저기서 조건으로 사용할 예정이라 미리 정해두기
// //   String endMessage = "종료하겠습니다";
// //   bool endFlag = false;
// //   bool lastQuestionFlag = false;

// //   // user_id = 수험번호 입력받기
// //   // final _user = const User(
// //   //   id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
// //   // );

// //   @override
// //   void initState() {
// //     super.initState();
// //     // 처음 대화가 시작될 때
// //     // 호산나
// //     setState(() {
// //       _messages.insert(0, ['${widget.name}씨 반갑습니다. 당신의 취미는 무엇인가요?', false]);
// //     });

// //     // 포커스노드 적용
// //     textFieldFocusNode = FocusNode();
// //   }

// //   @override
// //   void dispose() {
// //     //포커스노드도 없앨 것
// //     textFieldFocusNode.dispose();
// //     super.dispose();
// //   }

// //   void _handleSendPressed(String message) {
// //     /*
// //       총 3가지 단계가 필요함
// //       1. 일반적인 질문을 주고받는 단계
// //       2. 백엔드에서 준 종료 신호를 받아서 종료 메세지를 출력하는 단계
// //       3. 인터뷰에 대한 평가 값을 받는 단계
// //     */
// //     textController.clear();

// //     String message_this = "";
// //     count++;

// //     // 1단계
// //     // Count가 5 이하라면 아직 질문 수가 부족하므로 적당한 질문을 받아와서 출력하는 과정을 반복한다.
// //     if (count <= 5) {
// //       // 나
// //       setState(() {
// //         message_this = message;
// //         _messages.insert(0, [message, true]);
// //       });

// //       // 이때 디비에서 적당한 답변을 구해서 넣기

// //       // 호산나
// //       setState(() {
// //         _messages.insert(0, [message_this, false]);
// //       });
// //     }

// //     // 2단계
// //     // Count가 5이하이면 5회 이상 질문이 수행된 것이므로, 마무리 질문을 한다. 마무리 질문은 두 번 하면 이상하므로 마무리 질문을 하면 lastQuestionFlag를 True로 만들 것
// //     else if (!lastQuestionFlag && count > 5) {
// //       lastQuestionFlag = true;
// //       // 나
// //       setState(() {
// //         message_this = message;
// //         _messages.insert(0, [message, true]);
// //       });

// //       // 호산나
// //       setState(() {
// //         _messages.insert(
// //             0, ["마지막 질문이에요! 인터뷰의 전반적인 흐름에 대해 0부터 10 사이 값으로 평가해주세요", false]);
// //       });
// //     }
// //     // 3단계
// //     // Count가 5 이상이면서 endFlag도 true라면 마무리 질문까지 한 것. 답변을 분석해서 숫자라면 저장한 후에 endFlag를 True로 만들고 종료, 아니라면 다시 질문하기
// //     else {
// //       // 나
// //       setState(() {
// //         message_this = message;
// //         _messages.insert(0, [message, true]);
// //       });

// //       // 입력값이 형식에 맞으며 0에서 10 사이의 값을 입력했다면 종료해주기
// //       if (RegExp("[0-9]{1,2}").hasMatch(message) &&
// //           int.parse(message) >= 0 &&
// //           int.parse(message) <= 10) {
// //         // 호산나
// //         setState(() {
// //           _messages.insert(0, ["답변 감사해요!", false]);
// //         });
// //         endFlag = true;
// //       }

// //       // 입력값이 유효하지 않다면 다시 입력 부탁하기
// //       else {
// //         // 호산나
// //         setState(() {
// //           _messages.insert(0, ["정수 숫자 값을 입력해주세요", false]);
// //         });
// //       }
// //     }

// //     // TextField에 할당된 포커스노드를 이용해 포커스를 다시 채팅창으로 옮길 것
// //     FocusScope.of(context).requestFocus(textFieldFocusNode);
// //   }

// //   // 스킵 버튼 눌렀을 경우 다음 질문으로 바로 넘어가기
// //   void _handleSkipPressed() {
// //     textController.clear();

// //     // DB와 통신해서 다음 질문 받아오기

// //     // 마지막 평가 질문을 받은 경우에 건너뛰기를 눌렀다면 평가를 하고 싶지 않은 것으로 간주하고 그냥 종료
// //     if (lastQuestionFlag) {
// //       setState(() {
// //         _messages.insert(0, ["평가를 건너뛰셨습니다. 인터뷰에 응해 주셔서 감사해요!", false]);
// //       });
// //       endFlag = true;
// //     } else {
// //       setState(() {
// //         _messages.insert(0, ["다음 질문입니다. 좋아하는 것을 아무거나 말해주세요?", false]);
// //       });
// //     }

// //     // TextField에 할당된 포커스노드를 이용해 포커스를 다시 채팅창으로 옮길 것

// //     FocusScope.of(context).requestFocus(textFieldFocusNode);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final double statusBarHeight = MediaQuery.of(context).padding.top;
// //     final double w = MediaQuery.of(context).size.width;
// //     final double h = MediaQuery.of(context).size.height;

// //     // 스크롤을 항상 맨 밑에 두기 위함 - 적용 안됌
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (scrollController.hasClients) {
// //         scrollController.jumpTo(scrollController.position.maxScrollExtent);
// //       }
// //     });

// //     // 채팅 메세지가 담길 버블, 종료 조건 확인용 매개변수 추가됨
// //     Widget bubble(str, user, idx) {
// //       return Column(children: [
// //         user
// //             // 면접대상자
// //             ? Row(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //                   const Spacer(),
// //                   Container(
// //                     constraints: BoxConstraints(maxWidth: w * 0.6),
// //                     child: Bubble(
// //                       color: kWhite,
// //                       padding: const BubbleEdges.symmetric(horizontal: 15),
// //                       elevation: 0,
// //                       nip: BubbleNip.rightTop,
// //                       borderColor: kLightOrange,
// //                       child: Text(
// //                         str,
// //                         textAlign: TextAlign.justify,
// //                         style: TextStyle(
// //                           fontSize: kfontSize,
// //                           color: kBlack,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               )
// //             // 면접자
// //             : Row(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   const CircleAvatar(
// //                     backgroundImage: AssetImage(
// //                       'images/dev0.png',
// //                     ),
// //                   ),
// //                   const SizedBox(width: 5),
// //                   Container(
// //                       margin: const EdgeInsets.only(top: 5),
// //                       constraints: BoxConstraints(maxWidth: w * 0.6),
// //                       child: Bubble(
// //                         color: kTransparentOrange,
// //                         padding: const BubbleEdges.symmetric(horizontal: 15),
// //                         elevation: 0,
// //                         nip: BubbleNip.leftTop,
// //                         child: Text(
// //                           str,
// //                           style: TextStyle(
// //                             fontSize: kfontSize,
// //                             color: kGrey9,
// //                           ),
// //                         ),
// //                       )),
// //                   idx == 1 && !endFlag
// //                       ? TextButton(
// //                           onPressed: endFlag ? null : _handleSkipPressed,
// //                           child: Text(
// //                             "건너뛰기",
// //                             style: TextStyle(color: kBlack),
// //                           ),
// //                         )
// //                       : const SizedBox()
// //                 ],
// //               ),
// //         // EndFlag = true라면 인터뷰 종료 메세지 및 나가기 버튼 활성화시키는 부분
// //         endFlag && idx == 0
// //             ? Column(children: [
// //                 Container(
// //                   padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
// //                   child: Text("인터뷰가 종료되었습니다. 제공해주신 평가는 서비스 개선에 활용됩니다.",
// //                       style: TextStyle(
// //                         color: kGrey5,
// //                       )),
// //                 ),
// //                 Container(
// //                   width: w * 0.5,
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                     children: [
// //                       ElevatedButton(
// //                         style: ElevatedButton.styleFrom(
// //                             shape: RoundedRectangleBorder(
// //                                 borderRadius: kBorderRadius),
// //                             minimumSize: Size(w * 0.2, 50),
// //                             foregroundColor: Colors.white,
// //                             backgroundColor: kOrange),
// //                         onPressed: () {},
// //                         child: Text("저장하기",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: kfontSize + 2,
// //                               fontWeight: FontWeight.bold,
// //                             )),
// //                       ),
// //                       ElevatedButton(
// //                         style: ElevatedButton.styleFrom(
// //                             shape: RoundedRectangleBorder(
// //                                 borderRadius: kBorderRadius),
// //                             minimumSize: Size(w * 0.2, 50),
// //                             foregroundColor: Colors.white,
// //                             backgroundColor: kOrange),
// //                         onPressed: () {
// //                           Navigator.pushReplacement(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (_) => const MyApp(),
// //                             ),
// //                           );
// //                         },
// //                         child: Text("나가기",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: kfontSize + 2,
// //                               fontWeight: FontWeight.bold,
// //                             )),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ])
// //             : const SizedBox()
// //       ]);
// //     }

// //     return Scaffold(
// //         backgroundColor: kWhite,
// //         appBar: AppBar(
// //             backgroundColor: kWhite,
// //             // 인터뷰니까 타이머가 있으면 좋겠다고 생각함
// //             automaticallyImplyLeading: false,
// //             title: FAProgressBar(
// //               size: 20,
// //               progressColor: kOrange,
// //               borderRadius: const BorderRadius.all(Radius.circular(20)),
// //               currentValue: _messages.length / 20 * 100,
// //             )),
// //         body: Container(
// //             padding: EdgeInsets.only(
// //                 top: statusBarHeight, bottom: statusBarHeight * 2),
// //             width: w,
// //             height: h,
// //             child: Column(children: [
// //               // 채팅리스트
// //               Expanded(
// //                 child: SingleChildScrollView(
// //                   child: Container(
// //                     padding: const EdgeInsets.only(top: 10),
// //                     child: ListView.builder(
// //                         controller: scrollController,
// //                         physics: const NeverScrollableScrollPhysics(),
// //                         shrinkWrap: true,
// //                         reverse: true,
// //                         itemCount: _messages.length,
// //                         itemBuilder: (BuildContext context, idx) {
// //                           return Container(
// //                             padding: EdgeInsets.only(
// //                                 left: 10,
// //                                 right: 10,
// //                                 // 마지막 메세지이면(idx == 0 이면) 채팅창을 잡아먹지 않도록 띄워주기
// //                                 bottom: idx == 0 ? 100 : 10),
// //                             alignment: _messages[idx][1]
// //                                 ? Alignment.centerRight
// //                                 : Alignment.centerLeft,
// //                             child: bubble(
// //                                 // 종료 조건 확인용 매개변수 전달하는 부분 추가됨
// //                                 _messages[idx][0],
// //                                 _messages[idx][1],
// //                                 idx),
// //                           );
// //                         }),
// //                   ),
// //                 ),
// //               ),
// //               // 입력란
// //               Container(
// //                 width: w,
// //                 child: Container(
// //                   padding: const EdgeInsets.only(
// //                       top: 5, bottom: 20, left: 10, right: 10),
// //                   child: Row(
// //                     children: [
// //                       Expanded(
// //                         child: TextField(
// //                           // 입력 버튼을 눌렀을 때 다시 포커스를 가져오기 위해 포커스노드 할당
// //                           focusNode: textFieldFocusNode,
// //                           controller: textController,
// //                           //
// //                           onSubmitted: _handleSendPressed,
// //                           onChanged: (value) {},
// //                           style: TextStyle(fontSize: kfontSize, color: kBlack),
// //                           // 종료되면 입력을 막기 위해 enabled 만들기
// //                           enabled: !endFlag,
// //                           decoration: InputDecoration(
// //                             filled: true,
// //                             fillColor: kWhite,
// //                             hintStyle:
// //                                 TextStyle(fontSize: kfontSize, color: kBlack),
// //                             counterText: "",
// //                             contentPadding: const EdgeInsets.symmetric(
// //                                 horizontal: 10, vertical: 15),
// //                             focusedBorder: OutlineInputBorder(
// //                               borderSide: BorderSide(color: kOrange),
// //                               borderRadius: BorderRadius.circular(15),
// //                             ),
// //                             enabledBorder: OutlineInputBorder(
// //                               borderSide: BorderSide(color: kGrey5),
// //                               borderRadius: BorderRadius.circular(15),
// //                             ),
// //                             disabledBorder: OutlineInputBorder(
// //                               borderSide: BorderSide(color: kGrey5),
// //                               borderRadius: BorderRadius.circular(15),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       Container(
// //                         margin: const EdgeInsets.symmetric(horizontal: 4.0),
// //                         child: IconButton(
// //                             color: endFlag ? kGrey9 : Colors.deepOrangeAccent,
// //                             icon: const Icon(
// //                               Icons.send,
// //                             ),
// //                             onPressed: () =>
// //                                 endFlag || textController.text == ""
// //                                     ? null
// //                                     : _handleSendPressed(textController.text)),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ])));
// //   }
// // }


// last_question && index == _messages.length - 1
//             ? Column(children: [
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Text("인터뷰가 종료되었습니다. 제공해주신 평가는 서비스 개선에 활용됩니다.",
//                       style: TextStyle(
//                         color: kGrey5,
//                       )),
//                 ),
//                 SizedBox(
//                   width: w * 0.5,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: kBorderRadius),
//                             minimumSize: Size(w * 0.2, 50),
//                             foregroundColor: Colors.white,
//                             backgroundColor: kOrange),
//                         onPressed: () {},
//                         child: Text("저장하기",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: kfontSize + 2,
//                               fontWeight: FontWeight.bold,
//                             )),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: kBorderRadius),
//                             minimumSize: Size(w * 0.2, 50),
//                             foregroundColor: Colors.white,
//                             backgroundColor: kOrange),
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const MyApp(),
//                             ),
//                           );
//                         },
//                         child: Text("나가기",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: kfontSize + 2,
//                               fontWeight: FontWeight.bold,
//                             )),
//                       )
//                     ],
//                   ),
//                 ),
//               ])
//             : const SizedBox()