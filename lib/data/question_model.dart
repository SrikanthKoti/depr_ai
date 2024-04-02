enum QuestionType { age, gender, maritalStatus, employmentStatus, modelQuestion }

class Question {
  final String question;
  final List<String> answers;
  final QuestionType type;
  int? selectedIndex;
  Question(
      {required this.question,
      required this.answers,
      required this.selectedIndex,
      required this.type});

  factory Question.fromJson(Map<String, dynamic> json) {
    final List<String>? answersList = json['answer'] != null
        ? List<String>.from(json['answer'].map((ans) => ans.toString()))
        : null;
    QuestionType getType() {
      switch (json['type']) {
        case 'age':
          return QuestionType.age;
        case 'gender':
          return QuestionType.gender;
        case 'maritalStatus':
          return QuestionType.maritalStatus;
        case 'employmentStatus':
          return QuestionType.employmentStatus;
        default:
          return QuestionType.modelQuestion;
      }
    }

    return Question(
      question: json['question'] ?? '',
      answers: answersList ?? [],
      selectedIndex: json['selectedIndex'],
      type: getType(),
    );
  }
}
