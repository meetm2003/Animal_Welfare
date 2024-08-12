import 'dart:convert';

Hospital hospitalFromJson(String str) => Hospital.fromJson(json.decode(str));

String hospitalToJson(Hospital data) => json.encode(data.toJson());

class Hospital {
    String name;
    String email;
    String certificate;
    String profileImage;
    String address;
    String contact;

    Hospital({
        required this.name,
        required this.email,
        required this.certificate,
        required this.profileImage,
        required this.address,
        required this.contact,
    });

    factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
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
