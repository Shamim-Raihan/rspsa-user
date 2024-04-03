import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/custom_widget.dart/appbar.dart';
import 'package:rspsa_user/custom_widget.dart/card.dart';
import 'package:rspsa_user/screens/contactUs_page.dart';
import 'package:rspsa_user/screens/edit_profile_screen.dart';
import 'package:rspsa_user/screens/gallery_screen.dart';
import 'package:rspsa_user/screens/programdetails_screen.dart';
import 'package:rspsa_user/screens/support_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

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
                        "Emial: student@gmail.com",
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
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(ProfileEdit());
                          },
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
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
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(ProgramDetailsScreen());
                          },
                          child: CommonCard(
                            icon: Icons.menu,
                            title: 'Programs',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(GalleryScreen());
                          },
                          child: CommonCard(
                            icon: Icons.photo_library_sharp,
                            title: 'Our Registration',
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
                        CommonCard(
                          icon: Icons.quiz_outlined,
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
                            Get.to(ContactUsPage());
                          },
                          child: CommonCard(
                            icon: Icons.edit_outlined,
                            title: 'About Us',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SupportScreen());
                          },
                          child: CommonCard(
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
                            Get.to(ContactUsPage());
                          },
                          child: CommonCard(
                            icon: Icons.edit_outlined,
                            title: 'Refer Us',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ContactUsPage());
                          },
                          child: CommonCard(
                            icon: Icons.edit_outlined,
                            title: 'Our Referral',
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
