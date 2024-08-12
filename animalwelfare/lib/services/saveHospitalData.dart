// hospital_database_service.dart
import 'package:animalwelfare/Model/hospital.dart';
import 'package:firebase_database/firebase_database.dart';

class HospitalDatabaseService {
  static final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  static Future<void> saveHospitalData({
    required String hospitalId,
    required String name,
    required String email,
    required String certificate,
    required String profileImage,
    required String address,
    required String contact,
  }) async {
    Hospital hospital = Hospital(
      name: name,
      email: email,
      certificate: certificate,
      profileImage: profileImage,
      address: address,
      contact: contact,
    );

    Map<String, dynamic> hospitalJson = hospital.toJson();

    try {
      await _databaseReference.child('hospitals').child(hospitalId).set(hospitalJson);
      print("Hospital data saved successfully.");
    } catch (e) {
      print("Failed to save hospital data: $e");
    }
  }
}
