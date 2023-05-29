import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/providers/chats_provider.dart';

class ChatController extends GetxController {
  TextEditingController textController = TextEditingController();

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[
    {"message": "Hello", "isUser": true},
    {"message": "How can I have you", "isUser": false},
    // {"message": "Hello", "isUser": true},
    // {"message": "How can I have you", "isUser": false},
    // {"message": "Hello", "isUser": true},
    // {"message": "How can I have you", "isUser": false},
    // {"message": "Hello", "isUser": true},
    // {"message": "How can I have you", "isUser": false},
    // {"message": "Hello", "isUser": true},
    // {"message": "How can I have you", "isUser": false},
    // {"message": "Hello", "isUser": true},
    // {"message": "How can I have you", "isUser": false},
    // {"message": "Hello", "isUser": true},
    // {"message": "How can I have you", "isUser": false},
  ].obs;

  var isLoading = false.obs;

  ChatsProvider chatsProvider = ChatsProvider();

  void sendMessage() async {
    messages.add({"message": textController.text, "isUser": true});
    ResponseApi responseMessage =
        await chatsProvider.sendMessage(textController.text);
    messages.add({"message": responseMessage.message, "isUser": false});
    textController.clear();
  }

  void test() {}
}
