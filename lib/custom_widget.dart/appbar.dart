import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rspsa_user/screens/login_screen.dart';
import 'package:rspsa_user/utils/color_helper.dart';

AppBar appBar({required String title}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: ColorHelper.primaryColor,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(fontSize: 16.sp, color: Colors.white),
    ),
    centerTitle: true,
    toolbarHeight: 40,
    actions: const [
      Icon(
        Icons.notifications,
        color: Colors.white,
      ),
      MyCircleAvatar(),
    ],
  );
}

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) async {
        switch (value) {
          case 1:
            // Handle Profile option
            break;
          case 2:
            // Handle Change Password option
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
            break;
        }
      },
    );
  }
}
