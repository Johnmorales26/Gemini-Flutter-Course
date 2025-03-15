import 'package:ai_chat_app/core/provider/chat_provider.dart';
import 'package:ai_chat_app/core/utils/assets.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/message_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({super.key, required this.provider});

  final ChatProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: MessageListWidget(provider: provider),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: provider.messageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Ask what you want',
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  if (provider.isSending) {
                    return;
                  }

                  if (provider.activeChat == null) {
                    provider.insertChat();
                  } else {
                    provider.sendNewMessageInCurrentChat();
                  }
                },
                child: Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color:
                        provider.isSending
                            ? Colors.grey
                            : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: SvgPicture.asset(
                        Assets.icSend,
                        color:
                            provider.isSending
                                ? Colors.grey[300]
                                : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
