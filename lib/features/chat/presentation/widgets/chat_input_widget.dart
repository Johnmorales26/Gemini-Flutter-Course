import 'package:ai_chat_app/core/provider/chat_provider.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/message_list_widget.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/send_button_widget.dart';
import 'package:flutter/material.dart';

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

          if (provider.fileSelected.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.fileSelected.length,
                itemBuilder: (context, index) {
                  final file = provider.fileSelected[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            file,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              provider.removeFileAtIndex(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 8.0),

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
              SendButtonWidget(provider: provider),
            ],
          ),
        ],
      ),
    );
  }
}