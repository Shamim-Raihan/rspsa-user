import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rspsa_user/custom_widget.dart/space_helper.dart';
import 'package:rspsa_user/utils/color_helper.dart';

class CommonComponents {
  Widget printText(
      {required int fontSize,
      required String textData,
      required FontWeight fontWeight,
      Color? color = Colors.white,
      int maxLine = 1}) {
    return Text(
      textData,
      textAlign: TextAlign.start,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: fontWeight, fontSize: fontSize.sp, color: color),
    );
  }

  Widget commonButton({
    required text,
    required VoidCallback onPressed,
    bool disabled = false,
    Icon? icon,
    String? imagePath,
    double borderRadius = 24,
    double fontSize = 16,
    Color color = ColorHelper.primaryColor,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: disabled ? Colors.grey : color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: isLoading
              ? Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorHelper.whiteColor,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ??
                        (imagePath != null
                            ? Image.asset(imagePath)
                            : const SizedBox()),
                    SpaceHelper.horizontalSpace5,
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: fontSize.sp, // Text size
                        fontWeight: FontWeight.bold, // Text weight
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
