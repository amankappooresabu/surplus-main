import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController {
  // Define a list of messages (observable)
  final RxList<Map<String, String>> messages = RxList<Map<String, String>>([
   
  ]);

  // Function to add a new message
  void addMessage(String sender, String text) {
    messages.add({'sender': sender, 'text': text});
    update(); // Update the UI after adding the message
  }

  // TextEditingController for the message field (optional)
  final TextEditingController messageController = TextEditingController();
}