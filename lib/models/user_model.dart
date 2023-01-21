import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? age;
  String? ageDuration;
  String? bio;
  String? breed;
  Timestamp? created;
  List<String>? dog_images = [];
  String? profile_image;
  String? dog_name;
  String? email;
  String? gender;
  bool? isKciApproved;
  bool showAdoption;
  String? kci_certificate;
  String? name;
  List<String>? personalities = [];
  String? size;

  UserModel(
      {this.id,
      this.age,
      this.ageDuration = 'Years',
      this.bio,
      this.breed,
      this.created,
      this.dog_images,
      this.profile_image,
      this.dog_name,
      this.email,
      this.gender,
      this.isKciApproved = false,
      this.showAdoption = false,
      this.kci_certificate,
      this.name,
      this.personalities,
      this.size});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      age: json['age'],
      ageDuration: json['ageDuration'] ?? 'Years',
      bio: json['bio'],
      breed: json['breed'],
      created: json['created'],
      dog_images: json['dog_images'] != null ? List<String>.from(json['dog_images']) : null,
      dog_name: json['dog_name'],
      profile_image: json['profile_image'],
      email: json['email'],
      gender: json['gender'],
      isKciApproved: json['isKciApproved'],
      showAdoption: json['showAdoption'] ?? false,
      kci_certificate: json['kci_certificate'],
      name: json['name'],
     personalities: json['personalities'] != null ? List<String>.from(json['personalities']) : null,
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    data['ageDuration'] = ageDuration;
    data['bio'] = bio;
    data['breed'] = breed;
    data['created'] = created;
    data['dog_name'] = dog_name;
    data['profile_image'] = profile_image;
    data['email'] = email;
    data['gender'] = gender;
    data['isKciApproved'] = isKciApproved;
    data['showAdoption'] = showAdoption;
    data['kci_certificate'] = kci_certificate;
    data['name'] = name;
    data['size'] = size;
    if (personalities != null) {
      data['personalities'] = personalities;
    }
    if (dog_images != null) {
      data['dog_images'] = dog_images;
    }
    return data;
  }
}
