import 'package:flutter/material.dart';
class UserModel {
   String? name;
   String? email;
   String? phone;
   String? uId;
   String? image;
   String? cover;
   String? bio;
  //late final bool isEmailVerified;
UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    //required this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];

    //isEmailVerified = json['isEmailVerified'] ;
  }

  Map<String, dynamic> toMap(){
  return{
    'name':name,
    'email':email,
    'phone':phone,
    'uId':uId,
    'image':image,
    'cover':cover,
    'bio':bio,
    //'isEmailVerified':isEmailVerified,

  };
}

}