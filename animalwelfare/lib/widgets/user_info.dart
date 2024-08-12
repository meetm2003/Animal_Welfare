import 'dart:io';
import 'package:animalwelfare/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class Userinfo extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController workRoleController;

  const Userinfo({
    required this.nameController,
    required this.emailController,
    required this.workRoleController,
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
          hint: "Work Role",
          color: Colors.grey,
          controller: workRoleController,
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
