import 'dart:ui';

import 'package:depr_ai/data/question_model.dart';

class Helper {
  static List<Map<String, dynamic>> dummyQueData = [];
  static List<Map<String, dynamic>> data = [
    {
      "question": "What is your age in years?",
      "type": "age",
    },
    {
      "question": "What is your gender?",
      "answer": ['Female', 'Male', 'Others'],
      "type": "gender",
    },
    {
      "question": "What is your Marital status?",
      "answer": ['Married', 'Unmarried', 'Divorced', 'Widowed'],
      "type": "maritalStatus",
    },
    {
      "question": "What is your employment status?",
      "answer": ['Employed', 'Unemployed'],
      "type": "employmentStatus",
    },
    {
      "question": "Little interest or pleasure in doing things",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question": "Feeling down, depressed, or hopeless",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question": "Trouble falling or staying asleep, or sleeping too much",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question": "Feeling tired or having little energy",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question": "Poor appetite or overeating",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question":
          "Feeling bad about yourself - or that you are a failure or have let yourself or your family down",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question":
          "Trouble concentrating on things, such as reading the newspaper or watching television",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question": "Moving or speaking so slowly that other people could have noticed",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question": "Thoughts that you would be better off dead, or of hurting yourself",
      "answer": [
        "Not at all",
        "Several days",
        "More than half the days",
        "Nearly every day",
      ],
    },
    {
      "question":
          "If you've had any days with issues above, how difficult have these problems made it for you at work, home, school, or with other people?",
      "answer": [
        "Not difficult at all",
        "Somewhat difficult",
        "Very difficult",
        "Extremely difficult",
      ],
    },
  ];

  static ColorFilter getSVGCOlor(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }

  static List<Question> getQuestions() {
    List<Question> queList = [];
    for (var json in data) {
      Question question = Question.fromJson(json);
      if (question.question.isNotEmpty) {
        queList.add(question);
      }
    }
    return queList;
  }
}
