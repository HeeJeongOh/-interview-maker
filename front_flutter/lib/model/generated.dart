import 'dart:convert';

GeneratedQuestion generatedModelJson(String str) =>
    GeneratedQuestion.fromJson(json.decode(str));

String generatedModelToJson(GeneratedQuestion data) =>
    json.encode(data.toJson());

class GeneratedQuestion {
  int bid;
  int gid;
  String question;
  double score;

  GeneratedQuestion(
      {required this.bid,
      required this.gid,
      required this.question,
      required this.score});

  factory GeneratedQuestion.fromJson(Map<String, dynamic> json) =>
      GeneratedQuestion(
        bid: json["bid"],
        gid: json["gid"],
        question: json["question"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() =>
      {"bid": bid, "gid": gid, "question": question, "score": score};
}
