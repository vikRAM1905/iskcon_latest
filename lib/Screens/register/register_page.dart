import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:iskcon/controller/login_controller.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:iskcon/widgets/password_input_field.dart';
import 'package:iskcon/widgets/rounded_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Utils/custColors.dart';
import '../../controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var registerController = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: height / 13.70,
            ),
            Center(
              child: Container(
                height: height / 4.2,
                width: width / 1.9,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset('assets/images/iskcon_logo_lotus.png'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                "Register",
                minFontSize: 20,
                style: TextStyle(
                    fontFamily: "AnekTamil",
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
            SizedBox(
              height: height / 84.4,
            ),
            Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                "இஸ்கானின் மாதாந்திர பத்திரிகை",
                minFontSize: 16,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "AnekTamil",
                  height: 1.5,
                  color: Color(0xFF454545),
                ),
              ),
            ),
            SizedBox(
              height: height / 42.2,
            ),
            GetBuilder<RegisterController>(builder: (registerController) {
              return RoundedInputField(
                boxHeight: 50,
                hintText: 'First Name',
                onChanged: (value) {},
                controller: registerController.fNameController,
                border: true,
              );
            }),
            GetBuilder<RegisterController>(builder: (registerController) {
              return RoundedInputField(
                boxHeight: 50,
                hintText: 'Email',
                onChanged: (value) {},
                controller: registerController.emailController,
                border: true,
              );
            }),
            GetBuilder<RegisterController>(builder: (registerController) {
              return Container(
                height: height / 18,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                decoration: BoxDecoration(),
                child: TextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? date = DateTime.now();

                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    registerController.dobController.text =
                        DateFormat("dd-MM-yyyy").format(date!);
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: registerController.dobController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    labelStyle:
                        TextStyle(fontSize: 16.r, color: Color(0xFFB5B5B5)),
                    border: OutlineInputBorder(),
                  ),
                ),
              );
            }),
            GetBuilder<RegisterController>(builder: (registerController) {
              return RoundedInputField(
                boxHeight: 50,
                hintText: 'Mobile Number',
                onChanged: (value) {},
                controller: registerController.phoneController,
                border: true,
              );
            }),
            GetBuilder<RegisterController>(builder: (regitserController) {
              return RoundedPasswordField(
                boxHeight: 50,
                onChanged: (value) {},
                controller: regitserController.passwordController,
                hint: 'Password',
                press: () {
                  setState(() {
                    regitserController.passwordVisible =
                        !regitserController.passwordVisible;
                  });
                },
                passwordVisible: regitserController.passwordVisible,
                border: true,
              );
            }),
            GetBuilder<RegisterController>(builder: (regitserController) {
              return RoundedPasswordField(
                boxHeight: 50,
                onChanged: (value) {},
                controller: regitserController.cPasswordController,
                hint: 'Confirm Password',
                press: () {
                  setState(() {
                    regitserController.cPasswordVisible =
                        !regitserController.cPasswordVisible;
                  });
                },
                passwordVisible: regitserController.cPasswordVisible,
                border: true,
              );
            }),
            SizedBox(height: size.height * 0.03),
            GetBuilder<RegisterController>(builder: (registerController) {
              return Align(
                  alignment: Alignment.center,
                  child: GradientButton(
                    name: "Register",
                    size: Size(width / 1.05, height / 18.1),
                    onPress: () async {
                      var result = await (Connectivity().checkConnectivity());
                      if (result == ConnectivityResult.wifi ||
                          result == ConnectivityResult.mobile) {
                        registerController.validation(
                            context,
                            registerController.fNameController.text,
                            registerController.dobController.text,
                            registerController.emailController.text,
                            registerController.phoneController.text,
                            registerController.passwordController.text,
                            registerController.cPasswordController.text);
                      } else {
                        Get.snackbar('Internet', 'No Internet Connection',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                    border: false,
                    fontSize: 18,
                  ));
            }),
          ]),
        ),
      ),
    );
  }
}
