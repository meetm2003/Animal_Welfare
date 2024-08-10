import 'package:flutter/material.dart';
import 'custom_textfield.dart';

class AdminInfo extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;

  const AdminInfo({
    required this.nameController,
    required this.emailController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          hint: "Name",
          color: Colors.grey,
          controller: nameController,
        ),
        CustomTextField(
          hint: "Email",
          color: Colors.grey,
          controller: emailController,
        ),
      ],
    );
  }
}