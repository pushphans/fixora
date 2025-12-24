import 'dart:convert';

class RegisterRequestModel {
  String username;
  String email;
  String firstName;
  String lastName;
  String password;
  String confirmPassword;
  String accountType;

  RegisterRequestModel({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmPassword,
    required this.accountType,
  });

  RegisterRequestModel copyWith({
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? confirmPassword,
    String? accountType,
    String? long,
    String? lat,
  }) => RegisterRequestModel(
    username: username ?? this.username,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    accountType: accountType ?? this.accountType,
  );

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        username: json["username"] as String,
        email: json["email"] as String,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        password: json["password"] as String,
        confirmPassword: json["confirmPassword"] as String,
        accountType: json["accountType"] as String,
      );

  Map<String, dynamic> toMap() => {
    "username": username,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "confirmPassword": confirmPassword,
    "accountType": accountType,
  };
}
