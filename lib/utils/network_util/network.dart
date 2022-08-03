import 'dart:convert';
import 'dart:io';
import 'package:admin/models/Teacher_change_request_model.dart';
import 'package:admin/models/login_request_model.dart';
import 'package:admin/models/student_change_request_model.dart';
import 'package:admin/models/student_create_request_model.dart';
import 'package:admin/models/teacher_create_request_model.dart';
import 'package:admin/models/teacher_request_model.dart';
import 'package:admin/utils/constans/urls.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/password_change_request_model.dart';

class WebService {
  static signIn(LoginRequestModel loginRequestModel, bool isRemember) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    try {
      final response =
          await dio.post(Urls.LOGIN_URL, data: loginRequestModel); //postUri
      if (response.statusCode == HttpStatus.ok) {
        await prefs.setString('Authorization', '${response.data['access']}');
        await prefs.setBool('isRemember', isRemember);

        return true;
      }
    } catch (e) {
      return e;
    }
    // final response = await http.post(Uri.http(Urls.BASE_URL, Urls.LOGIN_URL),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: json.encode(loginRequestModel));
    // if (response.statusCode == 200) {
    //   await prefs.setString('Authorization',
    //       '${json.decode(response.body.toString())['access']}');
    //   await prefs.setBool('isRemember', isRemember);

    //   return true;
    // } else {
    //   return json.decode(response.body.toString())['detail'];
    // }
  }

  static studentCreate(
      StudentCreateRequestModel studentCreateRequestModel) async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.post(Urls.STUDENT_CREATE_URL,
          data: studentCreateRequestModel);
      if (response.statusCode == HttpStatus.created) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static teacherCreate(
      TeacherCreateRequestModel teacherCreateRequestModel) async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.post(Urls.TEACHER_CREATE_URL,
          data: teacherCreateRequestModel);
      if (response.statusCode == HttpStatus.created) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static passwordChange(
      PasswordChangeRequestModel passwordChangeRequestModel) async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.put(Urls.CHANGE_PASSWORD_URL,
          data: passwordChangeRequestModel);
      if (response.statusCode == HttpStatus.ok) {
        await prefs.remove('Authorization');
        await prefs.remove('isRemember');
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<List<TeacherModel>> getTeacher() async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(Urls.TEACHER_GET_URL);
      if (response.statusCode == HttpStatus.ok) {
        List jsonResponse = response.data;
        return jsonResponse
            .map((teacher) => TeacherModel.fromJson(teacher))
            .toList();
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  static getTeacherWithUserName(username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(
        Urls.TEACHER_GET_URL + username,
      );
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return e;
    }
  }

  static chanceTeacher(
      TeacherChangeRequestModel teacherChangeRequestModel, username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.put(Urls.TEACHER_GET_URL + username + '/',
          data: teacherChangeRequestModel);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<List<Students>> getTeacherHisStudent(username) async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(Urls.TEACHER_GET_URL + username);
      if (response.statusCode == HttpStatus.ok) {
        List jsonResponse = response.data['students'];
        return jsonResponse
            .map((students) => Students.fromJson(students))
            .toList();
      }
    } catch (e) {
      throw Exception('Error');
    }
    throw Exception('Error');
  }

  static getStudentWithUsername(username) async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.get(Urls.STUDENT_GET_URL + username + '/');
      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }
    } catch (e) {
      return e;
    }
  }

  static deleteStudent(username) async {
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response =
          await dio.delete(Urls.STUDENT_DELETE_URL + username + '/');
      if (response.statusCode == HttpStatus.noContent) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static deleteTeacher(username) async {
    final prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.delete(
        Urls.TEACHER_GET_URL + username + '/',
      );
      if (response.statusCode == HttpStatus.noContent) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }

  static chanceStudent(
      StudentChangeRequestModel studentChangeRequestModel, username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dio = Dio(BaseOptions(baseUrl: Urls.BASE_URL));
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] =
        'Bearer ${prefs.getString('Authorization')}';
    try {
      final response = await dio.put(Urls.STUDENT_CREATE_URL + username + '/',
          data: studentChangeRequestModel);
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (e) {
      return e;
    }
  }
}
