import 'package:ai_chat_app/assets.dart';
import 'package:ai_chat_app/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.provider});

final ChatProvider provider;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(provider.activeChat?.name ?? "Frogames-GPT"),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset(
            Assets.icMenu,
            width: 24.0,
            height: 24.0,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}