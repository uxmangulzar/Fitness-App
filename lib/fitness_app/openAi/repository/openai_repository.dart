import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:fitness_app/fitness_app/openAi/api_constants.dart';

/// OpenAPI Repository
class OpenAiRepository {
  /// HTTP Client
  static http.Client client = http.Client();

  /// Sends OpenAPI request.
  static Future<Map<String, dynamic>> sendMessage(
      {required String prompt}) async {
    try {
      final headers = {
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json'
      };
      final request = http.Request('POST', Uri.parse('${endpoint}completions'))
        ..body = json.encode({
          'model': 'davinci-002',
          'prompt': prompt,
          'temperature': 0,
          'max_tokens': 2000
        });
      log("==================================");
      request.headers.addAll(headers);

      final response = await request.send();
      log("============response ${response.statusCode}\n${await response.stream.bytesToString()}");
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        log("==== data $data");
        return json.decode(data) as Map<String, dynamic>;
      } else {
        log('Error in sendMessage api call eelse block:');
        return {
          'status': false,
          'message': 'Oops, there was an error',
        };
      }
    } catch (e) {
      log('Error in sendMessage api call: $e');
      return {
        'status': false,
        'message': 'Oops, there was an error',
      };
    }
  }
}
