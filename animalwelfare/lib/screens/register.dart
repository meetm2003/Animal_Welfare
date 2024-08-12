import 'dart:io';
import 'package:animalwelfare/screens/homepage.dart';
import 'package:animalwelfare/services/saveHospitalData.dart';
import 'package:animalwelfare/services/saveNgoData.dart';
import 'package:animalwelfare/services/saveUserData.dart';
import 'package:animalwelfare/widgets/custom_textfield.dart';
import 'package:animalwelfare/widgets/hospital_info.dart';
import 'package:animalwelfare/widgets/imageconverter.dart';
import 'package:animalwelfare/widgets/ngo_info.dart';
import 'package:animalwelfare/widgets/pdfconverter.dart';
import 'package:animalwelfare/widgets/user_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String email = '', password = '', selectedUserType = "user";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController workRoleController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;
  String? base64image;
  File? _certificateFile;
  String? base64Pdf;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
    base64image = await ImageConverter.imageToBase64(File(image!.path));
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      File pdfFile = File(result.files.single.path!);
      setState(() {
        _certificateFile = pdfFile;
      });
      base64Pdf = await PDFConverter.pdfToBase64(pdfFile);
    }
  }

  Future<void> registeration() async {
    if (password != null && emailController.text != "") {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        String userId = userCredential.user!.uid;

        if (selectedUserType == 'user') {
          UserDatabaseService.saveUserData(
              userId: userId,
              email: emailController.text,
              name: nameController.text,
              profileImage: base64image ?? '',
              work: workRoleController.text);
        } else if (selectedUserType == 'ngo') {
          NgoDatabaseService.saveNgoData(
              ngoId: userId,
              name: nameController.text,
              email: emailController.text,
              certificate: base64Pdf ?? '',
              profileImage: base64image ?? '',
              address: addressController.text,
              contact: contactController.text);
        } else if (selectedUserType == 'hospital') {
          HospitalDatabaseService.saveHospitalData(
              hospitalId: userId,
              name: nameController.text,
              email: emailController.text,
              certificate: base64Pdf ?? '',
              profileImage: base64image ?? '',
              address: addressController.text,
              contact: contactController.text);
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
            builder: (context) => const HomePage(),
          ),
        );
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
    final screenWidth = mediaQuery.size.width;
    final padding = screenWidth * 0.05;
    final profileImageSize = screenWidth * 0.3;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registration",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
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
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: pickImage,
                              child: CircleAvatar(
                                radius: profileImageSize / 2,
                                backgroundImage: _profileImage != null
                                    ? FileImage(File(_profileImage!.path))
                                    : const AssetImage(
                                            'assets/images/default_profile.png')
                                        as ImageProvider,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Profile Pic",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        if (selectedUserType == 'ngo' ||
                            selectedUserType == 'hospital') ...[
                          const SizedBox(width: 30),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: pickPdf,
                                child: CircleAvatar(
                                  radius: profileImageSize / 2,
                                  backgroundColor: Colors.grey[300],
                                  child: _certificateFile != null
                                      ? const Icon(Icons.picture_as_pdf,
                                          color: Colors.red, size: 40)
                                      : const Text(
                                          "PDF",
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 18,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                selectedUserType == 'hospital'
                                    ? "Hospital Certificate"
                                    : "NGO Certificate",
                                style: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 30),
                    DropdownButtonFormField<String>(
                      value: selectedUserType.isEmpty ? null : selectedUserType,
                      items: const [
                        DropdownMenuItem(child: Text('User'), value: 'user'),
                        DropdownMenuItem(
                            child: Text('Hospital'), value: 'hospital'),
                        DropdownMenuItem(child: Text('NGO'), value: 'ngo'),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedUserType = value!;
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
                    const SizedBox(height: 15),
                    if (selectedUserType == 'user') ...[
                      Userinfo(
                          nameController: nameController,
                          emailController: emailController,
                          workRoleController: workRoleController),
                    ] else if (selectedUserType == 'hospital') ...[
                      HospitalInfo(
                          nameController: nameController,
                          emailController: emailController,
                          addressController: addressController,
                          contactController: contactController),
                    ] else if (selectedUserType == 'ngo') ...[
                      NgoInfo(
                          nameController: nameController,
                          emailController: emailController,
                          addressController: addressController,
                          contactController: contactController),
                    ],
                    const SizedBox(height: 5),
                    CustomTextField(
                      hint: "Password",
                      color: Colors.grey,
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                        }
                        registeration();
                      },
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
                    const SizedBox(
                      height: 100,
                    )
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
