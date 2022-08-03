import 'package:admin/models/teacher_create_request_model.dart';
import 'package:admin/screens/home_page_view.dart';
import 'package:admin/utils/appsize/appsize.dart';
import 'package:admin/utils/network_util/network.dart';
import 'package:admin/utils/themes/theme.dart';
import 'package:admin/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateTeacher extends StatefulWidget {
  const CreateTeacher({Key? key}) : super(key: key);

  @override
  State<CreateTeacher> createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController fatherNameEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController maxAllowedStudentsEditingController =
      TextEditingController();

  bool _validateUserName = false;
  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateFatherName = false;
  bool _validatePhoneNumber = false;
  bool _validatePassword = false;
  bool _validateMaxAllowedStudent = false;

  bool _isLoding = false;
  @override
  void dispose() {
    super.dispose();
    userNameEditingController.dispose();
    firstNameEditingController.dispose();
    lastNameEditingController.dispose();
    fatherNameEditingController.dispose();
    phoneNumberEditingController.dispose();
    passwordEditingController.dispose();
    maxAllowedStudentsEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_backspace_outlined,
            size: 30,
            color: Themes.primaryTextcolor,
          ),
        ),
        title: Text(
          "Məllim əlavə edin",
          style: TextStyle(color: Themes.primaryTextcolor, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(height: 20),
            Container(
              width: (MediaQuery.of(context).size.width < 550)
                  ? AppSize.calculateWidth(context, 400)
                  : AppSize.calculateWidth(context, 200),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Themes.primaryColor.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomTextFieldWidget(
                        textEditingController: userNameEditingController,
                        validate: _validateUserName,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'İstifadəçi adı'),
                    SizedBox(height: 13),
                    CustomTextFieldWidget(
                        textEditingController: firstNameEditingController,
                        validate: _validateFirstName,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'Adı'),
                    SizedBox(height: 13),
                    CustomTextFieldWidget(
                        textEditingController: lastNameEditingController,
                        validate: _validateLastName,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'Soyadı'),
                    SizedBox(height: 13),
                    CustomTextFieldWidget(
                        textEditingController: fatherNameEditingController,
                        validate: _validateFatherName,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'Ata adı'),
                    SizedBox(height: 13),
                    CustomTextFieldWidget(
                        textEditingController: phoneNumberEditingController,
                        validate: _validatePhoneNumber,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'Nömrəsi'),
                    SizedBox(height: 13),
                    CustomTextFieldWidget(
                        textEditingController: passwordEditingController,
                        validate: _validatePassword,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'Şifrəsi'),
                    SizedBox(height: 13),
                    CustomTextFieldWidget(
                        textEditingController:
                            maxAllowedStudentsEditingController,
                        validate: _validateMaxAllowedStudent,
                        textInputType: TextInputType.number,
                        errorText: 'Bu xana boş qala bilməz',
                        labelText: 'Tələbə sayı'),
                    SizedBox(height: 20),
                    (_isLoding == false)
                        ? Container(
                            height: 50,
                            width: 150,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    userNameEditingController.text.isEmpty
                                        ? _validateUserName = true
                                        : _validateUserName = false;
                                    firstNameEditingController.text.isEmpty
                                        ? _validateFirstName = true
                                        : _validateFirstName = false;
                                    lastNameEditingController.text.isEmpty
                                        ? _validateLastName = true
                                        : _validateLastName = false;
                                    fatherNameEditingController.text.isEmpty
                                        ? _validateFatherName = true
                                        : _validateFatherName = false;
                                    phoneNumberEditingController.text.isEmpty
                                        ? _validatePhoneNumber = true
                                        : _validatePhoneNumber = false;
                                    passwordEditingController.text.isEmpty
                                        ? _validatePassword = true
                                        : _validatePassword = false;
                                    maxAllowedStudentsEditingController
                                            .text.isEmpty
                                        ? _validateMaxAllowedStudent = true
                                        : _validateMaxAllowedStudent = false;
                                    passwordEditingController.text.isEmpty
                                        ? _validatePassword = true
                                        : _validatePassword = false;

                                    if (_validateUserName == false &&
                                        _validateFirstName == false &&
                                        _validateLastName == false &&
                                        _validateFatherName == false &&
                                        _validatePhoneNumber == false &&
                                        _validatePassword == false &&
                                        _validateMaxAllowedStudent == false) {
                                      createTeacher();
                                    }
                                  });
                                },
                                child: Text(
                                  "Əlavə et",
                                  style: TextStyle(
                                      color: Themes.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Themes.primaryColor.withOpacity(0.25),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Themes.primaryColor, width: 1)),
                          )
                        : SpinKitFadingCircle(color: Themes.primaryColor)
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  createTeacher() async {
    setState(() {
      _isLoding = true;
    });
    TeacherCreateRequestModel teacherCreateRequestModel =
        TeacherCreateRequestModel(
            finNumber: userNameEditingController.text,
            firstName: firstNameEditingController.text,
            lastName: lastNameEditingController.text,
            fatherName: fatherNameEditingController.text,
            phoneNumber: phoneNumberEditingController.text,
            password: passwordEditingController.text,
            maxAllowedStudents:
                int.parse(maxAllowedStudentsEditingController.text),
            membershipExpiredMessage: 'Tələbənin vaxti bitmişdir');
    var response = await WebService.teacherCreate(teacherCreateRequestModel);
    if (response == true) {
      setState(() {
        _isLoding = false;
      });
      showTopSnackBar(context,
          CustomSnackBar.success(message: 'Məllim uğurla əlavə edildi'));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _isLoding = false;
      });
      showTopSnackBar(context, CustomSnackBar.error(message: 'Xəta baş verdi'));
    }
  }
}
