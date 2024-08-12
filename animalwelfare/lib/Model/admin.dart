import 'dart:convert';

Ngo ngoFromJson(String str) => Ngo.fromJson(json.decode(str));

String ngoToJson(Ngo data) => json.encode(data.toJson());

class Ngo {
    String name;
    String email;
    String profileImage;

    Ngo({
        required this.name,
        required this.email,
        required this.profileImage,
    });

    factory Ngo.fromJson(Map<String, dynamic> json) => Ngo(
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "profileImage": profileImage,
    };
}
