class Question {
  final String question;
  final List<String> answers;
  int? selectedIndex;
  Question({required this.question, required this.answers, required this.selectedIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    final List<String>? answersList = json['answer'] != null
        ? List<String>.from(json['answer'].map((ans) => ans.toString()))
        : null;
    return Question(
      question: json['question'] ?? '',
      answers: answersList ?? [],
      selectedIndex: json['selectedIndex'],
    );
  }
}
