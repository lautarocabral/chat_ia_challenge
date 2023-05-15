import 'dart:convert';

import 'package:chat_ia_challenge/models/chat_gpt_request_model.dart';
import 'package:chat_ia_challenge/models/chat_gpt_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../enums/chat_gpt_status.dart';
import '../../models/chat_message_model.dart';
import '../../repositories/chat_gpt_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatGptRepository chatGptRepository;

  ChatCubit({required this.chatGptRepository}) : super(ChatState.initial());

  Future getChatGptAnswer({required String question}) async {
    setUserQuestion(question);

    ChatGptResponseModel chatGptResponseModel = ChatGptResponseModel();

    setChatGptStatus(ChatGptStatus.loading);

    ChatGptRequestModel chatGptRequestModel = ChatGptRequestModel();
    chatGptRequestModel.model = 'gpt-3.5-turbo';
    chatGptRequestModel.messages = [];
    chatGptRequestModel.messages!
        .add(Messages(role: 'user', content: question));

    Response response = await chatGptRepository.getAnswer(chatGptRequestModel);

    if (response.statusCode == 200) {
      setChatGptStatus(ChatGptStatus.complete);
      chatGptResponseModel =
          ChatGptResponseModel.fromJson(jsonDecode(response.body));
      setChatGptResponse(chatGptResponseModel);
    } else {
      setChatGptStatus(ChatGptStatus.incomplete);
    }

    return chatGptResponseModel;
  }

  void setChatGptResponse(ChatGptResponseModel newAnswer) {
    List<ChatGptResponseModel> newListAnswer = [];
    newListAnswer.addAll(state.chatGptResponseModelList);
    newListAnswer.add(newAnswer);
    emit(state.copyWith(chatGptResponseModelList: newListAnswer));
    setChatGptAnswers(newAnswer.choices!.first.message!.content!);
  }

  void setChatGptStatus(ChatGptStatus newStatus) {
    emit(state.copyWith(chatGptStatus: newStatus));
  }

  void setUserQuestion(String userQuestion) {
    List<ChatMessageModel>? emptyMessages = [];
    emptyMessages.addAll(state.messages);
    emptyMessages.add(
        ChatMessageModel(messageContent: userQuestion, messageType: 'sender'));
    emit(state.copyWith(messages: emptyMessages));
  }

  void add() {
    setChatGptStatus(ChatGptStatus.initial);
    List<ChatMessageModel>? emptyMessages = [];
    emptyMessages.add(
        ChatMessageModel(messageContent: 'Hello!!', messageType: 'receiver'));
    emit(state.copyWith(messages: emptyMessages));
  }

  void setChatGptAnswers(String chatGptAnswer) {
    setChatGptStatus(ChatGptStatus.initial);
    List<ChatMessageModel>? emptyMessages = [];
    emptyMessages.addAll(state.messages);
    emptyMessages.add(ChatMessageModel(
        messageContent: chatGptAnswer, messageType: 'receiver'));
    emit(state.copyWith(messages: emptyMessages));
  }
}
