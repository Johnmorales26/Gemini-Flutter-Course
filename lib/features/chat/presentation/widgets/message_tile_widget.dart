import 'package:ai_chat_app/features/chat/data/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageTileWidget extends StatelessWidget {
  final ChatMessage chatMessage;

  const MessageTileWidget({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          //title: Text(chatMessage.content),
          title: MarkdownBody(
            data: chatMessage.content,
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(
              Theme.of(context),
            ).copyWith(
              p: Theme.of(context).textTheme.bodyLarge,
              code: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                backgroundColor: Colors.grey[200],
              ),
            ),
          ),
          subtitle: Text(
            chatMessage.role,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
