import 'package:flutter/material.dart';
import 'package:opendungeon/model/story_data.dart';

class ConversationWidget extends StatelessWidget {
  final List<Message> conversation;

  const ConversationWidget({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListView.builder(
        itemCount: conversation.length,
        itemBuilder: (context, index) {
          final message = conversation[index];
          if (message.role == "assistant") {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(message.content),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 16.0),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(message.content),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
