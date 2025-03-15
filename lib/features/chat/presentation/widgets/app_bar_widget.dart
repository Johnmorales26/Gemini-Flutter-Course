import 'package:ai_chat_app/core/utils/assets.dart';
import 'package:ai_chat_app/core/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/provider/theme_provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.provider});

  final ChatProvider provider;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      title: Text(provider.activeChat?.name ?? "Frogames-GPT"),
      leading: Builder(
        builder:
            (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset(Assets.icMenu, width: 24.0, height: 24.0),
            ),
      ),
      actions: [
        IconButton(
          onPressed: () => themeProvider.toggleTheme(),
          icon:
              themeProvider.themeMode == ThemeMode.dark
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
