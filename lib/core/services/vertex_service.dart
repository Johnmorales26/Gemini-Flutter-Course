import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:logger/logger.dart';

class VertexService {
  final Logger logger = Logger();
  late final GenerativeModel model;

  VertexService() {
    model = FirebaseVertexAI.instance.generativeModel(model: 'gemini-2.0-flash');
  }

  Future<String> sendRequestToModel(String message) async {
    try {
      final prompt = [Content.text(message)];

      final response = await model.generateContent(prompt);

      if (response.text != null) {
        return response.text!;
      } else {
        logger.e('Response to model is null');
        return 'Error: Response to model is null';
      }
    } catch (e) {
      logger.e('Error sending request to model: $e');
      return 'Error: $e';
    }
  }

  Stream<String> sendStreamRequestToModel(String message) async* {
    try {
      final prompt = [Content.text(message)];

      final streamResponse = model.generateContentStream(prompt);

      await for (final response in streamResponse) {
        if (response.text != null) {
          yield response.text!;
        } else {
          logger.e('Stream response is null');
          yield 'Error: Stream response is null';
        }
      }
    } catch (e) {
      logger.e('Error sending stream request to model: $e');
      yield 'Error: $e';
    }
  }

}