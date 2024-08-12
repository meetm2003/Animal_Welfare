import 'dart:convert';
import 'dart:io';

class ImageConverter {
  static Future<String> imageToBase64(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      throw Exception("Error converting image to base64: $e");
    }
  }
}

// File imageFile = File('path_to_image');
// String base64Image = await ImageConverter.imageToBase64(imageFile);