class ChatMessage {
  int? id;
  int chatId;
  String role;
  String content;
  DateTime timestamp;

  ChatMessage({
    this.id,
    required this.chatId,
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'role': role,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      chatId: map['chatId'],
      role: map['role'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}