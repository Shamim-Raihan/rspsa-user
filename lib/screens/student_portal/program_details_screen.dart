import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/screens/student_portal/controller/student_home_controller.dart';
import 'package:rspsa_user/utils/color_helper.dart';
import 'package:rspsa_user/utils/space_helper.dart';

import '../../models/program_list_response.dart';
import 'controller/student_controller.dart';

class ProgramDetailsScreen extends StatefulWidget {
  final ProgramList program;
  const ProgramDetailsScreen({Key? key, required this.program})
      : super(key: key);

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  StudentController studentController = Get.put(StudentController());
  StudentHomeController studentHomeController =
      Get.put(StudentHomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Program Detail',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontSize: 19.sp,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: ColorHelper.primaryColor,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          elevation: 0,
          toolbarHeight: 22.h,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 350.h,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                          // Positioned(
                          //   top: 0,
                          //   child: Container(
                          //     height: 150.h,
                          //     width: MediaQuery.of(context).size.width,
                          //     color: ColorHelper.primaryColor,
                          //   ),
                          // ),
                          Positioned(
                            top: 1.h,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: ColorHelper.primaryColor,
                                  elevation: 2,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 210.h,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12))),
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12)),
                                            child: widget.program.image != null
                                                ? Image.network(
                                                    fit: BoxFit.fill,
                                                    height: 210.h,
                                                    "${studentHomeController.userFilePath.value}/${widget.program.image}")
                                                : Image.asset(
                                                    fit: BoxFit.fill,
                                                    height: 210.h,
                                                    "images/logo.png"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${widget.program.name}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Inter',
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                '${widget.program.description}',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontFamily: 'Inter',
                                                    fontSize: 17.sp,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Text(
                                                'View Document',
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    decoration:
                                                        TextDecoration.underline),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Details',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      Obx(
                        () => Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                studentHomeController.programDetailsList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Registration For",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '${studentHomeController.programDetailsList[index].registrationFor}',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontFamily: 'Inter',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SpaceHelper().horizoantalSpace5,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Enrollment Fee",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '${studentHomeController.programDetailsList[index].enrollmentFee}',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontFamily: 'Inter',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SpaceHelper().verticalSpace5,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Fee Refundable",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '${studentHomeController.programDetailsList[index].feeRefundable}',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontFamily: 'Inter',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SpaceHelper().horizoantalSpace5,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Participation Period",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Inter',
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '${studentHomeController.programDetailsList[index].participationPeriod}',
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontFamily: 'Inter',
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
         
            InkWell(
              child: SizedBox(
                height: 55.h,
                width: 180.w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color(0xFFEAA654),
                    elevation: 4,
                    child: Center(
                      child: Text(
                        studentController.myprogramview.value
                            ? 'Quit Program'
                            : 'Make Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
