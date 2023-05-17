import 'package:chat_ia_challenge/cubits/chat/chat_cubit.dart';
import 'package:chat_ia_challenge/pages/main_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'repositories/chat_gpt_repository.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ChatGptRepository(),
      child: BlocProvider<ChatCubit>(
        create: (context) => ChatCubit(
          chatGptRepository: context.read<ChatGptRepository>(),
        )..add(),
        child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          routes: {
            '/': (context) => const MyHomePage(title: 'by @lautarocabral'),
            '/mainChatPage': (context) => const MainChatPage(),
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _apiKeyFieldController = TextEditingController();
  String? codeDialog;
  String? valueText;

  @override
  void dispose() {
    // TODO: implement dispose
    _apiKeyFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                "Hi there, make sure you've configured your API key inside your .env file",
                textAlign: TextAlign.start,
                textScaleFactor: 2.0,
                style: TextStyle(color: Colors.indigo, fontSize: 10.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => displayTextInputDialog(context),
              child: const Text('SetApiKey'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mainChatPage');
              },
              child: const Text('Go to chat!'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Set your personal Api Key',
              style: TextStyle(fontSize: 20),
            ),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _apiKeyFieldController,
              decoration: InputDecoration(hintText: "sk-lJvk..."),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.indigo,
                textColor: Colors.white,
                child: const Text('Ok'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
