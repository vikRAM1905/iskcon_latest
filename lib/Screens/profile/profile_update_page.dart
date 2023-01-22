import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iskcon/Utils/custColors.dart';
import 'package:iskcon/widgets/gradientButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/profileUpdate_controller.dart';

class ProfileUpdatePage extends StatelessWidget {
  ProfileUpdatePage({Key? key}) : super(key: key);
  final profileController = Get.put(ProfileUpdateController());

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
          "My Profile",
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
          child: GetBuilder<ProfileUpdateController>(builder: (controller) {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                    strokeWidth: 1.5,
                  ))
                : Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height / 16.88,
                          ),
                          Stack(
                            children: [
                              controller.imageFile != null
                                  ? CircleAvatar(
                                      radius: 50.0.r,
                                      backgroundImage: FileImage(
                                          File(controller.imageFile!.path)),
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                    )
                                  : CircleAvatar(
                                      radius: 50.0.r,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              controller.profPic),
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                    ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 15,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: height / 6.02,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: <Widget>[
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _getFromGallery();
                                                        },
                                                        child: Text(
                                                            "PICK FROM GALLERY"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _getFromCamera();
                                                        },
                                                        child: Text(
                                                            "PICK FROM CAMERA"),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: height / 28.1,
                          ),
                          textFieldWidget(
                              controller.fNameController, true, "First Name"),
                          textFieldWidget(
                              controller.lNameController, true, "Last Name"),
                          textFieldWidget(
                              controller.emailController, false, "Email"),
                          textFieldWidget(controller.mobileController, false,
                              "Mobile Number"),
                          Spacer(),
                          GradientButton(
                            onPress: () =>
                                controller.updateProfileValidation(context),
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
    ));
  }

  Future<File?> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 400,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      profileController.imageFile = File(pickedFile.path);
      print("imageFile :- ${profileController.imageFile}");
      profileController.update();
      Get.back();
    }
    return null;
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 400,
      maxHeight: 500,
    );
    if (pickedFile != null) {
      profileController.imageFile = File(pickedFile.path);
      print("imageFile :- ${profileController.imageFile}");
      profileController.update();
      Get.back();
    }
  }

  Widget textFieldWidget(
      TextEditingController? controller, isEnable, labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: TextFormField(
        style: !isEnable ? TextStyle(color: Colors.grey) : TextStyle(),
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: primaryColor),
          enabled: isEnable,
          border: UnderlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: primaryColor)),
        ),
      ),
    );
  }
}
