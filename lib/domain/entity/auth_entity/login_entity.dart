/// id : 1
/// username : "kminchelle"
/// email : "kminchelle@yahoo.com"
/// firstName : "Jeanne"
/// lastName : "Halvorson"
/// gender : "female"
/// image : "https://robohash.org/autquiaut.png"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

class LoginEntity {
  LoginEntity({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
    this.token,});

   int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;




}