import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/custom_widget.dart/card.dart';
import 'package:rspsa_user/screens/employee_portal/employee_profile_screen.dart';
import 'package:rspsa_user/screens/employee_portal/employee_signup_screen.dart';
import 'package:rspsa_user/screens/student_portal/contact_us_page.dart';
import 'package:rspsa_user/screens/student_portal/edit_profile_screen.dart';
import 'package:rspsa_user/screens/student_portal/program_screen.dart';
import 'package:rspsa_user/screens/student_portal/support_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

import '../../custom_widget.dart/appbarForStudent.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      appBar: appBar(title: 'Employee Portal'),
      body: SafeArea(
          child: Stack(
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
                        "Employee Name",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Email: student@gmail.com",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Mobile: 7888889999999",
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
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(const EmployeeProfileScreen());
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
                        InkWell(
                          onTap: () {},
                          child: const CommonCard(
                            icon: Icons.app_registration,
                            title: 'Our Registration',
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
                          onTap: () {
                            Get.to(const AboutUsPage());
                          },
                          child: const CommonCard(
                            icon: Icons.autorenew_sharp,
                            title: 'Refer Us',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const AboutUsPage());
                          },
                          child: const CommonCard(
                            icon: Icons.pin_outlined,
                            title: 'My Referral',
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
      )),
    );
  }
}
