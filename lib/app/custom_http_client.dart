// ignore_for_file: constant_identifier_names

import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class CustomHttpClient {
  //ignore:prefer_typing_uninitialized_variables
  var client;
  static const String STRING_CONTENT_TYPE = "Content-Type";
  static const String STRING_APPLICATION_JSON = "application/json";

  initialise() {
    client = http.Client();
  }

  static Map<String, int> customStatusCode = {"internet_failure": 600};

  Future<http.Response> get(Uri url, {bool showLogs = true}) async {
    var response = await client.get(url, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
    });
    if (showLogs) {
      log("\nGET API Call => $url \nStatus Code => ${response.statusCode} \nAPI Response => ${response.body} ");
    }

    return response;
  }

  Future<http.Response> post(Uri url, var bodyData, {bool showLogs = true}) async {
    var response = await client.post(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
    });
    if (showLogs) {
      log("\nPOST API Call => $url \nStatus Code => ${response.statusCode} \nRequest Body => $bodyData \nAPI Response => ${response.body}");
    }

    return response;
  }

  Future<http.Response> patch(Uri url, var bodyData, {bool showLogs = true}) async {
    var response = await client.patch(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
    });
    if (showLogs) {
      log("\nPatch API Call => $url \nStatus Code => ${response.statusCode} \nRequest Body => $bodyData \nAPI Response => ${response.body}");
    }

    return response;
  }

  Future<http.Response> delete(Uri url, var bodyData, {bool showLogs = true}) async {
    var response = await client.delete(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
    });
    if (showLogs) {
      log("\nDelete API Call => $url \nStatus Code => ${response.statusCode} \nRequest Body => $bodyData \nAPI Response => ${response.body}");
    }

    return response;
  }

  Future<http.Response> put(Uri url, var bodyData, {bool showLogs = true}) async {
    var response = await client.put(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
    });
    if (showLogs) {
      log("\nUpdate API Call => $url \nStatus Code => ${response.statusCode} \nRequest Body => $bodyData \nAPI Response => ${response.body}");
    }

    return response;
  }
}
