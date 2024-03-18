class Question {
  final String question;
  final List<String> answers;
  const Question({required this.question, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    final List<String>? answersList = json['answers'] != null
        ? List<String>.from(json['answers'].map((ans) => ans.toString()))
        : null;
    return Question(
      question: json['question'] ?? '',
      answers: answersList ?? [],
    );
  }
}
