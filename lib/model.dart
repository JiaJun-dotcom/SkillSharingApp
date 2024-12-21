import 'package:flutter/material.dart';

class Profile {
  final String id;
  final String name;
  final String username;
  final Image? profilepic;
  final String email;
  final int hpnumber;
  final List<String> skills;
  final String bio;

  Profile({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.skills,
    this.profilepic,
    required this.hpnumber,
    required this.bio,
  });

  static Profile empty() {
    return Profile(
      id: '',
      name: '',
      username: '',
      email: '',
      hpnumber: 0,
      bio: '',
      skills: [],
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        skills: List<String>.from(json['skills']),
        // Handle list of strings
        hpnumber: json['hpnumber'],
        bio: json['bio'],
        profilepic: json['profilepic']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'skills': skills,
      'bio': bio,
      'hpnumber': hpnumber,
      'profilepic': profilepic
    };
  }
}

class Skills {
  final int id;
  final String name;
  final String Description;
  List? teachers;

  Skills({required this.id, required this.name, required this.Description, this.teachers});

  factory Skills.fromJson(Map<String, dynamic> json) {
// assuming you received input in json format of different teachers that teaches this skill, convert them to a list of teachers then return it in
    // the output as a list of teacher objects, so from json map each teacher to a object first, then convert into a list
// logic of matching teacher by skill name to be implemented in backend logic at point of data retrieval.
    return Skills(id: json['id'], name: json['name'], Description: json['Description'], teachers: json['profiles']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'Description': Description,
      'teachers': teachers,
    };
  }
}



