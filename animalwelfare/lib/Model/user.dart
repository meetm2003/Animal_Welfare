import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String name;
    String email;
    String profileImage;
    String work;

    User({
        required this.name,
        required this.email,
        required this.profileImage,
        required this.work,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"],
        work: json["work"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "work": work,
    };
}
