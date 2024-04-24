import 'package:get/get.dart';
import 'package:rspsa_user/utils/constants.dart';
import 'package:rspsa_user/utils/shared_preference_helper.dart';

class StudentHomeController extends GetxController {
  var name = ''.obs;
  var userEmail = ''.obs;
  var userMobile = ''.obs;

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
  }
}
