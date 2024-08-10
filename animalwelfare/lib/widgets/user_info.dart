import 'dart:io';
import 'package:animalwelfare/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Userinfo extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController workRoleController;
  final VoidCallback onPickImage;

  const Userinfo({
    required this.nameController,
    required this.emailController,
    required this.workRoleController,
    required this.onPickImage,
    super.key,
  });

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<Userinfo> {
  XFile? _profileImage; // Store selected image

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profileImage = image;
    });
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
          hint: "Work Role",
          color: Colors.grey,
          controller: widget.workRoleController,
        ),
        SizedBox(height: 20),
        if (_profileImage != null)
          Image.file(
            File(_profileImage!.path),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text("Pick Profile Image"),
        ),
      ],
    );
  }
}
