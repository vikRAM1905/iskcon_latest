import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/passwordUpdate_controller.dart';

class PasswordUpdatePage extends StatefulWidget {
  PasswordUpdatePage({Key? key}) : super(key: key);

  @override
  State<PasswordUpdatePage> createState() => _PasswordUpdatePageState();
}

class _PasswordUpdatePageState extends State<PasswordUpdatePage> {
  final profileController = Get.put(PasswordUpdateController());
  bool isVisible1 = false;
  bool isVisible2 = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: TextStyle(fontFamily: "AnekTamil", color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          color: primaryColor,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Get.isDarkMode ? Colors.grey[600] : Color(0xFFFFFAF4),
            ),
            child: GetBuilder<PasswordUpdateController>(builder: (controller) {
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textFieldWidget(controller.passwordController, "Password",
                          controller.obscureText1.value, () {
                        controller.toggle1();
                      }),
                      textFieldWidget(
                          controller.rePasswordController,
                          "Re-Enter Password",
                          controller.obscureText2.value, () {
                        controller.toggle2();
                      }),
                      Spacer(),
                      GradientButton(
                        onPress: () =>
                            controller.updatePasswordValidation(context),
                        name: "Save & Continue",
                        size: Size(width / 1.2, height / 21.1),
                        border: false,
                        gradient: gradientOpp,
                      ),
                      SizedBox(
                        height: height / 28.1,
                      )
                    ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget(TextEditingController? controller, labelText,
      bool obscure, dynamic onPress) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: TextFormField(
        obscureText: obscure,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              !obscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: onPress,
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: primaryColor),
          enabled: true,
          border: UnderlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: primaryColor)),
        ),
      ),
    );
  }
}
