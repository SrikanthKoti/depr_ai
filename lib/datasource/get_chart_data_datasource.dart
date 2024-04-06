import 'dart:convert';
import 'package:depr_ai/data/submit_questioner_request_model.dart';
import 'package:depr_ai/data/submit_questioner_response_model.dart';
import 'package:http/http.dart' as http;

import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/datasource/response.dart';

class GetChartDataDataSource {
  final CustomHttpClient client;
  GetChartDataDataSource({required this.client});

  Future<Response> dataSourceMethod() async {
    final http.Response response = await client.get(
      Uri.parse("https://depression-api.vercel.app/api/depression"),
    );
    int nResponseCode = response.statusCode;
    if (nResponseCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData != null) {
        List<SubmitQuestionerResponse> data =
            (jsonData as List).map((e) => SubmitQuestionerResponse.fromJson(e)).toList();
        final responseModel = data;

        return Response(data: responseModel);
      }
    }

    return const Response(isSuccess: false, errorMsg: "Something went wrong");
  }
}
