class TeacherCreateRequestModel {
  String? finNumber;
  String? firstName;
  String? lastName;
  String? fatherName;
  String? phoneNumber;
  String? password;
  int? maxAllowedStudents;
  String? membershipExpiredMessage;

  TeacherCreateRequestModel(
      {this.finNumber,
      this.firstName,
      this.lastName,
      this.fatherName,
      this.phoneNumber,
      this.password,
      this.maxAllowedStudents,
      this.membershipExpiredMessage});

  TeacherCreateRequestModel.fromJson(Map<String, dynamic> json) {
    finNumber = json['fin_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    maxAllowedStudents = json['max_allowed_students'];
    membershipExpiredMessage = json['membership_expired_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fin_number'] = this.finNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['father_name'] = this.fatherName;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['max_allowed_students'] = this.maxAllowedStudents;
    data['membership_expired_message'] = this.membershipExpiredMessage;
    return data;
  }
}
