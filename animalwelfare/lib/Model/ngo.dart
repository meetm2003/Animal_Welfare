import 'dart:convert';

Ngo ngoFromJson(String str) => Ngo.fromJson(json.decode(str));

String ngoToJson(Ngo data) => json.encode(data.toJson());

class Ngo {
    String name;
    String email;
    String certificate;
    String profileImage;
    String address;
    String contact;

    Ngo({
        required this.name,
        required this.email,
        required this.certificate,
        required this.profileImage,
        required this.address,
        required this.contact,
    });

    factory Ngo.fromJson(Map<String, dynamic> json) => Ngo(
        name: json["name"],
        email: json["email"],
        certificate: json["certificate"],
        profileImage: json["profileImage"],
        address: json["address"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "certificate": certificate,
        "profileImage": profileImage,
        "address": address,
        "contact": contact,
    };
}
