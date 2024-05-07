import 'dart:developer';

import 'package:fitness_app/fitness_app/openAi/repository/openai_repository.dart';
import 'package:fitness_app/fitness_app/openAi/widgets/ai_message.dart';
import 'package:fitness_app/fitness_app/openAi/widgets/loading.dart';
import 'package:fitness_app/fitness_app/openAi/widgets/user_message.dart';
import 'package:flutter/material.dart';

/// Chat Model
class ChatModel extends ChangeNotifier {
  /// List of messages.
  List<Widget> messages = [];

  /// Message list getter.
  List<Widget> get getMessages => messages;

  /// Sends chat request to OpenAI chat server.
  Future<void> sendChat(String txt) async {
    try {
      addUserMessage(txt);

      final response = await OpenAiRepository.sendMessage(prompt: txt);
      final text = response['choices'] == null
          ? ["Insufficient Quota"]
          : (response['choices'] as List<dynamic>).map(
              (t) => (t as Map)['text'] as String,
            );
      //remove the last item
      messages
        ..removeLast()
        ..add(AiMessage(text: text.first));
    } catch (e) {
      log('Exception on sendChat: $e');
    }
    notifyListeners();
  }

  /// Adds a new message to the list.
  void addUserMessage(String txt) {
    messages
      ..add(UserMessage(text: txt))
      ..add(const Loading(text: '...'));
    notifyListeners();
  }
}
