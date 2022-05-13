import 'package:json_annotation/json_annotation.dart';

class UserM {
  String? name;
  String? profile;
  String? email;

  UserM({required this.name, required this.profile, required this.email});
  //flutter packages pub run build_runner build
  UserM.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        profile = json['profile'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'profile': profile};
  @override
  String toString() {
    // TODO: implement toString
    return 'userModel{name: $name, profile: $profile, email: $email,}';
  }
}
