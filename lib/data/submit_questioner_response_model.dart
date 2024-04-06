class SubmitQuestionerResponse {
  final String status;
  final int score;
  final String advice;
  final int age;
  final String gender;
  final String maritalStatus;
  final String employmentStatus;
  const SubmitQuestionerResponse({
    required this.status,
    required this.score,
    required this.advice,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.employmentStatus,
  });

  factory SubmitQuestionerResponse.fromJson(Map<String, dynamic> json) {
    return SubmitQuestionerResponse(
      advice: json['advice'] ?? '',
      score: json['score'] ?? '',
      status: json['status'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      maritalStatus: json['maritalstatus'] ?? '',
      employmentStatus: json['employmentstatus'] ?? '',
    );
  }
}
