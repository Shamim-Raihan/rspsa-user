import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../../utils/shared_preference_helper.dart';

class SchoolHomeController extends GetxController {
  var name = ''.obs;
  var userEmail = ''.obs;
  var userMobile = ''.obs;
  var userFilePath = ''.obs;
    var prfilePicture = ''.obs;
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
}
