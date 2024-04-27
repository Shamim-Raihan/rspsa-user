import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/custom_widget.dart/appbarForStudent.dart';
import 'package:rspsa_user/custom_widget.dart/card.dart';
import 'package:rspsa_user/screens/student_portal/contact_us_page.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_home_controller.dart';
import 'package:rspsa_user/screens/student_portal/edit_profile_screen.dart';
import 'package:rspsa_user/screens/student_portal/gallery_screen.dart';
import 'package:rspsa_user/screens/student_portal/program_screen.dart';
import 'package:rspsa_user/screens/student_portal/support_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StudentHomeController studentHomeController =
      Get.put(StudentHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      appBar: appBar(title: "Student Portal"),
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            color: ColorHelper.primaryColor,
            width: double.infinity,
            height: double.infinity,
          ),
          Obx(
            () => Positioned(
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
                          studentHomeController.name.value,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Emial: ${studentHomeController.userEmail.value}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Mobile: ${studentHomeController.userMobile.value}",
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
                                  studentHomeController.prfilePicture.value !=
                                          ''
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          child: Image.network(
                                            '${studentHomeController.userFilePath.value}/${studentHomeController.prfilePicture.value}',
                                            width: 40.w,
                                            height: 30.h,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(Icons.person),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(const ProfileEdit());
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
          ),
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
                            studentHomeController.getProgramList();
                            studentHomeController.getMyProgramList();
                            Get.to(const ProgramScreen());
                          },
                          child: const CommonCard(
                            icon: Icons.menu,
                            title: 'Programs',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const GalleryScreen());
                          },
                          child: const CommonCard(
                            icon: Icons.photo_library_sharp,
                            title: 'Gallery',
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
                          icon: Icons.quiz_outlined,
                          title: 'My Result',
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonCard(
                          icon: Icons.payment,
                          title: 'Fee Payments',
                        ),
                        CommonCard(
                          icon: Icons.app_registration,
                          title: 'Registration Status',
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
