import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rspsa_user/utils/color_helper.dart';

class CommonCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const CommonCard({super.key, 
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.w,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 1,
        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(13.r)),
                child: Icon(icon, size: 30.sp, color: ColorHelper.primaryColor),
              ),
              SizedBox(height: 13.h),
              Text(
                title,
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
    );
  }
}
