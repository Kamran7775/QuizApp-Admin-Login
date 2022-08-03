import 'package:admin/models/student_change_request_model.dart';

import 'package:admin/screens/student_page_view.dart';
import 'package:admin/utils/network_util/network.dart';
import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../utils/appsize/appsize.dart';
import '../utils/themes/theme.dart';
import '../widgets/button.dart';

class EditStudentView extends StatefulWidget {
  const EditStudentView(
      {Key? key,
      required this.stundetUserName,
      required this.teacherID,
      required this.teacherUsername})
      : super(key: key);

  final String stundetUserName;
  final String teacherID;
  final String
      teacherUsername; //Yenile ve delete buttonlarinda kecidleri duzeltin
  @override
  State<EditStudentView> createState() => _EditStudentViewState();
}

class _EditStudentViewState extends State<EditStudentView> {
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
  bool _deleteLoading = false;
  bool _mainLoading = false;
  bool _isActive = false;
  int _pcCount = 0;
  int _mobileCount = 0;
  int _daysCount = 0;

  @override
  void initState() {
    getStudentData(widget.stundetUserName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                              teacherUserId: widget.teacherID,
                              teacherUserName: widget.teacherUsername,
                            )));
              },
              icon: Icon(
                Icons.keyboard_backspace_outlined,
                size: 30,
                color: Themes.primaryTextcolor,
              ),
            ),
            title: Text(
              "Tələbə məlumatları yenilə",
              style: TextStyle(color: Themes.primaryTextcolor, fontSize: 24),
            ),
          ),
          body: (_mainLoading == true)
              ? SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CustomTextFieldWidget(
                                  labelText: "Adı",
                                  textEditingController:
                                      firstNameEditingController,
                                  validate: _validateFirstName,
                                  errorText: 'Bu xana boş qala bilməz',
                                ),
                                SizedBox(height: 13),
                                CustomTextFieldWidget(
                                  labelText: "Soyadı",
                                  textEditingController:
                                      lastNameEditingController,
                                  validate: _validateLastName,
                                  errorText: 'Bu xana boş qala bilməz',
                                ),
                                SizedBox(height: 13),
                                CustomTextFieldWidget(
                                  labelText: "Ata adı",
                                  textEditingController:
                                      fatherNameEditingController,
                                  validate: _validateFatherName,
                                  errorText: 'Bu xana boş qala bilməz',
                                ),
                                SizedBox(height: 13),
                                CustomTextFieldWidget(
                                  labelText: "Nömrəsi",
                                  textEditingController:
                                      phoneNumberEditingController,
                                  validate: _validatePhoneNumber,
                                  errorText: 'Bu xana boş qala bilməz',
                                ),
                                SizedBox(height: 13),
                                CustomTextFieldWidget(
                                  labelText: "Fin kodu",
                                  textEditingController:
                                      finCodeEditingController,
                                  validate: _validateFinCode,
                                  errorText:
                                      (finCodeEditingController.text.isEmpty ==
                                              true)
                                          ? "Bu xana boş qala bilməz"
                                          : "Fin kod 7 simvol olmalıdı",
                                  maxLength: 7,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Themes.primaryColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            'Aktivlik Statusu',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Themes.primaryTextcolor),
                                          ),
                                        ),
                                        Switch(
                                            activeColor: Themes.primaryColor,
                                            value: _isActive,
                                            onChanged: (value) {
                                              setState(() {
                                                _isActive = value;
                                              });
                                            })
                                      ]),
                                ),
                                SizedBox(height: 13),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Themes.primaryColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text('Kompüter Sayı',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Themes.primaryTextcolor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CounterButton(
                                          loading: false,
                                          onChange: (int val) {
                                            if (val < 0) {
                                              setState(() {
                                                _pcCount = 0;
                                              });
                                            } else {
                                              setState(() {
                                                _pcCount = val;
                                              });
                                            }
                                          },
                                          count: _pcCount,
                                          countColor: Themes.primaryTextcolor,
                                          buttonColor: Themes.primaryTextcolor,
                                          progressColor:
                                              Themes.primaryTextcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 13),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Themes.primaryColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text('Telefon Sayı',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Themes.primaryTextcolor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CounterButton(
                                          loading: false,
                                          onChange: (int val) {
                                            if (val < 0) {
                                              setState(() {
                                                _mobileCount = 0;
                                              });
                                            } else {
                                              setState(() {
                                                _mobileCount = val;
                                              });
                                            }
                                          },
                                          count: _mobileCount,
                                          countColor: Themes.primaryTextcolor,
                                          buttonColor: Themes.primaryTextcolor,
                                          progressColor:
                                              Themes.primaryTextcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 13),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Themes.primaryColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text('Gün Sayı',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Themes.primaryTextcolor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CounterButton(
                                          loading: false,
                                          onChange: (int val) {
                                            if (val < 0) {
                                              setState(() {
                                                _daysCount = 0;
                                              });
                                            } else {
                                              setState(() {
                                                _daysCount = val;
                                              });
                                            }
                                          },
                                          count: _daysCount,
                                          countColor: Themes.primaryTextcolor,
                                          buttonColor: Themes.primaryTextcolor,
                                          progressColor:
                                              Themes.primaryTextcolor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    (_isLoading == false)
                                        ? Container(
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    firstNameEditingController
                                                            .text.isEmpty
                                                        ? _validateFirstName =
                                                            true
                                                        : _validateFirstName =
                                                            false;
                                                    lastNameEditingController
                                                            .text.isEmpty
                                                        ? _validateLastName =
                                                            true
                                                        : _validateLastName =
                                                            false;
                                                    fatherNameEditingController
                                                            .text.isEmpty
                                                        ? _validateFatherName =
                                                            true
                                                        : _validateFatherName =
                                                            false;
                                                    phoneNumberEditingController
                                                            .text.isEmpty
                                                        ? _validatePhoneNumber =
                                                            true
                                                        : _validatePhoneNumber =
                                                            false;
                                                    (finCodeEditingController
                                                                .text.isEmpty ||
                                                            finCodeEditingController
                                                                    .text
                                                                    .length !=
                                                                7)
                                                        ? _validateFinCode =
                                                            true
                                                        : _validateFinCode =
                                                            false;

                                                    if (_validateFirstName ==
                                                            false &&
                                                        _validateLastName ==
                                                            false &&
                                                        _validateFatherName ==
                                                            false &&
                                                        _validatePhoneNumber ==
                                                            false &&
                                                        _validateFinCode ==
                                                            false) {
                                                      studentEdit();
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  "Yenilə",
                                                  style: TextStyle(
                                                      color:
                                                          Themes.primaryColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Themes.primaryColor
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Themes.primaryColor,
                                                    width: 1)),
                                          )
                                        : SpinKitFadingCircle(
                                            color: Themes.primaryColor),
                                    (_deleteLoading == false)
                                        ? Container(
                                            child: TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (covariant) =>
                                                        AlertDialog(
                                                      content: Text(
                                                        "Silmək istədiyinizə əminsizmi ?",
                                                        style: TextStyle(
                                                            color: Themes
                                                                .primaryTextcolor,
                                                            fontSize: 18),
                                                      ),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            deleteStudent();
                                                          },
                                                          child: Text(
                                                            "Beli",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "Ləğv et",
                                                            style: TextStyle(
                                                                color: Themes
                                                                    .primaryTextcolor,
                                                                fontSize: 18),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Silmək",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.red
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 1)),
                                          )
                                        : Center(
                                            child: SpinKitFadingCircle(
                                                color: Colors.red))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: SpinKitCircle(
                  size: 100,
                  itemBuilder: (context, index) {
                    final colors = [
                      Themes.primaryColor,
                      Themes.primaryTextcolor,
                      Colors.blue,
                      Themes.primaryColor
                    ];
                    final color = colors[index % colors.length];
                    return DecoratedBox(
                        decoration: BoxDecoration(
                            color: color, shape: BoxShape.circle));
                  },
                ))),
    );
  }

  getStudentData(userName) async {
    var response = await WebService.getStudentWithUsername(userName);
    if (response != false) {
      setState(() {
        _mainLoading = true;
        firstNameEditingController.text = response['first_name'];
        lastNameEditingController.text = response['last_name'];
        fatherNameEditingController.text = response['father_name'];
        phoneNumberEditingController.text = response['phone_number'];
        finCodeEditingController.text = response['username'];
        _isActive = response['is_active'];
        _pcCount = response['allowed_pc_count'];
        _mobileCount = response['allowed_mobile_count'];
        _daysCount = response['remaining_days'];
      });
    } else {}
  }

  studentEdit() async {
    setState(() {
      _isLoading = true;
    });
    StudentChangeRequestModel studentChangeRequestModel =
        StudentChangeRequestModel(
            username: finCodeEditingController.text,
            firstName: firstNameEditingController.text,
            fatherName: fatherNameEditingController.text,
            lastName: lastNameEditingController.text,
            phoneNumber: phoneNumberEditingController.text,
            isActive: _isActive,
            allowedMobileCount: _mobileCount,
            allowedPcCount: _pcCount,
            remainingDays: _daysCount);
    var response = await WebService.chanceStudent(
        studentChangeRequestModel, widget.stundetUserName);
    if (response == true) {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context,
          CustomSnackBar.success(message: 'Tələbə uğurla dəyişdirildi'));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StudentListPage(
                    teacherUserId: widget.teacherID,
                    teacherUserName: widget.teacherUsername,
                  )));
    } else {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context, CustomSnackBar.error(message: 'Xəta baş verdi'));
    }
  }

  deleteStudent() async {
    setState(() {
      _deleteLoading = true;
    });
    var response = await WebService.deleteStudent(widget.stundetUserName);
    if (response == true) {
      setState(() {
        _deleteLoading = false;
      });
      showTopSnackBar(
          context, CustomSnackBar.success(message: 'Tələbə uğurla silindi'));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StudentListPage(
                    teacherUserId: widget.teacherID,
                    teacherUserName: widget.teacherUsername,
                  )));
    } else {
      setState(() {
        _deleteLoading = false;
      });
      showTopSnackBar(context, CustomSnackBar.error(message: 'Xəta baş verdi'));
    }
  }
}
