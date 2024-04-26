import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_controller.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_home_controller.dart';
import 'package:rspsa_user/screens/student_portal/program_details_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';

class ProgramScreen extends StatefulWidget {
  const ProgramScreen({super.key});

  @override
  State<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  StudentHomeController studentHomeController =
      Get.put(StudentHomeController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  StudentController studentController = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          surfaceVariant: Colors.transparent,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                width: 375.w,
                height: 51.h,
                color: Colors.white,
                child: Center(
                  child: TabBar(
                    labelStyle: TextStyle(
                        color: const Color(0xff6B7280),
                        fontFamily: 'Inter',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                    labelColor: const Color(0xFF11262C),
                    unselectedLabelColor: Colors.grey,
                    // isScrollable: true,
                    controller: _tabController,
                    padding: EdgeInsets.zero,

                    indicatorPadding: EdgeInsets.zero,
                    // labelPadding: EdgeInsets.symmetric(horizontal: 35.w),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: ColorHelper.primaryColor,
                        width: 3.0,
                      ),
                    ),
                    // indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        text: 'All Programs',
                      ),
                      Tab(text: 'My Programs'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildAllProgramView(),
                    buildMyProgramView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMyProgramView() {
    return Obx(
      () => ListView.builder(
          itemCount: studentHomeController.myProgramList.length,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                studentController.myprogramview.value = true;
                studentHomeController.selectedProgramIndex.value = index;
                studentHomeController.getProgramDetailsList(
                    talentId:
                        studentHomeController.myProgramList[index].talentId);
                Get.to(() => ProgramDetailsScreen(
                      program: studentHomeController.myProgramList[index],
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r))),
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          // height: 100.h,
                          // width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.grey.withOpacity(0.3)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              children: [
                                SpaceHelper().verticalSpace10,
                                Center(
                                    child: Container(
                                  constraints: const BoxConstraints(),
                                  height: 60.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  // color: Colors.amber,
                                  child: studentHomeController
                                              .myProgramList[index].image !=
                                          null
                                      ? Image.asset(
                                          'images/logo.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          '${studentHomeController.userFilePath.value}/${studentHomeController.myProgramList[index].image}',
                                          fit: BoxFit.cover,
                                        ),
                                )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ',
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '${studentHomeController.myProgramList[index].name}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description: ',
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '${studentHomeController.myProgramList[index].description}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Document: ',
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      'View Document',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        color: ColorHelper.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Quit',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Download',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  Widget buildAllProgramView() {
    return Obx(
      () => ListView.builder(
          itemCount: studentHomeController.progeramList.length,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                studentController.myprogramview.value = false;
                studentHomeController.selectedProgramIndex.value = index;
                studentHomeController.getProgramDetailsList(
                    talentId:
                        studentHomeController.progeramList[index].talentId);
                Get.to(() => ProgramDetailsScreen(
                      program: studentHomeController.progeramList[index],
                    ));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r))),
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.grey.withOpacity(0.3)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              children: [
                                SpaceHelper().verticalSpace10,
                                Center(
                                    child: Container(
                                  constraints: const BoxConstraints(),
                                  height: 60.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  // color: Colors.amber,
                                  child: studentHomeController
                                              .progeramList[index].image !=
                                          null
                                      ? Image.network(
                                          '${studentHomeController.userFilePath.value}/${studentHomeController.progeramList[index].image}',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'images/logo.png',
                                          fit: BoxFit.cover,
                                        ),
                                )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name: ',
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${studentHomeController.progeramList[index].name} ',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description: ',
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '${studentHomeController.progeramList[index].description}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Document: ',
                                      style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      'View Document',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  )),
            );
          }),
    );
  }
}
