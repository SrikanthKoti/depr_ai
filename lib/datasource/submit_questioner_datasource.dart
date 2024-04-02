import 'dart:convert';
import 'package:depr_ai/data/submit_questioner_request_model.dart';
import 'package:depr_ai/data/submit_questioner_response_model.dart';
import 'package:http/http.dart' as http;

import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/datasource/response.dart';

class SubmitQuestionerDataSource {
  final CustomHttpClient client;
  SubmitQuestionerDataSource({required this.client});

  Future<Response> dataSourceMethod(SubmitQuestionerRequestModel requestModel) async {
    final http.Response response = await client.post(
      Uri.parse("https://depression-api.vercel.app/api/depression"),
      jsonEncode(requestModel.toJson()),
    );
    int nResponseCode = response.statusCode;
    if (nResponseCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData != null) {
        final responseModel = SubmitQuestionerResponse.fromJson(json.decode(response.body));

        return Response(data: responseModel);
      }
    }

    return const Response(isSuccess: false, errorMsg: "Something went wrong");
  }
}
