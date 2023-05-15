import 'package:chat_ia_challenge/models/chat_gpt_request_model.dart';
import 'package:http/http.dart';

import '../service/chat_gpt_service.dart';

class ChatGptRepository {
  final ChatGptService _chatGptService = ChatGptService();

  Future<Response> getAnswer(ChatGptRequestModel chatGptRequestModel) async {
    return await _chatGptService.getChatGptResponse(chatGptRequestModel);
  }
}
