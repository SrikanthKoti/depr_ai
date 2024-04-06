import 'package:depr_ai/data/submit_questioner_response_model.dart';

class ChartData {
  ChartData({
    required this.x,
    required this.y,
    required this.size,
    required this.xValue,
    required this.content,
  });

  final String x;
  final double y;
  final double size;
  final double xValue;

  final SubmitQuestionerResponse content;
}
