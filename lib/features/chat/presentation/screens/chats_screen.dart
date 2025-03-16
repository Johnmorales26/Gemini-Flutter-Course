import 'package:ai_chat_app/core/provider/chat_provider.dart';
import 'package:ai_chat_app/core/utils/assets.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/app_bar_widget.dart';
import 'package:ai_chat_app/features/chat/presentation/widgets/drawer_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/chat_input_widget.dart';
import '../widgets/chat_list_widget.dart';
import '../widgets/drawer_header_widget.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);

    provider.fetchChats();

    return Scaffold(
      appBar: AppBarWidget(provider: provider),
      body: SafeArea(child: ChatInputWidget(provider: provider)),
      drawer: NavigationDrawer(
        selectedIndex: provider.selectedIndex,
        onDestinationSelected: (index) {
          provider.setSelectedIndex(index);
          Navigator.pop(context);
        },
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 16.0, top: 4.0, left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DrawerHeaderWidget(),
                  const SizedBox(height: 16.0),
                  const DrawerSearchWidget(),
                  const SizedBox(height: 16.0),
                  ChatListWidget(provider: provider),
                  const SizedBox(height: 16.0),
                  FloatingActionButton.extended(
                      onPressed: () {},
                      backgroundColor: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      label: Text('New Chat', style: Theme
                          .of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary)),
                      icon: SvgPicture.asset(Assets.icChatFilled, color:
                      Theme
                          .of(context)
                          .colorScheme
                          .onPrimary))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}