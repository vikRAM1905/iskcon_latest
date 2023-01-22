// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key,
      required this.onPress,
      required this.name,
      required this.size,
      this.fontSize,
      this.gradient,
      Color? this.txtColor,
      bool? this.border})
      : super(key: key);
  final dynamic onPress;
  final String name;
  final Size size;
  final double? fontSize;
  final Gradient? gradient;
  final txtColor;
  final border;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.black87,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
    ScreenUtil.init(context);
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: border ? null : gradient ?? myGradient,
        border: border
            ? Border.all(
                color: Color(0xFFF83600),
              )
            : null,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Color(0xFFF83600)),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5));
          }),
        ),
        // splashColor: Color(0xFFF83600),
        child: Text(
          name,
          maxLines: 1,
          style: TextStyle(
              fontSize: fontSize ?? 16,
              fontFamily: "AnekTamil",
              color: txtColor ?? Colors.white,
              // fontSize: fontSize ?? 18,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        onPressed: onPress,
        onLongPress: () {},
      ),
    );
  }
}
