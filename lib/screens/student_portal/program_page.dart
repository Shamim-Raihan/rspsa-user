import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rspsa_user/utils/color_helper.dart';

import 'controller/studentController.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({Key? key}) : super(key: key);

  @override
  State<ProgramPage> createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  StudentController studentController= Get.put(StudentController());
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
          elevation: 0,toolbarHeight: 22.h,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 500.h,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 150.h,
                      width: MediaQuery.of(context).size.width,
                      color: ColorHelper.primaryColor,
                    ),
                  ),
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)
                                    )
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)
                                      ),
                                    child: Image.network(
                                      fit: BoxFit.fill,height: 210.h,
                                        "https://d502jbuhuh9wk.cloudfront.net/courses/626cbe520cf29b4764706df5/626cbe520cf29b4764706df5_scaled_cover.jpg?v=2"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nachiketa Scholarship Scheme',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Inter',
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 8.h,),
                                      Text(
                                        'Our Company Open An Application for Nachiketa Scholarship Scheme, There Any Student Who Appearing Any Educational School Institute They Can Apply For This Scheme and Grant Fix Scholarships for Own Monthly Education Expance.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontFamily: 'Inter',
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 8.h,),
                                      Text(
                                        'View Document',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight:
                                            FontWeight.w400,
                                            decoration: TextDecoration
                                                .underline),
                                      ),
                                      Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                     "Program Type",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontFamily: 'Inter',
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  Text(
                                                   "One Time",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontFamily: 'Inter',
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Registration Fee",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontFamily: 'Inter',
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "Rs 2000",
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontFamily: 'Inter',
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 445.h,
                    left: 92.w ,
                    child: InkWell(
                      child: SizedBox(
                        height: 55.h,
                        width: 180.w,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Color(0xFFEAA654),
                            elevation: 4,
                            child: Center(
                              child: Text(
                                studentController.myprogramview.value?'Quit Program':'Make Payment',
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
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:350.w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Icon(Icons.school_outlined, size: 30.sp, color: ColorHelper.primaryColor),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Talent No: 1",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:350.w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Icon(Icons.reduce_capacity, size: 30.sp, color: ColorHelper.primaryColor),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Nachiketa Scholarship Program",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:350.w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Icon(Icons.cruelty_free_outlined, size: 30.sp, color: ColorHelper.primaryColor),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "School Fee Waiver Program",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:350.w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Icon(Icons.calendar_month, size: 30.sp, color: ColorHelper.primaryColor),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Monthly Salary Program",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:350.w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Icon(Icons.join_right_outlined, size: 30.sp, color: ColorHelper.primaryColor),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Private School Grant Program",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width:350.w,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 35.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: Icon(Icons.holiday_village_outlined, size: 30.sp, color: ColorHelper.primaryColor),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Rural Education Program",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
