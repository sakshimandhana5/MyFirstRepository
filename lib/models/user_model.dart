import 'dart:core';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? placeName;
  String? scores;

  UserModel({this.email, this.firstName, this.lastName, this.uid, this.placeName});

// receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      placeName: map['placeName'],
      // scores: map['scores']
    );
  }

// sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'placeName':placeName,
      // 'scores':scores,
    };
  }
}
