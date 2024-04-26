import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/student_portal/repository/student_home_repository.dart.dart';
import 'package:rspsa_user/utils/constants.dart';
import 'package:rspsa_user/utils/shared_preference_helper.dart';

class StudentHomeController extends GetxController {
  var name = ''.obs;
  var userEmail = ''.obs;
  var userMobile = ''.obs;
  var userFilePath = ''.obs;
  var prfilePicture = ''.obs;
  var progeramList = [].obs;
  var myProgramList = [].obs;
  var programDetailsList = [].obs;
  var selectedProgramIndex = 0.obs;

    @override
    void onInit() {
      getData();
      super.onInit();
    }

    getData() {
      getInitialData();
    }

    getInitialData() async {
      name.value = (await SharedPreferenceHelper().getString(key: userName))!;
      userEmail.value = (await SharedPreferenceHelper().getString(key: email))!;
      userMobile.value = (await SharedPreferenceHelper().getString(key: mobile))!;
      userFilePath.value =
          (await SharedPreferenceHelper().getString(key: filePath))!;
      prfilePicture.value = (await SharedPreferenceHelper().getString(key: image))!;
    }

  Future<void> getProgramList() async {
    progeramList.clear();
    try {
      EasyLoading.show();
      var response = await StudentHomeRepository().getProgramList();
      EasyLoading.dismiss();
      progeramList.value = response.data!;
      log('program list len : ${progeramList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getProgramCategoryList: $e');
    }
  }

  Future<void> getMyProgramList() async {
    myProgramList.clear();
    try {
      EasyLoading.show();
      String? usertTalentId =
          (await SharedPreferenceHelper().getString(key: talentId))!;
      var response = await StudentHomeRepository()
          .getMyProgramList(talentId: usertTalentId);
      EasyLoading.dismiss();
      myProgramList.value = response.data!;
      log(' my program list len : ${myProgramList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getProgramList: $e');
    }
  }

  Future<void> getProgramDetailsList({required String talentId}) async {
    programDetailsList.clear();
    try {
      EasyLoading.show();
      var response = await StudentHomeRepository()
          .getTalentDetailsList(talentId: talentId);
      EasyLoading.dismiss();
      programDetailsList.value = response.data!;
      log('program details list len : ${programDetailsList.length}');
    } catch (e) {
      EasyLoading.dismiss();
      log('Error form getTalentDetailsList: $e');
    }
  }
}
