import 'package:ai_chat_app/config/routes.dart';
import 'package:ai_chat_app/features/chat/presentation/screens/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static GoRouter getRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: Routes.chatRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const ChatsScreen();
          },
        ),
      ],
    );
  }
}
