import 'package:ai_chat_app/config/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/theme.dart';
import '../core/provider/theme_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final materialTheme = MaterialTheme(TextTheme());

    return MaterialApp.router(
      title: 'AI Chat',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: provider.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: Navigation.getRouter(),
    );
  }
}
