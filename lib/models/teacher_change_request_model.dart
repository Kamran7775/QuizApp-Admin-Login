class TeacherChangeRequestModel {
  String? firstName;
  String? lastName;
  String? fatherName;
  String? phoneNumber;
  bool? isActive;
  int? maxAllowedStudents;
  String? membershipExpiredMessage;

  TeacherChangeRequestModel(
      {this.firstName,
      this.lastName,
      this.fatherName,
      this.phoneNumber,
      this.isActive,
      this.maxAllowedStudents,
      this.membershipExpiredMessage});

  TeacherChangeRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    phoneNumber = json['phone_number'];
    isActive = json['is_active'];
    maxAllowedStudents = json['max_allowed_students'];
    membershipExpiredMessage = json['membership_expired_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['father_name'] = this.fatherName;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    data['max_allowed_students'] = this.maxAllowedStudents;
    data['membership_expired_message'] = this.membershipExpiredMessage;
    return data;
  }
}
