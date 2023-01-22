import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final dynamic press;
  final bool border;
  final String hint;
  final bool passwordVisible;
  double? boxHeight;
  double? boxWidth;

  RoundedPasswordField(
      {Key? key,
      required this.onChanged,
      required this.controller,
      required this.press,
      required this.hint,
      required this.border,
      required this.passwordVisible,
      this.boxHeight,
      this.boxWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScreenUtil.init(context);
    return Container(
      height: boxHeight ?? height / 14,
      width: boxWidth ?? double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      decoration: BoxDecoration(),
      child: TextField(
        obscureText: passwordVisible,
        onChanged: onChanged,
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(fontSize: 16.r, color: Color(0xFFB5B5B5)),
          suffixIcon: IconButton(
            icon: Icon(
              !passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Get.isDarkMode ? Colors.white54 : Colors.grey,
            ),
            onPressed: press,
          ),
          border: border ? OutlineInputBorder() : UnderlineInputBorder(),
        ),
      ),
    );
  }
}
