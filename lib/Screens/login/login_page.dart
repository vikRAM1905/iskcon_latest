import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Screens/register/register_page.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/controller/login_controller.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:iskcon/widgets/password_input_field.dart';
import 'package:iskcon/widgets/rounded_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginController = Get.put(LoginController());

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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: height / 6.85,
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
                "Login",
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
            GetBuilder<LoginController>(builder: (loginController) {
              return RoundedInputField(
                hintText: 'மின்னஞ்சல் / தொலைபேசி',
                onChanged: (value) {},
                controller: loginController.emailController,
                border: true,
              );
            }),
            GetBuilder<LoginController>(builder: (loginController) {
              return RoundedPasswordField(
                onChanged: (value) {},
                controller: loginController.passwordController,
                hint: '*************',
                press: () {
                  setState(() {
                    loginController.passwordVisible =
                        !loginController.passwordVisible;
                  });
                },
                passwordVisible: loginController.passwordVisible,
                border: true,
              );
            }),
            SizedBox(height: size.height * 0.03),
            GetBuilder<LoginController>(builder: (loginController) {
              return Align(
                alignment: Alignment.center,
                child: GradientButton(
                  name: "Login",
                  size: Size(width / 1.05, height / 18.1),
                  onPress: () async {
                    var result = await (Connectivity().checkConnectivity());
                    if (result == ConnectivityResult.wifi ||
                        result == ConnectivityResult.mobile) {
                      loginController.validation(
                          context,
                          loginController.emailController.text,
                          loginController.passwordController.text);
                    } else {
                      Get.snackbar('Internet', 'No Internet Connection',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white);
                    }
                  },
                  border: false,
                  fontSize: 18,
                ),
              );
            }),
            SizedBox(height: size.height * 0.03),
            // Align(
            //   alignment: Alignment.center,
            //   child: GradientButton(
            //     name: "Sign Up",
            //     size: Size(width / 1.05, height / 18.1),
            //     onPress: () async {
            //       var result = await (Connectivity().checkConnectivity());
            //       if (result == ConnectivityResult.wifi ||
            //           result == ConnectivityResult.mobile) {
            //         Get.to(RegisterPage());
            //       } else {
            //         Get.snackbar('Internet', 'No Internet Connection',
            //             snackPosition: SnackPosition.BOTTOM,
            //             backgroundColor: Colors.red,
            //             colorText: Colors.white);
            //       }
            //     },
            //     border: true,
            //     txtColor: primaryColor,
            //     fontSize: 18,
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
