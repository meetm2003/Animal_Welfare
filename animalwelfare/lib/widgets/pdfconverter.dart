import 'dart:convert';
import 'dart:io';

class PDFConverter {
  static Future<String> pdfToBase64(File pdfFile) async {
    try {
      final bytes = await pdfFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      throw Exception("Error converting PDF to base64: $e");
    }
  }
}


// File pdfFile = File('path_to_pdf');
// String base64PDF = await PDFConverter.pdfToBase64(pdfFile);