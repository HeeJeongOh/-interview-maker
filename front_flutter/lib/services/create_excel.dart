import 'dart:io';

import 'package:download/download.dart';
import 'package:safari_front/constants.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;

class CreateExcel {
  Map<int, String> genderMap = {1: "남", 2: "여"};
  Map<int, String> cycleMap = {0: "아동기-청소년기", 1: "청년기", 2: "중년기", 3: "노년기"};

  Future<void> generateExcel(List<List<String>> results) async {
    final Workbook workbook = Workbook(); // create a new excel workbook
    final Worksheet sheet = workbook.worksheets[
        0]; // the sheet we will be populating (only the first sheet)
    String excelFile =
        '${user.name}_인터뷰_${DateTime.timestamp().toIso8601String().substring(0, 10)}'; // the name of the excel

    /// design how the data in the excel sheet will be presented
    sheet.getRangeByIndex(1, 2).setText('성함');
    sheet.getRangeByIndex(1, 3).setText('연령대(생애주기)');
    sheet.getRangeByIndex(1, 4).setText('성별');

    sheet.getRangeByIndex(2, 2).setText(user.name);
    sheet.getRangeByIndex(2, 3).setText(cycleMap[user.cycle]);
    sheet.getRangeByIndex(2, 4).setText('${genderMap[user.gender]}');

    /// you can get the cell to populate by index e.g., (1, 1) or by name e.g., (A1)
    // set the titles for the subject results we want to fetch
    sheet.getRangeByIndex(4, 2).setText('질문'); // example class
    sheet.getRangeByIndex(4, 3).setText('답변');

    // loop through the results to set the data in the excel sheet cells
    for (var i = 0; i < results.length; i++) {
      if (results[i][0] != "생애주기") {
        sheet.getRangeByIndex(i + 5, 2).setText(results[i][0]);
        sheet.getRangeByIndex(i + 5, 3).setText(results[i][1]);
      }
    }
    // save the document in the downloads file
    download(Stream.fromIterable(workbook.saveAsStream()), '$excelFile.xlsx');

    //dispose the workbook
    workbook.dispose();
  }
}
