import 'dart:convert';
import 'package:ai_chat_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GeminiService {
  final Logger logger = Logger();
  final String baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  final String model = 'gemini-2.0-flash';

  GeminiService();

  Future<String> sendMessage(String message) async {
    try {
      // Construir la URL con el endpoint y la clave de API
      final url = Uri.parse('$baseUrl/models/$model:generateContent?key=${Constants.apiKey}');

      // Configurar los encabezados
      final headers = {
        'Content-Type': 'application/json',
      };

      // Configurar el cuerpo de la solicitud
      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': message}
            ]
          }
        ]
      });

      // Enviar la solicitud POST
      final response = await http.post(url, headers: headers, body: body);

      // Verificar el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final responseData = jsonDecode(response.body);
        logger.d('Respuesta recibida: ${responseData.toString()}');

        // Extraer el texto de la respuesta
        final responseMessage = responseData['candidates'][0]['content']['parts'][0]['text'];
        return responseMessage;
      } else {
        // Manejar errores de la API
        logger.e('Error en la API: ${response.statusCode} - ${response.body}');
        return 'Error en la API: ${response.statusCode}';
      }
    } catch (e) {
      // Manejar errores de conexión o de otro tipo
      logger.e('Error al enviar el mensaje: $e');
      return 'Error al enviar el mensaje: $e';
    }
  }
}