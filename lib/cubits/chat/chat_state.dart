part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatGptResponseModel> chatGptResponseModelList;
  final ChatGptStatus chatGptStatus;
  final List<ChatMessageModel> messages;

  const ChatState({
    required this.chatGptResponseModelList,
    required this.chatGptStatus,
    required this.messages,
  });

  factory ChatState.initial() {
    return const ChatState(
      chatGptResponseModelList: [],
      chatGptStatus: ChatGptStatus.initial,
      messages: [],
    );
  }

  ChatState copyWith(
      {List<ChatGptResponseModel>? chatGptResponseModelList,
      ChatGptStatus? chatGptStatus,
      List<ChatMessageModel>? messages}) {
    return ChatState(
      chatGptResponseModelList:
          chatGptResponseModelList ?? this.chatGptResponseModelList,
      chatGptStatus: chatGptStatus ?? this.chatGptStatus,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object> get props => [chatGptResponseModelList, chatGptStatus, messages];
}
