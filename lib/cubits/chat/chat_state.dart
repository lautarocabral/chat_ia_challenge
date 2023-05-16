part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatGptResponseModel> chatGptResponseModelList;
  final ChatGptStatus chatGptStatus;
  final List<ChatMessageModel> messages;
  final String errorMessage;

  const ChatState({
    required this.chatGptResponseModelList,
    required this.chatGptStatus,
    required this.messages,
    required this.errorMessage,
  });

  factory ChatState.initial() {
    return const ChatState(
      chatGptResponseModelList: [],
      chatGptStatus: ChatGptStatus.initial,
      messages: [],
      errorMessage: '',
    );
  }

  ChatState copyWith({
    List<ChatGptResponseModel>? chatGptResponseModelList,
    ChatGptStatus? chatGptStatus,
    List<ChatMessageModel>? messages,
    String? errorMessage,
  }) {
    return ChatState(
      chatGptResponseModelList:
          chatGptResponseModelList ?? this.chatGptResponseModelList,
      chatGptStatus: chatGptStatus ?? this.chatGptStatus,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [chatGptResponseModelList, chatGptStatus, messages, errorMessage];
}
