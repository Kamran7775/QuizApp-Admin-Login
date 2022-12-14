import 'package:admin/models/student_create_request_model.dart';
import 'package:admin/screens/student_page_view.dart';
import 'package:admin/utils/appsize/appsize.dart';
import 'package:admin/utils/network_util/network.dart';
import 'package:admin/utils/themes/theme.dart';
import 'package:admin/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({Key? key, required this.userId, required this.userName})
      : super(key: key);
  final String userId;
  final String userName;
  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController fatherNameEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController finCodeEditingController = TextEditingController();

  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateFatherName = false;
  bool _validatePhoneNumber = false;
  bool _validateFinCode = false;

  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    firstNameEditingController.dispose();
    lastNameEditingController.dispose();
    fatherNameEditingController.dispose();
    phoneNumberEditingController.dispose();
    finCodeEditingController.dispose();
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentListPage(
                          teacherUserName: widget.userName,
                          teacherUserId: widget.userId,
                        )));
          },
          icon: Icon(
            Icons.keyboard_backspace_outlined,
            size: 30,
            color: Themes.primaryTextcolor,
          ),
        ),
        title: Text(
          "T??l??b?? ??lav?? edin",
          style: TextStyle(color: Themes.primaryTextcolor, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                  width: (MediaQuery.of(context).size.width < 550)
                      ? AppSize.calculateWidth(context, 400)
                      : AppSize.calculateWidth(context, 200),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Themes.primaryColor.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 15),
                    child: Column(children: [
                      CustomTextFieldWidget(
                        labelText: "Ad??",
                        textEditingController: firstNameEditingController,
                        validate: _validateFirstName,
                        errorText: 'Bu xana bo?? qala bilm??z',
                      ),
                      SizedBox(height: 13),
                      CustomTextFieldWidget(
                        labelText: "Soyad??",
                        textEditingController: lastNameEditingController,
                        validate: _validateLastName,
                        errorText: 'Bu xana bo?? qala bilm??z',
                      ),
                      SizedBox(height: 13),
                      CustomTextFieldWidget(
                        labelText: "Ata ad??",
                        textEditingController: fatherNameEditingController,
                        validate: _validateFatherName,
                        errorText: 'Bu xana bo?? qala bilm??z',
                      ),
                      SizedBox(height: 10),
                      CustomTextFieldWidget(
                        labelText: "N??mr??si",
                        textEditingController: phoneNumberEditingController,
                        validate: _validatePhoneNumber,
                        errorText: 'Bu xana bo?? qala bilm??z',
                      ),
                      SizedBox(height: 13),
                      CustomTextFieldWidget(
                        labelText: "Fin kodu",
                        textEditingController: finCodeEditingController,
                        validate: _validateFinCode,
                        errorText:
                            (finCodeEditingController.text.isEmpty == true)
                                ? "Bu xana bo?? qala bilm??z"
                                : "Fin kod 7 simvol olmal??d??",
                        maxLength: 7,
                      ),
                      SizedBox(height: 20),
                      (_isLoading == false)
                          ? Container(
                              height: 50,
                              width: 150,
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
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

                                      (finCodeEditingController.text.isEmpty ||
                                              finCodeEditingController
                                                      .text.length !=
                                                  7)
                                          ? _validateFinCode = true
                                          : _validateFinCode = false;
                                      if (_validateFirstName == false &&
                                          _validateLastName == false &&
                                          _validateFatherName == false &&
                                          _validatePhoneNumber == false &&
                                          _validateFinCode == false) {
                                        createStudent();
                                      }
                                    });
                                  },
                                  child: Text(
                                    "??lav?? et",
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
                          : SpinKitFadingCircle(
                              color: Themes.primaryColor,
                            )
                    ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  createStudent() async {
    setState(() {
      _isLoading = true;
    });
    StudentCreateRequestModel studentCreateRequestModel =
        StudentCreateRequestModel(
            firstName: firstNameEditingController.text,
            lastName: lastNameEditingController.text,
            fatherName: fatherNameEditingController.text,
            phoneNumber: phoneNumberEditingController.text,
            finNumber: finCodeEditingController.text,
            teacherId: int.tryParse(widget.userId));
    var response = await WebService.studentCreate(studentCreateRequestModel);
    if (response == true) {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context,
          CustomSnackBar.success(message: 'T??l??b?? u??urla ??lav?? edildi'));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StudentListPage(
                    teacherUserName: widget.userName,
                    teacherUserId: widget.userId,
                  )));
    } else {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context, CustomSnackBar.error(message: 'X??ta ba?? verdi'));
    }
  }
}
