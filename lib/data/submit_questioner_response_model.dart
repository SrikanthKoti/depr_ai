class SubmitQuestionerResponse {
  final String status;
  final int score;
  final String advice;

  const SubmitQuestionerResponse({
    required this.status,
    required this.score,
    required this.advice,
  });

  factory SubmitQuestionerResponse.fromJson(Map<String, dynamic> json) {
    return SubmitQuestionerResponse(
      advice: json['advice'] ?? '',
      score: json['score'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
