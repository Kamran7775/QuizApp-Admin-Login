import 'package:admin/models/teacher_request_model.dart';
import 'package:admin/screens/home_page_view.dart';
import 'package:admin/screens/student_create_page_view.dart';
import 'package:admin/screens/student_edit_page_view.dart';
import 'package:admin/utils/network_util/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../utils/themes/theme.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage(
      {Key? key, required this.teacherUserName, required this.teacherUserId})
      : super(key: key);
  final String teacherUserName;
  final String teacherUserId;

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Themes.primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.keyboard_backspace_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Tələbələrin Siyahısı",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: FutureBuilder<List<Students>>(
        future: WebService.getTeacherHisStudent(widget.teacherUserName),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            List<Students>? data = snapshot.data;
            return Container(
                height: MediaQuery.of(context).size.height * 0.82,
                child: getStudent(data));
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateStudent(
                        userId: widget.teacherUserId,
                        userName: widget.teacherUserName,
                      )));
        },
        backgroundColor: Themes.primaryColor,
        label: Text(
          'Tələbə Qeydiyyatı',
          style: TextStyle(fontSize: 14),
        ),
        icon: Icon(Icons.add),
        splashColor: Themes.primaryTextcolor,
      ),
    );
  }

  ListView getStudent(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Text(
                      data[index].firstName + ' ' + data[index].lastName,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(data[index].username,
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  leading: CircleAvatar(
                    backgroundColor: Themes.primaryColor,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: Container(
                    width: 155,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditStudentView(
                                            stundetUserName:
                                                data[index].username,
                                            teacherUsername:
                                                widget.teacherUserName,
                                            teacherID: widget.teacherUserId,
                                          )));
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
        });
  }
}
