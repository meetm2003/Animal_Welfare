import 'package:animalwelfare/Model/User.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDatabaseService {
  static final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  static Future<void> saveUserData({
    required String userId,
    required String name,
    required String email,
    required String profileImage,
    required String work,
  }) async {
    User user = User(
      name: name,
      email: email,
      profileImage: profileImage,
      work: work,
    );

    Map<String, dynamic> userJson = user.toJson();

    try {
      await _databaseReference.child('users').child(userId).set(userJson);
      print("User data saved successfully.");
    } catch (e) {
      print("Failed to save user data: $e");
    }
  }
}
