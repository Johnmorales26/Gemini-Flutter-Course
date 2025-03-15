import 'dart:convert';
import 'package:ai_chat_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GeminiService {
  final Logger logger = Logger();
  final String baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  final String model = 'gemini-2.0-flash';

  GeminiService();

  Future<String> sendMessage(String message) async {
    try {
      final url = Uri.parse('$baseUrl/models/$model:generateContent?key=${Constants.apiKey}');

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': message}
            ]
          }
        ]
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        logger.d('Respuesta recibida: ${responseData.toString()}');

        final responseMessage = responseData['candidates'][0]['content']['parts'][0]['text'];
        return responseMessage;
      } else {
        logger.e('Error en la API: ${response.statusCode} - ${response.body}');
        return 'Error en la API: ${response.statusCode}';
      }
    } catch (e) {
      logger.e('Error al enviar el mensaje: $e');
      return 'Error al enviar el mensaje: $e';
    }
  }
}