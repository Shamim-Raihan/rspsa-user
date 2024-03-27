import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_helper.dart';

class CustomTextField {
  Widget textField(
      {required TextEditingController controller, required String levelText}) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorHelper.primaryColor, width: 1.2)),
          suffixIcon:
              const Icon(Icons.mail_outline, color: ColorHelper.primaryColor),
          labelText: levelText,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.2)),
        ),
      ),
    );
  }
}
