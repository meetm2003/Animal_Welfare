import 'dart:io';

import 'package:animalwelfare/screens/homescreen.dart';
import 'package:animalwelfare/widgets/admin_info.dart';
import 'package:animalwelfare/widgets/custom_textfield.dart';
import 'package:animalwelfare/widgets/hospital_info.dart';
import 'package:animalwelfare/widgets/ngo_info.dart';
import 'package:animalwelfare/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';  // Import Firebase Realtime Database package
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String userType = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController certificateController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController workRoleController= TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _ngoImage;
  File? _certificateFile;

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _ngoImage = image;
    });
  }

  void _pickPdf() async {
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

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final userId = userCredential.user?.uid;

        if (userId != null) {
          DatabaseReference dbRef = FirebaseDatabase.instance.ref();

          if (userType == 'user') {
            await dbRef.child('users').child(userId).set({
              'name': nameController.text,
              'email': emailController.text,
              'profileImage': imageController.text,  // Handle image URL
              'work': workRoleController.text,  // Work role input is empty
            });
          } else if (userType == 'hospital') {
            await dbRef.child('hospitals').child(userId).set({
              'name': nameController.text,
              'email': emailController.text,
              'certificate': certificateController.text,  // Handle PDF URL
              'image': imageController.text,  // Handle image URL
              'address': addressController.text,
              'contact': contactController.text,
            });
          } else if (userType == 'ngo') {
            await dbRef.child('ngos').child(userId).set({
              'name': nameController.text,
              'email': emailController.text,
              'certificate': certificateController.text,  // Handle PDF URL
              'image': imageController.text,  // Handle image URL
              'address': addressController.text,
              'contact': contactController.text,
            });
          } else if (userType == 'admin') {
            await dbRef.child('admins').child(userId).set({
              'name': nameController.text,
              'email': emailController.text,
            });
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Registered Successfully!",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already Exists",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.width * 0.05;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/p1.png",
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 35),
                    DropdownButtonFormField<String>(
                      value: userType.isEmpty ? null : userType,
                      items: const [
                        DropdownMenuItem(child: Text('User'), value: 'user'),
                        DropdownMenuItem(child: Text('Hospital'), value: 'hospital'),
                        DropdownMenuItem(child: Text('NGO'), value: 'ngo'),
                      ],
                      onChanged: (value) {
                        setState(() {
                          userType = value ?? '';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: padding * 0.98,
                          vertical: padding,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Select User Type',
                        hintStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    if (userType == 'user') ...[
                      Userinfo(
                        nameController: nameController,
                        emailController: emailController,
                        workRoleController: TextEditingController(),
                        onPickImage: _pickImage,
                      ),
                    ] else if (userType == 'hospital') ...[
                      HospitalInfo(
                        nameController: nameController,
                        emailController: emailController,
                        addressController: addressController,
                        contactController: contactController,
                        certificateController: certificateController,
                        onPickImage: _pickImage,
                        onPickPdf: _pickPdf,
                      ),
                    ] else if (userType == 'ngo') ...[
                      NgoInfo(
                        nameController: nameController,
                        emailController: emailController,
                        addressController: addressController,
                        contactController: contactController,
                        certificateController: certificateController,
                        onPickImage: _pickImage,
                        onPickPdf: _pickPdf,
                      ),
                    ] else if (userType == 'admin') ...[
                      AdminInfo(
                        nameController: nameController,
                        emailController: emailController,
                      ),
                    ],
                    const SizedBox(height: 20),
                    CustomTextField(
                      hint: "Password",
                      color: Colors.grey,
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 113, 165, 255),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}