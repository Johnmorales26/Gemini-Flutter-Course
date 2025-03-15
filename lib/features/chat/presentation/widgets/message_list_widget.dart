import 'package:flutter/cupertino.dart';
import '../../../../core/provider/chat_provider.dart';
import 'empty_chat_widget.dart';
import 'message_tile_widget.dart';

class MessageListWidget extends StatelessWidget {
  final ChatProvider provider;

  const MessageListWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final messages = provider.messages ?? [];

    if (messages.isEmpty) {
      return EmptyChatWidget();
    }

    return ListView.builder(
      controller: provider.scrollController,
      itemCount: provider.messages?.length ?? 0,
      itemBuilder: (context, index) {
        final chatMessage = provider.messages![index];
        return MessageTileWidget(chatMessage: chatMessage);
      },
    );
  }
}