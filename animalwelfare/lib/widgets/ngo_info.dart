import 'package:flutter/material.dart';
import 'custom_textfield.dart';

class NgoInfo extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController contactController;

  const NgoInfo({
    required this.nameController,
    required this.emailController,
    required this.addressController,
    required this.contactController,
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
          hint: "Address",
          color: Colors.grey,
          controller: addressController,
        ),
        CustomTextField(
          hint: "Contact",
          color: Colors.grey,
          controller: contactController,
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
