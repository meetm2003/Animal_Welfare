// ngo_database_service.dart
import 'package:animalwelfare/Model/ngo.dart';
import 'package:firebase_database/firebase_database.dart';

class NgoDatabaseService {
  static final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  static Future<void> saveNgoData({
    required String ngoId,
    required String name,
    required String email,
    required String certificate,
    required String profileImage,
    required String address,
    required String contact,
  }) async {
    Ngo ngo = Ngo(
      name: name,
      email: email,
      certificate: certificate,
      profileImage: profileImage,
      address: address,
      contact: contact,
    );

    Map<String, dynamic> ngoJson = ngo.toJson();

    try {
      await _databaseReference.child('ngos').child(ngoId).set(ngoJson);
      print("NGO data saved successfully.");
    } catch (e) {
      print("Failed to save NGO data: $e");
    }
  }
}
