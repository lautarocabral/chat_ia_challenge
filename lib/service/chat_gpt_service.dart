import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../models/chat_gpt_request_model.dart';

class ChatGptService {
  ChatGptService({
    http.Client? httpClient,
    this.baseUrl = 'https://api.rawg.io/api',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient;

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    final queryParameters = <String, String>{
      'key': dotenv.get('CHATGPT_API_KEY')
    };
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: queryParameters,
    );
  }

  Future getChatGptResponse(ChatGptRequestModel chatGptRequestModel) async {
    try {
      final authorization = <String, String>{
        'Authorization':
            'Bearer ${dotenv.get('CHATGPT_API_KEY', fallback: 'API_URL not found')}',
        'Content-Type': 'application/json'
      };

      final Uri uri = Uri(
        scheme: 'https',
        host: "api.openai.com",
        path: '/v1/chat/completions',
      );

      String body = json.encode(chatGptRequestModel);

      final response = await _httpClient.post(
        uri,
        headers: authorization,
        body: body,
      );
      return response;
    } catch (e) {
      return Response(e.toString(), 001);
    }
  }
}
