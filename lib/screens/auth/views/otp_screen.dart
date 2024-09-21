import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rspsa_user/controller/signup_controller.dart';
import 'package:rspsa_user/custom_widget.dart/common_components.dart';
import 'package:rspsa_user/custom_widget.dart/style_helper.dart';
import 'package:rspsa_user/screens/auth/controller/auth_controller.dart';
import 'package:rspsa_user/screens/student_portal/home_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

class OTPVerificationPage extends StatelessWidget {
  OTPVerificationPage({super.key});
  final commonComponents = CommonComponents();

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP Verification',
              style: StyleHelper.regular14,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text.rich(
              style: StyleHelper.regular14,
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Enter the code from the sms we sent to ',
                  ),
                  TextSpan(
                    text: '${_authController.mobileController.value.text} ',
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 100.h,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Obx(() => Text(
                        _authController.otpTime.value,
                        style: StyleHelper.regular14,
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Pinput(
                    controller: _authController.pinPutController,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: 40.w,
                      height: 40.h,
                      textStyle: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorHelper.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      _authController.otp.value = value;
                    },
                    onSubmitted: (value) async {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text.rich(
                    TextSpan(
                      style: StyleHelper.regular14,
                      children: const [
                        TextSpan(
                          text: "Didn't receive the ",
                        ),
                        TextSpan(
                          text: 'OTP? ',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.fromLTRB(20.sp, 0.sp, 20.sp, 30.sp),
                child: commonComponents.commonButton(
                  text: 'Submit',
                  onPressed: () async {
                    if (_authController.otp.value.length == 6) {
                      await _authController.validateOtp(
                        _authController.emailController.value.text,
                        _authController.otp.value,
                      );
                      Get.offAll(() => const HomeScreen());
                      EasyLoading.showToast('Successfully varifired');
                    } else {
                      EasyLoading.showToast('Please enter a valid 6-digit OTP');
                    }
                  },
                  isLoading: _authController.isOtpSubmitLoading.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
