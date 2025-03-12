import 'package:ai_chat_app/assets.dart';
import 'package:ai_chat_app/provider/chat_provider.dart';
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
            child: ListView.builder(
              itemCount: provider.messages?.length ?? 0,
              itemBuilder: (context, index) {
                final message = provider.messages![index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(message.content),
                      subtitle: Text(
                        message.role,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
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
                    hintText: 'Ask what\'s on mind',
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
