import 'package:sadeem_project/domain/entity/auth_entity/login_entity.dart';

/// id : 1
/// username : "kminchelle"
/// email : "kminchelle@yahoo.com"
/// firstName : "Jeanne"
/// lastName : "Halvorson"
/// gender : "female"
/// image : "https://robohash.org/autquiaut.png"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

class LoginResponse {
  LoginResponse({
      this.id, 
      this.username, 
      this.email, 
      this.firstName, 
      this.lastName, 
      this.gender, 
      this.image, 
      this.token,});

  LoginResponse.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    token = json['token'];
  }
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;
LoginResponse copyWith({  int? id,
  String? username,
  String? email,
  String? firstName,
  String? lastName,
  String? gender,
  String? image,
  String? token,
}) => LoginResponse(  id: id ?? this.id,
  username: username ?? this.username,
  email: email ?? this.email,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  gender: gender ?? this.gender,
  image: image ?? this.image,
  token: token ?? this.token,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['gender'] = gender;
    map['image'] = image;
    map['token'] = token;
    return map;
  }

  LoginEntity toLoginEntity(){
    return LoginEntity(
      image: image,
      email: email,
      id: id,
      firstName: firstName,
      gender: gender,
      lastName: lastName,
      token: token,
      username: username,
    );
  }

}