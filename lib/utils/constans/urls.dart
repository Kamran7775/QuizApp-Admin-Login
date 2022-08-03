class Urls {
  //http://161.97.136.74/api/v1/auth/token/

  static String BASE_URL = 'http://161.97.136.74/';

  //auth
  static String LOGIN_URL = 'api/v1/auth/token/';
  static String CHANGE_PASSWORD_URL = 'api/v1/auth/password/change/';

  //teacher
  static String TEACHER_CREATE_URL = 'api/v1/users/teachers/';
  static String TEACHER_GET_URL = 'api/v1/users/teachers/';
  static String TEACHER_DELETE_URL = 'api/v1/users/teachers/';

  //student
  static String STUDENT_CREATE_URL = 'api/v1/users/students/';
  static String STUDENT_GET_URL = 'api/v1/users/students/';
  static String STUDENT_DELETE_URL = 'api/v1/users/students/';
  static String STUDENT_PUT_URL = 'api/v1/users/students/';
}
