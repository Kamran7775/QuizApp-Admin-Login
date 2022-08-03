class TeacherModel {
  String? userId;
  String? username;
  String? firstName;
  String? lastName;
  String? fatherName;
  String? phoneNumber;
  bool? isActive;
  List<Students>? students;
  int? maxAllowedStudents;
  String? membershipExpiredMessage;

  TeacherModel(
      {this.userId,
      this.username,
      this.firstName,
      this.lastName,
      this.fatherName,
      this.phoneNumber,
      this.isActive,
      this.students,
      this.maxAllowedStudents,
      this.membershipExpiredMessage});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    phoneNumber = json['phone_number'];
    isActive = json['is_active'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(new Students.fromJson(v));
      });
    }
    maxAllowedStudents = json['max_allowed_students'];
    membershipExpiredMessage = json['membership_expired_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['father_name'] = this.fatherName;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    if (this.students != null) {
      data['students'] = this.students!.map((v) => v.toJson()).toList();
    }
    data['max_allowed_students'] = this.maxAllowedStudents;
    data['membership_expired_message'] = this.membershipExpiredMessage;
    return data;
  }
}

class Students {
  String? userId;
  String? username;
  String? firstName;
  String? lastName;
  String? fatherName;
  String? phoneNumber;
  bool? isActive;
  int? allowedMobileCount;
  int? allowedPcCount;
  int? remainingDays;

  Students(
      {this.userId,
      this.username,
      this.firstName,
      this.lastName,
      this.fatherName,
      this.phoneNumber,
      this.isActive,
      this.allowedMobileCount,
      this.allowedPcCount,
      this.remainingDays});

  Students.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    phoneNumber = json['phone_number'];
    isActive = json['is_active'];
    allowedMobileCount = json['allowed_mobile_count'];
    allowedPcCount = json['allowed_pc_count'];
    remainingDays = json['remaining_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['father_name'] = this.fatherName;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    data['allowed_mobile_count'] = this.allowedMobileCount;
    data['allowed_pc_count'] = this.allowedPcCount;
    data['remaining_days'] = this.remainingDays;
    return data;
  }
}
