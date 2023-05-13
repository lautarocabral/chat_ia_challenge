import 'package:flutter/material.dart';

import '../models/chat_message_model.dart';

class MainChatPage extends StatefulWidget {
  const MainChatPage({super.key});

  @override
  State<MainChatPage> createState() => _MainChatPageState();
}

List<ChatMessageModel> messages = [
  ChatMessageModel(messageContent: "Hello!!", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "How can i help you?", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "I can't understand what you are saying?",
      messageType: "sender"),
  ChatMessageModel(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessageModel(messageContent: "Hello!!", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "How can i help you?", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "I can't understand what you are saying?",
      messageType: "sender"),
  ChatMessageModel(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
  ChatMessageModel(messageContent: "Hello!!", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "How can i help you?", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "I can't understand what you are saying?",
      messageType: "sender"),
  ChatMessageModel(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessageModel(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
];

class _MainChatPageState extends State<MainChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 70),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 65,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.blue,
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
        ),
      ),
    );
  }
}
