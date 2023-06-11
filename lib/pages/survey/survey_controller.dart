import 'package:get/get.dart';
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
    // countMap[index]!.value = answer;
    countMap[index].value = answer;
    print("countMap : ${countMap}");
  }

  Future<void> getSkinType() async {
    skinTypeList = await surveysProvider.getAllSkinType();
  }

  Future<void> getSkinTypeQues() async {
    quesList = await surveysProvider.getAllQues();
  }
}
