import 'package:admin/models/teacher_request_model.dart';
import 'package:admin/screens/auth/login_view.dart';
import 'package:admin/screens/student_page_view.dart';
import 'package:admin/screens/teacher_create_page_view.dart';
import 'package:admin/screens/password_change_page_view.dart';
import 'package:admin/screens/teacher_edit_page_view.dart';
import 'package:admin/utils/network_util/network.dart';
import 'package:admin/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Themes.primaryColor,
          centerTitle: true,
          title: Text(
            'Məllimlərin Siyahısı',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          actions: [
            PopupMenuButton(
              iconSize: 30,
              color: Colors.white,
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Şifrəni dəyiş",
                        style: TextStyle(color: Themes.primaryTextcolor)),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Çıxış",
                        style: TextStyle(color: Themes.primaryTextcolor)),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PasswordChange()));
                } else if (value == 1) {
                  removeAccessToken();
                }
              },
            ),
          ],
        ),
        body: FutureBuilder<List<TeacherModel>>(
          future: WebService.getTeacher(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<TeacherModel>? data = snapshot.data;
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.82,
                  child: getTeacher(data));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: SpinKitCircle(
              size: 100,
              itemBuilder: (context, index) {
                final colors = [
                  Themes.primaryColor,
                  Themes.primaryTextcolor,
                  Colors.blue,
                  Themes.primaryColor,
                ];
                final color = colors[index % colors.length];
                return DecoratedBox(
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle));
              },
            ));
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateTeacher()));
          },
          backgroundColor: Themes.primaryColor,
          label: Text(
            'Məllim Qeydiyyatı',
            style: TextStyle(fontSize: 14),
          ),
          icon: Icon(Icons.add),
          splashColor: Themes.primaryTextcolor,
        ),
      ),
    );
  }

  removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    // Remove data for the 'counter' key.
    await prefs.remove('Authorization');
    await prefs.remove('isRemember');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  ListView getTeacher(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentListPage(
                          teacherUserName: data[index].username,
                          teacherUserId: data[index].userId,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
            child: Card(
              elevation: 5,
              child: ListTile(
                title: Text(data[index].firstName + ' ' + data[index].lastName,
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: CircleAvatar(
                  backgroundColor: Themes.primaryColor,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: SizedBox(
                  width: 155,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 50,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => EditTeacherView(
                                        userName: data[index].username)));
                          },
                          icon: Icon(Icons.edit),
                          color: Themes.primaryTextcolor,
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: data[index].isActive
                            ? Center(
                                child: Text('Aktiv',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              )
                            : Text(
                                'Aktiv deyil',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
