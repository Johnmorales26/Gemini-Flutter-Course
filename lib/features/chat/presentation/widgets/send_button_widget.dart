import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/provider/chat_provider.dart';
import '../../../../core/utils/assets.dart';

class SendButtonWidget extends StatelessWidget {
  final ChatProvider provider;

  const SendButtonWidget({
    super.key,
    required this.provider
  });

  Widget sendButton(BuildContext context) {
    return InkWell(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (provider.isLoadResponse) {
      return CircularProgressIndicator();
    } else {
      return sendButton(context);
    }
  }
}
