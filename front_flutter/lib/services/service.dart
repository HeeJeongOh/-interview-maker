import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safari_front/admin/edit.dart';
import 'package:safari_front/constants.dart';

import 'package:safari_front/model/base.dart';
import 'package:safari_front/model/generated.dart';

class Service {
  // 생애주기 질문 1가지
  Future<BaseQuestion> getBaseQuestion(
      {required int gender, required int cycle}) async {
    var response = await http.get(
      Uri.parse('http://$adminIP:8080/base/get?gender=$gender&cycle=$cycle'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Service: ${jsonDecode(utf8.decode(response.bodyBytes))}");
      return BaseQuestion.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load album');
    }
  }

  // 꼬리질문 3가지
  Future<List<GeneratedQuestion>> getGeneratedQuestion(
      {required int bid,
      required String question,
      required String answer}) async {
    List<GeneratedQuestion> list = [];

    final response = await http.post(
      Uri.parse('http://$adminIP:8080/generated/get'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "user_cycle": 0,
        "user_gender": 1,
        "bid": bid,
        "question": question,
        "answer": answer
      }),
    );

    if (response.statusCode == 200) {
      for (var json in jsonDecode(utf8.decode(response.bodyBytes))) {
        list.add(GeneratedQuestion.fromJson(json));
      }
      debugPrint("Service: ${list.toString()}");

      return list;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed ');
    }
  }
}
