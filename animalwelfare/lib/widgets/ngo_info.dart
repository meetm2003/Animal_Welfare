import 'package:flutter/material.dart';
import 'custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NgoInfo extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController contactController;
  final TextEditingController certificateController;
  final VoidCallback onPickImage;
  final VoidCallback onPickPdf;

  const NgoInfo({
    required this.nameController,
    required this.emailController,
    required this.addressController,
    required this.contactController,
    required this.certificateController,
    required this.onPickImage,
    required this.onPickPdf,
    super.key,
  });

  @override
  _NgoInfoState createState() => _NgoInfoState();
}

class _NgoInfoState extends State<NgoInfo> {
  XFile? _ngoImage;
  File? _certificateFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _ngoImage = image;
    });
  }

  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _certificateFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hint: "Name",
          color: Colors.grey,
          controller: widget.nameController,
        ),
        CustomTextField(
          hint: "Email",
          color: Colors.grey,
          controller: widget.emailController,
        ),
        CustomTextField(
          hint: "Address",
          color: Colors.grey,
          controller: widget.addressController,
        ),
        CustomTextField(
          hint: "Contact",
          color: Colors.grey,
          controller: widget.contactController,
        ),
        SizedBox(height: 20),
        if (_ngoImage != null)
          Image.file(
            File(_ngoImage!.path),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text("Pick NGO Image"),
        ),
        SizedBox(height: 20),
        if (_certificateFile != null)
          Text("Certificate picked: ${_certificateFile!.path.split('/').last}"),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickPdf,
          child: Text("Pick Certificate PDF"),
        ),
      ],
    );
  }
}
