import 'package:ai_chat_app/assets.dart';
import 'package:ai_chat_app/chat.dart';
import 'package:ai_chat_app/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatListWidget extends StatelessWidget {
  final ChatProvider provider;

  const ChatListWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: provider.chats.map((chat) {
        return InkWell(
          onTap: () {
            provider.setActiveChat(chat);
          },
          child: ListTile(
            title: Text(chat.name, maxLines: 2),
            leading: SvgPicture.asset(
              Assets.icChat,
              width: 24.0,
              height: 24.0,
            ),
            trailing: InkWell(
              onTap: () {
                _showDeleteChatDialog(context, chat);
              },
              child: SvgPicture.asset(
                Assets.icDelete,
                width: 24.0,
                height: 24.0,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showDeleteChatDialog(BuildContext context, Chat chat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Chat'),
          content: const Text(
            '¿Estás seguro de que quieres eliminar este chat?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                provider.deleteChat(chat);
                Navigator.pop(context);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}