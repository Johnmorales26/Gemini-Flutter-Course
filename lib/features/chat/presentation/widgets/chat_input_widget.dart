import 'package:ai_chat_app/core/provider/chat_provider.dart';
import 'package:ai_chat_app/core/utils/assets.dart';
import 'package:ai_chat_app/core/utils/file_upload.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/message_list_widget.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/send_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({super.key, required this.provider});

  final ChatProvider provider;

  @override
  Widget build(BuildContext context) {
    Widget fileWidget = Container();

    if (provider.fileSelected != null) {
      final fileName = provider.fileSelected!
          .path
          .split('/')
          .last;
      final extension = fileName
          .split('.')
          .last;

      fileWidget = DecoratedBox(decoration: BoxDecoration(
          border: Border.all(
              color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface,
              width: 1.0
          ),
          borderRadius: BorderRadius.circular(8.0)
      ), child: ListTile(
          leading: SvgPicture.asset(
            FileUpload.instance.getImageFile(extension),
            width: 40,
            height: 40,
          ),
          title: Text(fileName),
          subtitle: Text(FileUpload.instance.getTypeFile(extension)),
          trailing: IconButton(
              onPressed: () {
                provider.saveFileSelected(null);
              }, icon: SvgPicture.asset(Assets.icFileClose))
      ));
    } else {
      fileWidget = Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: MessageListWidget(provider: provider),
          ),
          Column(
            children: [
              fileWidget,
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
