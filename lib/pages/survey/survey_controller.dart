import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/helpers/dialog_helper.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/providers/surveys_provider.dart';

class SurveyController extends GetxController {
  SurveysProvider surveysProvider = SurveysProvider();

  List<dynamic> skinTypeList = [];
  List<dynamic> quesList = [];

  var count1 = 0.0.obs;
  var count2 = 0.0.obs;
  var count3 = 0.0.obs;
  var count4 = 0.0.obs;

  var resultId = 1.obs;

  var isAnalyze = false.obs;

  List<RxInt> countMap = [
    0.obs,
    0.obs,
    0.obs,
    0.obs,
  ];

  var answer1 = ''.obs;
  var answer2 = ''.obs;
  var answer3 = ''.obs;
  var answer4 = ''.obs;

  loadData() async {
    await getSkinType();
    await getSkinTypeQues();
  }

  void addAnswer(int index, int answer) {
    countMap[index].value = answer;
    // print("countMap : ${countMap}");
  }

  Future<void> getSkinType() async {
    skinTypeList = await surveysProvider.getAllSkinType();
    // print(skinTypeList);
  }

  Future<void> getSkinTypeQues() async {
    quesList = await surveysProvider.getAllQues();
    print(quesList);
  }

  void analyzing(PageController controller) {
    DialogHelper.showLoading("Đang phân tích...");
    updateUserSkinType().then((_) {
      Future.delayed(const Duration(seconds: 2)).then((_) {
        controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        isAnalyze.value = true;
        DialogHelper.hideLoading();
      });
    });
  }

  updateUserSkinType() async {
    // late int id;
    List<int> countList = countMap.map((rxInt) => rxInt.value).toList();
    if (countMap.where((value) => value.value == 0).isEmpty) {
      int highestValue = countList
          .reduce((value, element) => value > element ? value : element);
      if (highestValue == 1) {
        resultId.value = 4;
      } else {
        resultId.value = countList.indexOf(highestValue) + 1;
      }
    }

    ResponseApi responseApi =
        await surveysProvider.updateUserSkinType(resultId.value);
    if (responseApi.success == true) {}
  }
}
