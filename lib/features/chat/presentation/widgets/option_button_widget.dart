import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/provider/chat_provider.dart';

class SendButton extends StatelessWidget {
  final String asset;
  final ChatProvider provider;
  final VoidCallback onPressed;

  const SendButton({
    super.key,
    required this.asset,
    required this.provider,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: provider.isSending ? null : onPressed,
      child: Container(
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: provider.isSending
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Center(
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: SvgPicture.asset(
              asset,
              color: provider.isSending
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}