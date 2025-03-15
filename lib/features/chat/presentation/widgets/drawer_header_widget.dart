import 'package:ai_chat_app/core/utils/assets.dart';
import 'package:flutter/material.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(Assets.icFrogColor, width: 48, height: 48),
        const SizedBox(width: 8.0),
        Text('Frogames-GPT', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
