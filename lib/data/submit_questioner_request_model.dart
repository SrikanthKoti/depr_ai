class SubmitQuestionerRequestModel {
  int age;
  String gender;
  String maritalStatus;
  String employmentStatus;
  List<int> options;

  SubmitQuestionerRequestModel({
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.employmentStatus,
    required this.options,
  });
  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'employmentStatus': employmentStatus,
      'options': options,
    };
  }
}
