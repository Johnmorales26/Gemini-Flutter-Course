import 'package:ai_chat_app/provider/chat_provider.dart';
import 'package:ai_chat_app/widgets/app_bar_widget.dart';
import 'package:ai_chat_app/widgets/chat_input_widget.dart';
import 'package:ai_chat_app/widgets/drawer_header_widget.dart';
import 'package:ai_chat_app/widgets/drawer_search_widget.dart';
import 'package:ai_chat_app/widgets/chat_list_widget.dart'; // Importamos el nuevo widget
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);

    provider.fetchChats();

    return Scaffold(
      appBar: AppBarWidget(provider: provider),
      body: ChatInputWidget(provider: provider),
      drawer: NavigationDrawer(
        selectedIndex: provider.selectedIndex,
        onDestinationSelected: (index) {
          provider.setSelectedIndex(index);
          Navigator.pop(context);
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}