import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/custom_widget.dart/card.dart';
import 'package:rspsa_user/screens/school_portal/controller/school_home_controller.dart';
import 'package:rspsa_user/screens/school_portal/school_profile_screen.dart';
import 'package:rspsa_user/screens/student_portal/contact_us_page.dart';
import 'package:rspsa_user/screens/student_portal/edit_profile_screen.dart';
import 'package:rspsa_user/screens/student_portal/program_screen.dart';
import 'package:rspsa_user/screens/student_portal/support_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

import '../../custom_widget.dart/appbarForStudent.dart';

class SchoolHomeScreen extends StatefulWidget {
  const SchoolHomeScreen({super.key});

  @override
  State<SchoolHomeScreen> createState() => _SchoolHomeScreenState();
}

class _SchoolHomeScreenState extends State<SchoolHomeScreen> {
  SchoolHomeController schoolHomeController = Get.put(SchoolHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      appBar: appBar(title: 'School Portal'),
      body: SafeArea(
          child: Obx(
        () => Stack(
          children: [
            Container(
              color: ColorHelper.primaryColor,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                top: 20.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          schoolHomeController.name.value,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Emial: ${schoolHomeController.userEmail.value}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Mobile: ${schoolHomeController.userMobile.value}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Registration No: 01325458",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(
                                width: 3,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0xFFE7E9EB),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              child:
                                  schoolHomeController.prfilePicture.value != ''
                                      ? Image.network(
                                          '${schoolHomeController.userFilePath.value}/${schoolHomeController.prfilePicture.value}',
                                          width: 40.w,
                                          height: 30.h,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.person),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(const SchoolProfileScreen());
                            },
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white),
                            ))
                      ],
                    ),
                  ],
                )),
            Positioned(
              top: 120.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r))),
                padding: EdgeInsets.only(top: 10.h),
                // width: 100,
                // height: 100,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(const ProgramScreen());
                            },
                            child: const CommonCard(
                              icon: Icons.menu,
                              title: 'Programs',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CommonCard(
                            icon: Icons.payments_outlined,
                            title: 'My Payout',
                          ),
                          CommonCard(
                            icon: Icons.file_download_outlined,
                            title: 'Downloads',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(const AboutUsPage());
                            },
                            child: const CommonCard(
                              icon: Icons.edit_outlined,
                              title: 'About Us',
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(const SupportScreen());
                            },
                            child: const CommonCard(
                              icon: Icons.people,
                              title: 'Support',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const CommonCard(
                              icon: Icons.pin_outlined,
                              title: 'My Referral',
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const CommonCard(
                              icon: Icons.autorenew_sharp,
                              title: 'Refer Us',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
