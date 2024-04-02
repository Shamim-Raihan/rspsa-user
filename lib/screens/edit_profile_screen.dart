import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:rspsa_user/utils/color_helper.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String _imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: false,
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 16.sp),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 3,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Color(0xFFE7E9EB),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.person),
                    ),
                  ),
                  Positioned(
                      bottom: 10.h,
                      right: 2.w,
                      child: const CircleAvatar(
                          backgroundColor: Color(0xffe7e9eb),
                          child: Icon(Icons.edit)))
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // TextField(
            //   controller: _nameController,
            //   decoration: InputDecoration(labelText: 'Name'),
            // ),
            SizedBox(
              height: 50.h,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  suffixIcon:
                      const Icon(Icons.person, color: ColorHelper.primaryColor),
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50.h,
              child: TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  suffixIcon: Icon(Icons.phone_android_rounded,
                      color: ColorHelper.primaryColor),
                  labelText: 'Mobile',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 50.h,
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorHelper.primaryColor, width: 1.2)),
                  suffixIcon: const Icon(Icons.location_city,
                      color: ColorHelper.primaryColor),
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.2)),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(100, 50)),
                backgroundColor:
                    MaterialStateProperty.all(ColorHelper.primaryColor),
              ),
              onPressed: _saveProfile,
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _saveProfile() {
    String name = _nameController.text;
    String mobile = _mobileController.text;
    String address = _addressController.text;

    // Print or use the values for demonstration purposes
    print('Name: $name');
    print('Mobile: $mobile');
    print('Address: $address');
    print('Image Path: $_imagePath');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
