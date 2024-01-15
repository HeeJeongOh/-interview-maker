import 'dart:convert';

class BaseQuestion {
  int bid;
  int gender;
  int cycle;
  String question;

  BaseQuestion(
      {required this.bid,
      required this.gender,
      required this.cycle,
      required this.question});

  factory BaseQuestion.fromJson(Map<String, dynamic> json) => BaseQuestion(
      bid: json["bid"],
      gender: json["gender"],
      cycle: json["cycle"],
      question: json["question"]);

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "gender": gender,
        "cycle": cycle,
        "question": question,
      };
}
