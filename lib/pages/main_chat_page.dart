import 'package:chat_ia_challenge/enums/chat_gpt_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat/chat_cubit.dart';
import '../models/chat_message_model.dart';

class MainChatPage extends StatefulWidget {
  const MainChatPage({super.key});

  @override
  State<MainChatPage> createState() => _MainChatPageState();
}

List<ChatMessageModel>? messages;

class _MainChatPageState extends State<MainChatPage> {
  final TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          context.read<ChatCubit>().add();
          return true;
        },
        child: SafeArea(
            child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (context.read<ChatCubit>().state.chatGptStatus ==
                ChatGptStatus.incomplete) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'An error ocurred',
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.normal),
                  ),
                  duration: const Duration(seconds: 5),
                  backgroundColor: Colors.red,
                  width: 340.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: context.read<ChatCubit>().state.messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 70),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (context
                                    .read<ChatCubit>()
                                    .state
                                    .messages[index]
                                    .messageType ==
                                "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (context
                                        .read<ChatCubit>()
                                        .state
                                        .messages[index]
                                        .messageType ==
                                    "receiver"
                                ? Colors.grey.shade200
                                : Colors.indigo[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            context
                                .read<ChatCubit>()
                                .state
                                .messages[index]
                                .messageContent!,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (context.read<ChatCubit>().state.chatGptStatus ==
                    ChatGptStatus.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 65,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: chatController,
                            decoration: const InputDecoration(
                                hintText: "Send a message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: getAnswer,
                          backgroundColor: Colors.indigo,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }

  getAnswer() async {
    if (chatController.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();

      String question = chatController.text;

      chatController.clear();

      await context.read<ChatCubit>().getChatGptAnswer(question: question);
    }
  }
}
