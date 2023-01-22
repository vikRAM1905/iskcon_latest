import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  final bool border;
  double? boxHeight;
  double? boxWidth;
  final ValueChanged<String> onChanged;
  RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      required this.onChanged,
      required this.controller,
      required this.border,
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
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(fontSize: 16.r, color: Color(0xFFB5B5B5)),
          border: border ? OutlineInputBorder() : UnderlineInputBorder(),
        ),
      ),
    );
  }
}
