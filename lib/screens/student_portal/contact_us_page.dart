import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  _launchPhone() async {
    const phoneNumber = '+5234534535';
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      // Handle error
    }
  }

  _launchEmail() async {
    const email = 'rspsa@gmail.com';
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: '',
    );

    var url = params.toString();
    try {
      print('Launching email with URL: $url');
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  _launchInstagram() async {
    const instagramUrl = 'https://rspsa.in/programs';
    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      print('failed');
    }
  }

  _launchFacebook() async {
    const facebookUrl = 'https://rspsa.in/programs';
    if (await canLaunch(facebookUrl)) {
      await launch(facebookUrl);
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        title: Text(
          'About Us',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 17.sp,
              fontWeight: FontWeight.w500),
        ),
        // leadingWidth: 30.w,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'You can get in touch with us through below \nplatforms.Our Team wil reach out to you as soon as it would be possible',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.7),
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(
                  height: 20.h,
                ),
                
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffDFE9EC)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h, bottom: 8.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Social Media',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                                fontFamily: 'Inter',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: _launchInstagram,
                            child: Row(
                              children: [
                                Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Color(0xFFDCE0E6)),
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                      ),
                                    ),
                                    child: Image.asset('images/insta.png')),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' Instagram',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                          fontFamily: 'Inter',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      '@rspsa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: _launchFacebook,
                            child: Row(
                              children: [
                                Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Color(0xFFDCE0E6)),
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                      ),
                                    ),
                                    child:
                                        Image.asset('images/facbookicon.png')),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' Facbook',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                          fontFamily: 'Inter',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      '@rspsa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Inter',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 70.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logo.png',
                        height: 100.h,
                        width: 100.w,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
