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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,

        elevation: 2,
        margin: EdgeInsets.only(top: 15.h, right: 8.w, left: 8.w),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF1F0F0),
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 38.h,
                  width: 43.w,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFEAA654),

                          Colors.amber.withOpacity(0.5),
                        ],
                      ),
                    border: Border.all(color: ColorHelper.primaryColor.withOpacity(0.8)),
                      //color: Colors.black,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Icon(icon, size: 30.sp, color: Colors.white),
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
      ),
    );
  }
}
