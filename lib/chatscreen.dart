import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  final RxList<Map<String, String>> messages =
      RxList<Map<String, String>>([]);

  void addMessage(String sender, String recipient, String text) {
    _messagesCollection.add({
      'sender': sender,
      'recipient': recipient,
      'text': text,
      'timestamp': Timestamp.now(),
    }).then((_) {
      messages.add({'sender': sender, 'text': text});
      update();
    }).catchError((error) {
      print('Failed to add message: $error');
    });
  }

  final TextEditingController messageController = TextEditingController();
}

class ChatScreen extends GetWidget<ChatController> {
  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();

    final Map<String, dynamic>? userData = Get.arguments as Map<String, dynamic>?;
    final String userId = userData?['uid'] ?? 'Unknown User';
    final String userName = userData?['name'] ?? 'Unknown User';
    final String recipientId = userData?['recipientId'] ?? 'Unknown Recipient';

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = chatController.messages[index];
                  final isSender = message['senderId'] == userId;

                  return Align(
                    alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSender ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text']!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatController.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String messageText = chatController.messageController.text;
                    if (messageText.isNotEmpty) {
                      chatController.addMessage(userId, recipientId, messageText); // Pass recipient ID when adding message
                      chatController.messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

