import 'dart:io';

import 'package:ai_chat_app/core/utils/file_upload.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../core/provider/chat_provider.dart';
import '../../../../core/utils/assets.dart';
import 'option_button_widget.dart';

class SendButtonWidget extends StatelessWidget {
  final ChatProvider provider;

  const SendButtonWidget({
    super.key,
    required this.provider
  });

  Future<File?> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: FileUpload.instance.getAllValidExtensions(),
      );

      if (result != null) {
        PlatformFile platformFile = result.files.first;
        File file = File(platformFile.path!);
        return file;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Widget sendButton(BuildContext context) {
    return Row(
        children: [
          SendButton(
            asset: Assets.icClip,
            provider: provider,
            onPressed: () async {
              final file = await _pickFile();
              if (file != null) provider.saveFileSelected(file);
            },
        ),
          const SizedBox(width: 8.0),
          SendButton(
            asset: Assets.icSend,
            provider: provider,
            onPressed: () {
              if (provider.activeChat == null) {
                provider.insertChat();
              } else {
                provider.sendNewMessageInCurrentChat();
              }
            },
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    if (provider.isLoadResponse) {
      return CircularProgressIndicator();
    } else {
      return sendButton(context);
    }
  }
}
