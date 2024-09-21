import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/models/login_response.dart';
import 'package:rspsa_user/models/signIn_response.dart';
import 'package:rspsa_user/repository/login_repository.dart';
import 'package:rspsa_user/screens/auth/repository/auth_repository.dart';
import 'package:rspsa_user/screens/auth/views/login_screen.dart';
import 'package:rspsa_user/screens/auth/views/otp_screen.dart';
import 'package:rspsa_user/utils/app_config.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var nameController = TextEditingController().obs;
  var mobileController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var passwordObscure = false.obs;
  var confirmPasswordObscure = false.obs;
  var isSignup = false.obs;
  Rx<String?> selectedRole = Rx<String?>(null);
  List<String> role = ['Student', 'Teacher', 'Employee', 'School'];

  void updateSelectedCountry(String? value) {
    selectedRole.value = value;
  }

  signup() async {
    try {
      Map<String, dynamic> payload = {
        "type": selectedRole.value,
        "name": nameController.value.text,
        "email": emailController.value.text,
        "mobile": mobileController.value.text,
        "password": passwordController.value.text,
        "password_confirmation": confirmPasswordController.value.text
      };
      var response = await AuthRepository().signup(payload: payload);
      if (response != null) {
        if (response.status == 200) {
          EasyLoading.showToast(response.msg!);
          Get.offAll(() => const LoginScreen());
        }
      } else {
        EasyLoading.showToast(response!.msg!);
      }
    } catch (e) {
      EasyLoading.showToast('Login failed');
      log('Error while signing up form controller: $e');
    }
  }

  final TextEditingController pinPutController = TextEditingController();
  var otp = ''.obs;
  var isOtpSubmitLoading = false.obs;
  var otpTime = '02:00'.obs;
  Timer? _timer;
  int _start = 150;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        _start--;
        otpTime.value = _formatTime(_start);
      } else {
        timer.cancel();
        otpTime.value = "Time expired";
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  var isLoginCompeleted = false.obs;
  var selectedOption = 0.obs;
//---------------------------login//////////

  Future<void> login({required String email, required String password}) async {
    try {
      EasyLoading.show();
      AuthRepository authRepository = Get.put(AuthRepository());
      final response =
          await LoginRepository().login(email: email, password: password);
      if (response.status == true) {
        EasyLoading.showToast(response.msg ?? 'OTP sent to your email.');
        EasyLoading.dismiss();
        await Get.offAll(() => OTPVerificationPage());
      } else {
        EasyLoading.dismiss();
        EasyLoading.showToast('Something went wrong');
        // showToast(toastText: response.messages![0], toastColor: Colors.red);
      }
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      EasyLoading.showToast('Response failed');
    }
  }

//---------------------------------VerifyOtp////////////////

  final AuthRepository authRepository = Get.put(AuthRepository());
  Future<void> validateOtp(String email, String otp) async {
    try {
      isOtpSubmitLoading.value = true;
      EasyLoading.show(status: 'Verifying OTP...');
      await authRepository.validateOtp(email, otp);
      EasyLoading.showToast('OTP validated successfully.');
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showToast('OTP validation failed. Please try again.');
      print('Error: $e');
    } finally {
      isOtpSubmitLoading.value = false;
      EasyLoading.dismiss();
    }
  }

//---------------------------------------------RegisterUSer///
  var registrationResponse = SignInResponse(status: 0, msg: '').obs;
  final AuthRepository _authRepository = AuthRepository();

  Future<void> registerUser({
    required String type,
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      final response = await _authRepository.registerUser(
        type: type,
        name: name,
        email: email,
        mobile: mobile,
        password: password,
      );

      if (response != null) {
        registrationResponse.value = response;
      } else {
        Get.snackbar('Error', 'Registration failed, please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
