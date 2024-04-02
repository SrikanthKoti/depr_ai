import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:depr_ai/app/custom_http_client.dart';
import 'package:depr_ai/datasource/response.dart';

class FlagQuestionerDataSource {
  final CustomHttpClient client;
  FlagQuestionerDataSource({required this.client});

  Future<Response> dataSourceMethod() async {
    final http.Response response =
        await client.get(Uri.parse("https://depression-api.vercel.app/api/flag"));
    int nResponseCode = response.statusCode;
    if (nResponseCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData != null) {
        final bool flag = json.decode(response.body)['flag'] == "true";
        return Response(data: flag);
      }
    }

    return const Response(isSuccess: false, data: true, errorMsg: "Something went wrong");
  }
}
