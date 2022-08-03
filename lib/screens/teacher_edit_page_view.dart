import 'package:admin/models/Teacher_change_request_model.dart';
import 'package:admin/screens/home_page_view.dart';
import 'package:admin/utils/network_util/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:counter_button/counter_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../utils/appsize/appsize.dart';
import '../utils/themes/theme.dart';
import '../widgets/button.dart';

class EditTeacherView extends StatefulWidget {
  const EditTeacherView({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;

  @override
  State<EditTeacherView> createState() => _EditTeacherViewState();
}

class _EditTeacherViewState extends State<EditTeacherView> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController fatherNameEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();

  TextEditingController membershipExpiredMessageEditingController =
      TextEditingController();

  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateFatherName = false;
  bool _validatePhoneNumber = false;

  bool _validateMembershipExpiredMessage = false;
  bool _isActive = false;
  bool _isLoading = false;
  bool _deleteLoading = false;
  bool _mainLoading = false;
  int _studentNumber = 0;

  @override
  void initState() {
    getTeacherData(widget.userName);
    super.initState();
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
            "Məllim məlumatlarını yenilə",
            style: TextStyle(color: Themes.primaryTextcolor, fontSize: 24),
          ),
        ),
        body: (_mainLoading == true)
            ? SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 25),
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
                                textEditingController:
                                    membershipExpiredMessageEditingController,
                                validate: _validateMembershipExpiredMessage,
                                errorText: 'Bu xana boş qala bilməz',
                                labelText: 'Mesaj',
                              ),
                              SizedBox(height: 13),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Themes.primaryColor),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('Tələbə Sayı',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Themes.primaryTextcolor)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CounterButton(
                                        loading: false,
                                        onChange: (int val) {
                                          if (val < 0) {
                                            setState(() {
                                              _studentNumber = 0;
                                            });
                                          } else {
                                            setState(() {
                                              _studentNumber = val;
                                            });
                                          }
                                        },
                                        count: _studentNumber,
                                        countColor: Themes.primaryTextcolor,
                                        buttonColor: Themes.primaryTextcolor,
                                        progressColor: Themes.primaryTextcolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 13),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Themes.primaryColor),
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
                                                      ? _validateLastName = true
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

                                                  membershipExpiredMessageEditingController
                                                          .text.isEmpty
                                                      ? _validateMembershipExpiredMessage =
                                                          true
                                                      : _validateMembershipExpiredMessage =
                                                          false;

                                                  if (_validateFirstName ==
                                                          false &&
                                                      _validateLastName ==
                                                          false &&
                                                      _validateFatherName ==
                                                          false &&
                                                      _validatePhoneNumber ==
                                                          false &&
                                                      _validateMembershipExpiredMessage ==
                                                          false) {
                                                    chanceTeacherEdit();
                                                  }
                                                });
                                              },
                                              child: Text(
                                                "Yenilə",
                                                style: TextStyle(
                                                    color: Themes.primaryColor,
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
                                                          deleteTeacher();
                                                        },
                                                        child: Text(
                                                          "Beli",
                                                          style: TextStyle(
                                                              color: Colors.red,
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
                                                  color: Colors.red, width: 1)),
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
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle));
                },
              )));
  }

  getTeacherData(userName) async {
    var response = await WebService.getTeacherWithUserName(userName);
    if (response != false) {
      setState(() {
        _mainLoading = true;
        firstNameEditingController.text = response['first_name'];
        lastNameEditingController.text = response['last_name'];
        fatherNameEditingController.text = response['father_name'];
        phoneNumberEditingController.text = response['phone_number'];

        _studentNumber = response['max_allowed_students'];
        membershipExpiredMessageEditingController.text =
            response['membership_expired_message'];
        _isActive = response['is_active'];
      });
    } else {}
  }

  chanceTeacherEdit() async {
    setState(() {
      _isLoading = true;
    });
    TeacherChangeRequestModel teacherChangeRequestModel =
        TeacherChangeRequestModel(
            firstName: firstNameEditingController.text,
            lastName: lastNameEditingController.text,
            fatherName: fatherNameEditingController.text,
            phoneNumber: phoneNumberEditingController.text,
            maxAllowedStudents: _studentNumber,
            membershipExpiredMessage:
                membershipExpiredMessageEditingController.text,
            isActive: _isActive);
    var response = await WebService.chanceTeacher(
        teacherChangeRequestModel, widget.userName);
    if (response == true) {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context,
          CustomSnackBar.success(message: 'Məllim uğurla dəyişdirildi'));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      showTopSnackBar(context, CustomSnackBar.error(message: 'Xəta baş verdi'));
    }
  }

  deleteTeacher() async {
    setState(() {
      _deleteLoading = true;
    });
    var response = await WebService.deleteTeacher(widget.userName);
    if (response == true) {
      setState(() {
        _deleteLoading = false;
      });
      showTopSnackBar(
          context, CustomSnackBar.success(message: 'Məllim uğurla silindi'));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _deleteLoading = false;
      });
      showTopSnackBar(context, CustomSnackBar.error(message: 'Xəta baş verdi'));
    }
  }
}
