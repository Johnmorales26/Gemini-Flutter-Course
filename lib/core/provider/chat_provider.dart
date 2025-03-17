import 'dart:io';

import 'package:ai_chat_app/core/services/database_service.dart';
import 'package:ai_chat_app/core/services/gemini_service.dart';
import 'package:ai_chat_app/core/services/vertex_service.dart';
import 'package:ai_chat_app/features/chat/data/chat_message.dart';
import 'package:ai_chat_app/features/chat/domain/chat.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ChatProvider extends ChangeNotifier {
  final Logger logger = Logger();
  final DatabaseService db = DatabaseService();
  final GeminiService geminiService = GeminiService();
  final VertexService vertexService = VertexService();

  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  bool _isSending = false;
  bool get isSending => _isSending;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  Chat? _activeChat;
  Chat? get activeChat => _activeChat;

  bool _isLoadResponse = false;
  bool get isLoadResponse => _isLoadResponse;

  List<ChatMessage>? _messages;
  List<ChatMessage>? get messages => _messages;

  List<File> _fileSelected = [];
  List<File> get fileSelected => _fileSelected;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setActiveChat(Chat chat) {
    _activeChat = chat;
    getMessagesForChat(chat.id!);
    notifyListeners();
  }

  Future<void> insertChat() async {
    try {
      final chatId = DateTime.now().millisecondsSinceEpoch;
      final newChat = Chat(
        id: chatId,
        name: messageController.text.trim(),
        createdAt: DateTime.now(),
      );

      final userMessage = ChatMessage(
        chatId: chatId,
        role: 'USER',
        content: messageController.text.trim(),
        timestamp: DateTime.now(),
      );

      logger.d('Se va a guardar: $newChat');

      await _saveChatAndMessage(newChat, userMessage);
      _sendMessageToGemini(chatId, messageController.text.trim());

      setActiveChat(newChat);
      messageController.clear();
      fetchChats();
    } catch (e) {
      logger.e('Error al insertar el chat: $e');
    }
  }

  Future<void> sendNewMessageInCurrentChat() async {
    if (_isSending) return;

    _isSending = true;
    notifyListeners();

    try {
      if (_activeChat == null) {
        logger.d('No hay un chat activo');
        return;
      }

      final userMessage = ChatMessage(
        chatId: _activeChat!.id!,
        role: 'USER',
        content: messageController.text.trim(),
        timestamp: DateTime.now(),
      );

      await _saveMessage(userMessage);
      _sendMessageToGemini(_activeChat!.id!, messageController.text.trim());

      messageController.clear();
    } catch (e) {
      logger.e('Error al enviar el mensaje en el chat actual: $e');
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }

  Future<void> _saveChatAndMessage(Chat chat, ChatMessage message) async {
    await db.insertChat(chat);
    await db.insertMessage(message);
    _addMessageToUI(message);
  }

  Future<void> _saveMessage(ChatMessage message) async {
    await db.insertMessage(message);
    _addMessageToUI(message);
  }

  void _addMessageToUI(ChatMessage message) {
    _messages ??= [];
    _messages!.add(message);
    _scrollToBottom();
    notifyListeners();
  }

  void _updateMessageToUI(ChatMessage updatedMessage) {
    final index = _messages!.indexWhere((message) => message.id == updatedMessage.id);

    if (index != -1) {
      _messages![index] = updatedMessage;

      _scrollToBottom();

      notifyListeners();
    } else {
      _addMessageToUI(updatedMessage);
    }
  }

  /*Future<void> _sendMessageToGemini(int chatId, String message) async {
    //final response = await geminiService.sendMessage(message);
    final response = await vertexService.sendRequestToModel(message);

    final responseMessage = ChatMessage(
      chatId: chatId,
      role: 'GEMINI',
      content: response.trim(),
      timestamp: DateTime.now(),
    );

    await db.insertMessage(responseMessage);
    _addMessageToUI(responseMessage);
  }*/

  void _sendMessageToGemini(int chatId, String message) async {
    _isLoadResponse = true;
    final response = await vertexService.sendRequestToModel(message, _fileSelected);
    final timestamp = DateTime.now();

    final responseMessage = ChatMessage(
      id: timestamp.microsecondsSinceEpoch,
      chatId: chatId,
      role: 'GEMINI',
      content: response,
      timestamp: timestamp,
    );

    _updateMessageToUI(responseMessage);

    db.insertMessage(responseMessage);
    _fileSelected = [];
    _isLoadResponse = false;
  }

  void fetchChats() async {
    _chats = await db.getChats();
    notifyListeners();
  }

  void getMessagesForChat(int chatId) async {
    final response = await db.getMessagesForChat(chatId);
    _messages = response.isEmpty ? null : response;
    notifyListeners();
  }

  void deleteChat(Chat chat) async {
    if (chat == _activeChat) {
      _activeChat = null;
    }

    _chats.remove(chat);
    _messages?.removeWhere((message) => message.chatId == chat.id);
    notifyListeners();

    await db.deleteChat(chat.id!);
    await db.deleteMessagesFromChat(chat.id!);
  }

  void _scrollToBottom() async {
    Future.delayed(Duration(microseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: Duration(microseconds: 300),
            curve: Curves.easeOut);
      }
    });
  }

  void saveFileSelected(File? file) {
    if (file != null) {
      _fileSelected.add(file);
    }
    notifyListeners();
  }

  void removeFileAtIndex(int index) {
    if (index >= 0 && index < fileSelected.length) {
      fileSelected.removeAt(index);
      notifyListeners();
    }
  }
}