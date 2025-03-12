import 'package:ai_chat_app/routes/routes.dart';
import 'package:ai_chat_app/screens/chatsModule/chats_screen.dart';
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
