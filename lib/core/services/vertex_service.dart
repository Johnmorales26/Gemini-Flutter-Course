import 'dart:io';

import 'package:ai_chat_app/core/utils/file_upload.dart';
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

  Future<String> sendRequestToModelWithImages(String message, List<File> files) async {
    try {
      if (files.isEmpty) {
        logger.e('No files selected');
        return 'Error: No file has been selected';
      }

      final filesPart = <InlineDataPart>[];

      for (final file in files) {
        final fileExtension = file.path.split('.').last.toLowerCase();

        final validExtensions = FileUpload.instance.getAllValidExtensions();
        if (!validExtensions.contains(fileExtension)) {
          logger.e('Invalid file type: $fileExtension');
          return 'Error: Invalid file type. Only images are allowed (jpg, jpeg, png)';
        }

        final fileBytes = await file.readAsBytes();

        filesPart.add(InlineDataPart(
          '${FileUpload.instance.getMimeType(fileExtension)}/$fileExtension',
          fileBytes,
        ));
      }

      final prompt = TextPart(message);

      final response = await model.generateContent([
        Content.multi([prompt, ...filesPart])
      ]);

      if (response.text != null) {
        return response.text!;
      } else {
        logger.e('Response from model is null');
        return 'Error: Response from model is null';
      }
    } catch (e) {
      logger.e('Error sending request to model: $e');
      return 'Error: $e';
    }
  }

  Stream<String> sendStreamRequestToModel(String message, File? file) async* {
    if (file == null) {
      logger.e('File is null');
      yield 'Error: No file has been selected';
      return;
    }

    if (!await file.exists()) {
      logger.e('File does not exist at the specified path');
      yield 'Error: The file does not exist';
      return;
    }

    final validExtensions = FileUpload.instance.getAllValidExtensions();
    final fileExtension = file.path
        .split('.')
        .last
        .toLowerCase();

    if (!validExtensions.contains(fileExtension)) {
      logger.e('Invalid file type: $fileExtension');
      yield 'Error: Invalid file type. Only images are allowed (jpg, jpeg, png)';
      return;
    }

    try {
      final fileBytes = await file.readAsBytes();

      final filePart = InlineDataPart(
          '${FileUpload.instance.getMimeType(fileExtension)}/$fileExtension',
          fileBytes);

      logger.d('${FileUpload.instance.getMimeType(fileExtension)}/$fileExtension');

      final streamResponse = model.generateContentStream([
        Content.multi([TextPart(message), filePart])
      ]);

      await for (final response in streamResponse) {
        if (response.text != null) {
          yield response.text!;
        } else {
          logger.e('Stream response is null');
          yield 'Error: Stream response is null';
        }
      }
    } catch (e) {
      logger.e('Error sending stream request to the model: $e');
      yield 'Error: $e';
    }
  }

}