class StudentCreateRequestModel {
  String? finNumber;
  String? firstName;
  String? lastName;
  String? fatherName;
  String? phoneNumber;
  int? teacherId;

  StudentCreateRequestModel(
      {this.finNumber,
      this.firstName,
      this.lastName,
      this.fatherName,
      this.phoneNumber,
      this.teacherId});

  StudentCreateRequestModel.fromJson(Map<String, dynamic> json) {
    finNumber = json['fin_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    phoneNumber = json['phone_number'];
    teacherId = json['teacher_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fin_number'] = this.finNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['father_name'] = this.fatherName;
    data['phone_number'] = this.phoneNumber;
    data['teacher_id'] = this.teacherId;
    return data;
  }
}
