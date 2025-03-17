import 'package:ai_chat_app/core/utils/assets.dart';

class FileUpload {
  static final FileUpload _instance = FileUpload._internal();

  FileUpload._internal();

  static FileUpload get instance => _instance;

  final validImageExtensions = ['jpg', 'jpeg', 'png', 'webp'];
  final validPdfExtensions = ['pdf'];
  final validAudioExtensions = [
    'aac',
    'm4a',
    'flac',
    'mp3',
    'm4a',
    'mp2',
    'mpg',
    'mpga',
    'opus',
    'pcm',
    'wav',
    'webm',
  ];
  final validVideoExtensions = [
    'flv',
    'mov',
    'mpeg',
    'mpg',
    'mp4',
    'webm',
    'wmv',
    '3gp',
    'mpgps',
  ];

  List<String> getAllValidExtensions() {
    return [
      ...validImageExtensions,
      ...validPdfExtensions,
      ...validAudioExtensions,
      ...validVideoExtensions,
    ];
  }

  String getTypeFile(String extension) {
    final ext = extension.toLowerCase();

    if (validImageExtensions.contains(ext)) {
      return 'IMAGE';
    } else if (validPdfExtensions.contains(ext)) {
      return 'PDF';
    } else if (validAudioExtensions.contains(ext)) {
      return 'AUDIO';
    } else if (validVideoExtensions.contains(ext)) {
      return 'VIDEO';
    } else {
      return 'UNKNOWN';
    }
  }

  String getImageFile(String extension) {
    final ext = extension.toLowerCase();

    if (validImageExtensions.contains(ext)) {
      return Assets.icFileImage;
    } else if (validPdfExtensions.contains(ext)) {
      return Assets.icFileFile;
    } else if (validAudioExtensions.contains(ext)) {
      return Assets.icFileAudio;
    } else if (validVideoExtensions.contains(ext)) {
      return Assets.icFileVideo;
    } else {
      return Assets.icFileUnknown;
    }
  }

  String getMimeType(String extension) {
    final ext = extension.toLowerCase();

    if (validImageExtensions.contains(ext)) {
      return 'image';
    } else if (validPdfExtensions.contains(ext)) {
      return 'application';
    } else if (validAudioExtensions.contains(ext)) {
      return 'audio';
    } else if (validVideoExtensions.contains(ext)) {
      return 'video';
    } else {
      return Assets.icFileUnknown;
    }
  }
}
