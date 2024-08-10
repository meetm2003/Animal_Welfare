import 'package:flutter/material.dart';
import 'custom_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HospitalInfo extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController contactController;
  final TextEditingController certificateController;
  final VoidCallback onPickImage;
  final VoidCallback onPickPdf;

  const HospitalInfo({
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
  _HospitalInfoState createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
  XFile? _hospitalImage;
  File? _certificateFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _hospitalImage = image;
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
        if (_hospitalImage != null)
          Image.file(
            File(_hospitalImage!.path),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text("Pick Hospital Image"),
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
