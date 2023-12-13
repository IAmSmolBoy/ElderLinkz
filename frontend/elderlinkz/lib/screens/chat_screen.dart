import 'dart:convert';

import 'package:elderlinkz/globals.dart';
import 'package:elderlinkz/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat;
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({ super.key });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _messages = [];
  final _user = const User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(Message message) {
      _messages.insert(0,
        TextMessage(
          id: const Uuid().v4(),
          author: const User(
            id: 'ElderLinkZ',
            firstName: "ElderLinkZ",
          ),
          text: "test",
          createdAt: DateTime.now().millisecondsSinceEpoch,
        )
      );

    setState(() {
      _messages.insert(0, message);

      prefs.setStringList("messages",
        _messages
          .map(
            (msg) => json.encode(msg.toJson())
          )
          .toList()
      );
    });
  }

  void _handleSendPressed(PartialText message) {
    final textMessage = TextMessage(
      id: const Uuid().v4(),
      author: _user,
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() {
    final List<Message> messages = prefs
      .getStringList("messages")
      ?.map(
        (msg) =>
          Message.fromJson(
            json.decode(msg) as Map<String, dynamic>
          )
      )
      .toList() ?? [];

    setState(() {
      _messages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Layout(
      title: "Chatbot",
      backButton: true,
      bottomNavbar: false,
      body: chat.Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: _user,
        // isLeftStatus: true,
        theme: chat.DefaultChatTheme(
          inputElevation: 10,
          primaryColor: colorScheme.secondary,
          secondaryColor: colorScheme.primary,
          backgroundColor: colorScheme.background,
          inputBackgroundColor: colorScheme.surface,
          inputTextColor: colorScheme.onBackground,
          inputTextCursorColor: colorScheme.onBackground,
          userNameTextStyle: TextStyle(color: colorScheme.onPrimary),
          sentMessageBodyTextStyle: TextStyle(color: colorScheme.onPrimary),
          receivedMessageBodyTextStyle: TextStyle(color: colorScheme.onPrimary),
          seenIcon: const Text(
            'read',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ),
      ),
    );
  } 
}